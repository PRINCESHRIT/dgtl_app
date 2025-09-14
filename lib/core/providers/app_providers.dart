// DGTL Healthcare - Production Riverpod Providers
// State management for healthcare data with sync capabilities

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'dart:async';

import '../database/database_production.dart';
import '../api/api_client.dart';
import '../repositories/vitals_repository.dart';
import '../services/sync_service.dart';
import '../services/websocket_service.dart';
import '../models/auth_models.dart';

// Core Infrastructure Providers
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: IOSAccessibility.first_unlock_this_device,
    ),
  );
});

final databaseProvider = Provider<DgtlDatabase>((ref) {
  return DgtlDatabase();
});

// Auth Providers
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier(ref.read(secureStorageProvider));
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final authState = ref.watch(authStateProvider);
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.dgtl.healthcare/v1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
  ));
  
  // Add auth interceptor
  dio.interceptors.add(AuthInterceptor(ref));
  
  return ApiClient(dio);
});

// Repository Providers
final vitalsRepositoryProvider = Provider<VitalsRepository>((ref) {
  final database = ref.watch(databaseProvider);
  final apiClient = ref.watch(apiClientProvider);
  return VitalsRepositoryImpl(database, apiClient);
});

// Sync Service Provider
final syncServiceProvider = Provider<SyncService>((ref) {
  final repository = ref.watch(vitalsRepositoryProvider);
  return SyncService(repository, ref);
});

// WebSocket Service Provider
final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  final authState = ref.watch(authStateProvider);
  final repository = ref.watch(vitalsRepositoryProvider);
  
  return WebSocketService(
    authState.accessToken,
    repository,
    ref,
  );
});

// Data Stream Providers
final vitalsStreamProvider = StreamProvider.family<List<Vital>, VitalsFilter>((ref, filter) {
  final repository = ref.watch(vitalsRepositoryProvider);
  return repository.watchVitals(filter.patientId, type: filter.type);
});

final bpReadingsStreamProvider = StreamProvider.family<List<BPReading>, String>((ref, patientId) {
  final repository = ref.watch(vitalsRepositoryProvider);
  return repository.watchBPReadings(patientId);
});

final aiRecommendationsStreamProvider = StreamProvider.family<List<AIRecommendation>, String>((ref, patientId) {
  final repository = ref.watch(vitalsRepositoryProvider);
  return repository.watchRecommendations(patientId);
});

// Sync Status Provider
final syncStatusProvider = StateNotifierProvider<SyncStatusNotifier, SyncStatus>((ref) {
  return SyncStatusNotifier();
});

// Connectivity Provider
final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, ConnectivityState>((ref) {
  return ConnectivityNotifier();
});

// Filter classes
class VitalsFilter {
  final String patientId;
  final String? type;
  
  VitalsFilter({required this.patientId, this.type});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VitalsFilter && 
      other.patientId == patientId && 
      other.type == type;
      
  @override
  int get hashCode => patientId.hashCode ^ type.hashCode;
}

// Auth State Management
class AuthState {
  final String? accessToken;
  final String? refreshToken;
  final User? user;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  
  const AuthState({
    this.accessToken,
    this.refreshToken,
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
  });
  
  AuthState copyWith({
    String? accessToken,
    String? refreshToken,
    User? user,
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final FlutterSecureStorage _storage;
  Timer? _tokenRefreshTimer;
  
  AuthStateNotifier(this._storage) : super(const AuthState()) {
    _initializeAuth();
  }
  
  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');
      if (refreshToken != null) {
        await _refreshToken(refreshToken);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to initialize authentication: $e',
      );
    }
  }
  
  Future<void> login(String email, String password, {String? deviceId}) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // API call would go here
      // For now, simulate successful login
      await Future.delayed(const Duration(seconds: 1));
      
      const mockResponse = AuthResponse(
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
        tokenType: 'Bearer',
        expiresIn: 900, // 15 minutes
        user: User(
          id: 'user_123',
          email: 'patient@example.com',
          role: 'patient',
          patientId: 'patient_123',
        ),
      );
      
      await _handleAuthSuccess(mockResponse);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Login failed: $e',
      );
    }
  }
  
  Future<void> _handleAuthSuccess(AuthResponse response) async {
    // Store refresh token securely
    await _storage.write(key: 'refresh_token', value: response.refreshToken);
    
    state = state.copyWith(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      user: response.user,
      isAuthenticated: true,
      isLoading: false,
      error: null,
    );
    
    // Schedule token refresh
    _scheduleTokenRefresh(response.expiresIn);
  }
  
  /// Alias for login method to match expected API
  Future<void> signIn(String email, String password, {String? deviceId}) async {
    return login(email, password, deviceId: deviceId);
  }
  
  Future<void> _refreshToken(String refreshToken) async {
    try {
      // API call would go here
      await Future.delayed(const Duration(milliseconds: 500));
      
      const mockResponse = AuthResponse(
        accessToken: 'new_mock_access_token',
        refreshToken: 'new_mock_refresh_token',
        tokenType: 'Bearer',
        expiresIn: 900,
        user: User(
          id: 'user_123',
          email: 'patient@example.com',
          role: 'patient',
          patientId: 'patient_123',
        ),
      );
      
      await _handleAuthSuccess(mockResponse);
    } catch (e) {
      await logout();
    }
  }
  
  void _scheduleTokenRefresh(int expiresIn) {
    _tokenRefreshTimer?.cancel();
    
    // Refresh 5 minutes before expiry
    final refreshTime = Duration(seconds: expiresIn - 300);
    
    _tokenRefreshTimer = Timer(refreshTime, () {
      final refreshToken = state.refreshToken;
      if (refreshToken != null) {
        _refreshToken(refreshToken);
      }
    });
  }
  
  Future<void> logout() async {
    _tokenRefreshTimer?.cancel();
    await _storage.delete(key: 'refresh_token');
    
    state = const AuthState();
  }
  
  @override
  void dispose() {
    _tokenRefreshTimer?.cancel();
    super.dispose();
  }
}

// Sync Status Management
class SyncStatus {
  final bool isSyncing;
  final int pendingOperations;
  final DateTime? lastSync;
  final List<String> errors;
  final SyncResult? lastResult;
  
  const SyncStatus({
    this.isSyncing = false,
    this.pendingOperations = 0,
    this.lastSync,
    this.errors = const [],
    this.lastResult,
  });
  
  SyncStatus copyWith({
    bool? isSyncing,
    int? pendingOperations,
    DateTime? lastSync,
    List<String>? errors,
    SyncResult? lastResult,
  }) {
    return SyncStatus(
      isSyncing: isSyncing ?? this.isSyncing,
      pendingOperations: pendingOperations ?? this.pendingOperations,
      lastSync: lastSync ?? this.lastSync,
      errors: errors ?? this.errors,
      lastResult: lastResult ?? this.lastResult,
    );
  }
}

class SyncStatusNotifier extends StateNotifier<SyncStatus> {
  SyncStatusNotifier() : super(const SyncStatus());
  
  void startSync() {
    state = state.copyWith(isSyncing: true, errors: []);
  }
  
  void updatePendingCount(int count) {
    state = state.copyWith(pendingOperations: count);
  }
  
  void completedSync(SyncResult result) {
    state = state.copyWith(
      isSyncing: false,
      lastSync: DateTime.now(),
      lastResult: result,
      errors: result.errors,
    );
  }
  
  void syncError(String error) {
    state = state.copyWith(
      isSyncing: false,
      errors: [...state.errors, error],
    );
  }
}

// Connectivity Management
class ConnectivityState {
  final bool isOnline;
  final bool isWifiConnected;
  final DateTime? lastConnected;
  
  const ConnectivityState({
    this.isOnline = false,
    this.isWifiConnected = false,
    this.lastConnected,
  });
  
  ConnectivityState copyWith({
    bool? isOnline,
    bool? isWifiConnected,
    DateTime? lastConnected,
  }) {
    return ConnectivityState(
      isOnline: isOnline ?? this.isOnline,
      isWifiConnected: isWifiConnected ?? this.isWifiConnected,
      lastConnected: lastConnected ?? this.lastConnected,
    );
  }
}

class ConnectivityNotifier extends StateNotifier<ConnectivityState> {
  ConnectivityNotifier() : super(const ConnectivityState()) {
    _initializeConnectivity();
  }
  
  void _initializeConnectivity() {
    // Initialize connectivity monitoring
    // This would use connectivity_plus package in real implementation
    state = state.copyWith(
      isOnline: true,
      isWifiConnected: true,
      lastConnected: DateTime.now(),
    );
  }
  
  /// Start monitoring connectivity changes
  void startMonitoring() {
    // In a real implementation, this would set up connectivity listeners
    _initializeConnectivity();
  }
  
  void updateConnectivity({required bool isOnline, bool? isWifiConnected}) {
    state = state.copyWith(
      isOnline: isOnline,
      isWifiConnected: isWifiConnected,
      lastConnected: isOnline ? DateTime.now() : state.lastConnected,
    );
  }
}

// Auth Interceptor for API calls
class AuthInterceptor extends Interceptor {
  final Ref ref;
  
  AuthInterceptor(this.ref);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authState = ref.read(authStateProvider);
    
    if (authState.accessToken != null) {
      options.headers['Authorization'] = 'Bearer ${authState.accessToken}';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired, trigger refresh
      final authNotifier = ref.read(authStateProvider.notifier);
      final refreshToken = ref.read(authStateProvider).refreshToken;
      
      if (refreshToken != null) {
        // Queue this request to be retried after refresh
        authNotifier._refreshToken(refreshToken).then((_) {
          // Retry the original request
          final newToken = ref.read(authStateProvider).accessToken;
          if (newToken != null) {
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            handler.resolve(Response(
              requestOptions: err.requestOptions,
              statusCode: 200,
              data: {'retry': true},
            ));
            return;
          }
        });
      } else {
        // No refresh token, logout
        authNotifier.logout();
      }
    }
    
    handler.next(err);
  }
}

// Utility Providers for UI
final currentPatientIdProvider = Provider<String?>((ref) {
  final user = ref.watch(authStateProvider).user;
  return user?.patientId;
});

final isOfflineProvider = Provider<bool>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return !connectivity.isOnline;
});

final hasPendingSyncProvider = Provider<bool>((ref) {
  final syncStatus = ref.watch(syncStatusProvider);
  return syncStatus.pendingOperations > 0;
});

// Auto-sync Provider (triggers sync when coming online)
final autoSyncProvider = Provider<void>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  final syncService = ref.watch(syncServiceProvider);
  final syncStatus = ref.watch(syncStatusProvider);
  
  // Trigger sync when coming online and have pending operations
  ref.listen(connectivityProvider, (previous, next) {
    if (previous?.isOnline == false && 
        next.isOnline == true && 
        syncStatus.pendingOperations > 0) {
      syncService.syncPendingOperations();
    }
  });
});

// BP Analysis Provider (for real-time BP status)
final bpAnalysisProvider = Provider.family<BPAnalysis?, BPReadingInput>((ref, input) {
  if (input.systolic == 0 || input.diastolic == 0) return null;
  
  return BPAnalysis.fromReading(input.systolic, input.diastolic);
});

class BPReadingInput {
  final int systolic;
  final int diastolic;
  
  BPReadingInput({required this.systolic, required this.diastolic});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BPReadingInput && 
      other.systolic == systolic && 
      other.diastolic == diastolic;
      
  @override
  int get hashCode => systolic.hashCode ^ diastolic.hashCode;
}

class BPAnalysis {
  final String status;
  final String statusHindi;
  final Color statusColor;
  final String advice;
  final bool requiresImmediateAction;
  
  const BPAnalysis({
    required this.status,
    required this.statusHindi,
    required this.statusColor,
    required this.advice,
    required this.requiresImmediateAction,
  });
  
  factory BPAnalysis.fromReading(int systolic, int diastolic) {
    if (systolic < 90 || diastolic < 60) {
      return BPAnalysis(
        status: 'low',
        statusHindi: 'कम रक्तचाप',
        statusColor: Colors.blue,
        advice: 'नमक और पानी का सेवन बढ़ाएं',
        requiresImmediateAction: true,
      );
    } else if (systolic < 120 && diastolic < 80) {
      return BPAnalysis(
        status: 'normal',
        statusHindi: 'सामान्य',
        statusColor: Colors.green,
        advice: 'बहुत अच्छा! इसी तरह बनाए रखें',
        requiresImmediateAction: false,
      );
    } else if (systolic < 130 && diastolic < 80) {
      return BPAnalysis(
        status: 'elevated',
        statusHindi: 'बढ़ा हुआ',
        statusColor: Colors.yellow,
        advice: 'जीवनशैली में सुधार करें',
        requiresImmediateAction: false,
      );
    } else if (systolic < 140 || diastolic < 90) {
      return BPAnalysis(
        status: 'high_stage1',
        statusHindi: 'उच्च स्तर 1',
        statusColor: Colors.orange,
        advice: 'डॉक्टर से सलाह लें',
        requiresImmediateAction: false,
      );
    } else if (systolic < 180 || diastolic < 120) {
      return BPAnalysis(
        status: 'high_stage2',
        statusHindi: 'उच्च स्तर 2',
        statusColor: Colors.red,
        advice: 'तुरंत चिकित्सक से मिलें',
        requiresImmediateAction: true,
      );
    } else {
      return BPAnalysis(
        status: 'crisis',
        statusHindi: 'अति गंभीर',
        statusColor: Colors.red[900]!,
        advice: 'आपातकालीन सहायता लें',
        requiresImmediateAction: true,
      );
    }
  }
}
