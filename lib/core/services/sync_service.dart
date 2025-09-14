// DGTL Healthcare - Production Sync Service
// Background synchronization with exponential backoff and conflict resolution

import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import '../repositories/vitals_repository.dart';
import '../providers/app_providers.dart';

class SyncService {
  final VitalsRepository _repository;
  final Ref _ref;
  
  Timer? _periodicSyncTimer;
  bool _isSyncing = false;
  
  SyncService(this._repository, this._ref) {
    _initializeBackgroundSync();
  }
  
  void _initializeBackgroundSync() {
    // Register background task for offline sync
    Workmanager().initialize(
      _callbackDispatcher,
      isInDebugMode: false, // Set to false in production
    );
    
    // Schedule periodic sync every 15 minutes
    Workmanager().registerPeriodicTask(
      "vitals_sync",
      "syncVitals",
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );
    
    // Start periodic foreground sync when app is active
    _startPeriodicSync();
  }
  
  void _startPeriodicSync() {
    _periodicSyncTimer?.cancel();
    
    _periodicSyncTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) async {
        final isOnline = _ref.read(connectivityProvider).isOnline;
        final hasPending = _ref.read(syncStatusProvider).pendingOperations > 0;
        
        if (isOnline && hasPending && !_isSyncing) {
          await syncPendingOperations();
        }
      },
    );
  }
  
  Future<SyncResult> syncPendingOperations() async {
    if (_isSyncing) {
      return SyncResult(successful: 0, failed: 0, conflicts: 0, errors: ['Sync already in progress']);
    }
    
    _isSyncing = true;
    final syncNotifier = _ref.read(syncStatusProvider.notifier);
    
    try {
      syncNotifier.startSync();
      
      final result = await _repository.syncPendingOperations();
      
      syncNotifier.completedSync(result);
      
      // Trigger WebSocket reconnection if we had successful syncs
      if (result.successful > 0) {
        final wsService = _ref.read(webSocketServiceProvider);
        wsService.ensureConnected();
      }
      
      return result;
    } catch (e) {
      final errorResult = SyncResult(
        successful: 0,
        failed: 1,
        conflicts: 0,
        errors: ['Sync service error: $e'],
      );
      
      syncNotifier.completedSync(errorResult);
      return errorResult;
    } finally {
      _isSyncing = false;
    }
  }
  
  Future<void> forceSyncNow() async {
    await syncPendingOperations();
  }
  
  void onConnectivityChanged(bool isOnline) {
    if (isOnline) {
      // Immediately sync when connectivity is restored
      Timer(const Duration(seconds: 2), () {
        syncPendingOperations();
      });
    }
  }
  
  void dispose() {
    _periodicSyncTimer?.cancel();
  }
}

// Background task dispatcher
@pragma('vm:entry-point')
void _callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'syncVitals':
        return await _performBackgroundSync();
      default:
        return false;
    }
  });
}

Future<bool> _performBackgroundSync() async {
  try {
    // Initialize minimal required services for background sync
    final container = ProviderContainer();
    final syncService = container.read(syncServiceProvider);
    
    final result = await syncService.syncPendingOperations();
    
    // Return true if sync was successful (no failures)
    return result.failed == 0;
  } catch (e) {
    print('Background sync failed: $e');
    return false;
  }
}

// Sync conflict resolution strategies
enum ConflictResolutionStrategy {
  serverWins,
  clientWins,
  lastWriterWins,
  mergeValues,
  requiresManualResolution,
}

class ConflictResolver {
  static ConflictResolutionStrategy getStrategyForEntity(String entityType) {
    switch (entityType) {
      case 'vital':
        return ConflictResolutionStrategy.lastWriterWins;
      case 'bp_reading':
        return ConflictResolutionStrategy.serverWins;
      case 'patient':
        return ConflictResolutionStrategy.mergeValues;
      default:
        return ConflictResolutionStrategy.requiresManualResolution;
    }
  }
  
  static Map<String, dynamic> resolveConflict({
    required String entityType,
    required Map<String, dynamic> clientData,
    required Map<String, dynamic> serverData,
    ConflictResolutionStrategy? strategy,
  }) {
    final resolveStrategy = strategy ?? getStrategyForEntity(entityType);
    
    switch (resolveStrategy) {
      case ConflictResolutionStrategy.serverWins:
        return serverData;
        
      case ConflictResolutionStrategy.clientWins:
        return clientData;
        
      case ConflictResolutionStrategy.lastWriterWins:
        final clientTime = DateTime.parse(clientData['updated_at'] ?? clientData['created_at']);
        final serverTime = DateTime.parse(serverData['updated_at'] ?? serverData['created_at']);
        return clientTime.isAfter(serverTime) ? clientData : serverData;
        
      case ConflictResolutionStrategy.mergeValues:
        return _mergeObjects(clientData, serverData);
        
      case ConflictResolutionStrategy.requiresManualResolution:
        throw ConflictRequiresManualResolution(
          clientData: clientData,
          serverData: serverData,
          entityType: entityType,
        );
    }
  }
  
  static Map<String, dynamic> _mergeObjects(
    Map<String, dynamic> client,
    Map<String, dynamic> server,
  ) {
    final merged = Map<String, dynamic>.from(server);
    
    // Merge non-conflicting fields from client
    client.forEach((key, value) {
      if (!server.containsKey(key)) {
        merged[key] = value;
      } else if (key == 'version') {
        // Always use higher version
        merged[key] = max(client[key] ?? 0, server[key] ?? 0);
      } else if (key.endsWith('_at') && value != null) {
        // For timestamps, use the later one
        final clientTime = DateTime.tryParse(value.toString());
        final serverTime = DateTime.tryParse(server[key]?.toString() ?? '');
        
        if (clientTime != null && serverTime != null) {
          merged[key] = clientTime.isAfter(serverTime) ? value : server[key];
        }
      }
    });
    
    return merged;
  }
}

class ConflictRequiresManualResolution implements Exception {
  final Map<String, dynamic> clientData;
  final Map<String, dynamic> serverData;
  final String entityType;
  
  ConflictRequiresManualResolution({
    required this.clientData,
    required this.serverData,
    required this.entityType,
  });
  
  @override
  String toString() =>
      'Manual resolution required for $entityType conflict';
}

// Batch sync optimization
class BatchSyncOptimizer {
  static const int maxBatchSize = 50;
  static const Duration batchWindow = Duration(seconds: 30);
  
  final List<SyncOperation> _pendingBatch = [];
  Timer? _batchTimer;
  
  void addOperation(SyncOperation operation) {
    _pendingBatch.add(operation);
    
    if (_pendingBatch.length >= maxBatchSize) {
      _flushBatch();
    } else if (_batchTimer == null) {
      _batchTimer = Timer(batchWindow, _flushBatch);
    }
  }
  
  void _flushBatch() {
    if (_pendingBatch.isNotEmpty) {
      // Process batch
      final batch = List<SyncOperation>.from(_pendingBatch);
      _pendingBatch.clear();
      
      // Group by patient and operation type for optimal API calls
      final grouped = _groupOperations(batch);
      
      // Process each group
      for (final group in grouped) {
        _processBatchGroup(group);
      }
    }
    
    _batchTimer?.cancel();
    _batchTimer = null;
  }
  
  List<List<SyncOperation>> _groupOperations(List<SyncOperation> operations) {
    final groups = <String, List<SyncOperation>>{};
    
    for (final op in operations) {
      final key = '${op.entityType}_${op.type.value}';
      groups.putIfAbsent(key, () => []).add(op);
    }
    
    return groups.values.toList();
  }
  
  void _processBatchGroup(List<SyncOperation> group) {
    // This would integrate with the repository's batch sync methods
    // Implementation depends on specific API design
  }
  
  void dispose() {
    _batchTimer?.cancel();
    _pendingBatch.clear();
  }
}

// Network quality adaptation
class NetworkQualityAdapter {
  static const Duration _measurementWindow = Duration(seconds: 10);
  
  double _averageLatency = 0;
  int _successfulRequests = 0;
  int _failedRequests = 0;
  DateTime _lastMeasurement = DateTime.now();
  
  NetworkQuality get currentQuality {
    final now = DateTime.now();
    if (now.difference(_lastMeasurement) > _measurementWindow) {
      _resetMeasurements();
    }
    
    final successRate = _totalRequests == 0 
        ? 1.0 
        : _successfulRequests / _totalRequests;
        
    if (successRate < 0.5 || _averageLatency > 5000) {
      return NetworkQuality.poor;
    } else if (successRate < 0.8 || _averageLatency > 2000) {
      return NetworkQuality.fair;
    } else if (_averageLatency > 1000) {
      return NetworkQuality.good;
    } else {
      return NetworkQuality.excellent;
    }
  }
  
  int get _totalRequests => _successfulRequests + _failedRequests;
  
  void recordRequest({
    required bool success,
    required Duration latency,
  }) {
    if (success) {
      _successfulRequests++;
      _averageLatency = (_averageLatency * (_successfulRequests - 1) + latency.inMilliseconds) / _successfulRequests;
    } else {
      _failedRequests++;
    }
  }
  
  void _resetMeasurements() {
    _averageLatency = 0;
    _successfulRequests = 0;
    _failedRequests = 0;
    _lastMeasurement = DateTime.now();
  }
  
  SyncConfiguration getOptimalSyncConfig() {
    switch (currentQuality) {
      case NetworkQuality.poor:
        return SyncConfiguration(
          maxBatchSize: 10,
          syncInterval: const Duration(minutes: 30),
          retryDelay: const Duration(seconds: 60),
          maxRetries: 3,
        );
      case NetworkQuality.fair:
        return SyncConfiguration(
          maxBatchSize: 25,
          syncInterval: const Duration(minutes: 15),
          retryDelay: const Duration(seconds: 30),
          maxRetries: 5,
        );
      case NetworkQuality.good:
        return SyncConfiguration(
          maxBatchSize: 50,
          syncInterval: const Duration(minutes: 5),
          retryDelay: const Duration(seconds: 10),
          maxRetries: 7,
        );
      case NetworkQuality.excellent:
        return SyncConfiguration(
          maxBatchSize: 100,
          syncInterval: const Duration(minutes: 2),
          retryDelay: const Duration(seconds: 5),
          maxRetries: 10,
        );
    }
  }
}

enum NetworkQuality { poor, fair, good, excellent }

class SyncConfiguration {
  final int maxBatchSize;
  final Duration syncInterval;
  final Duration retryDelay;
  final int maxRetries;
  
  SyncConfiguration({
    required this.maxBatchSize,
    required this.syncInterval,
    required this.retryDelay,
    required this.maxRetries,
  });
}
