// DGTL Healthcare - Production Repository Pattern
// Repository layer for vitals data with sync capabilities

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/vitals_tables.dart';
import '../database/database_production.dart';
import '../api/api_client.dart';

// Repository interfaces
abstract class VitalsRepository {
  Stream<List<Vital>> watchVitals(String patientId, {String? type});
  Stream<List<BPReading>> watchBPReadings(String patientId);
  Stream<List<AIRecommendation>> watchRecommendations(String patientId);
  
  Future<void> addVital(VitalCreate vital);
  Future<void> addBPReading(BPReadingCreate reading);
  Future<void> updateVital(String id, VitalUpdate update);
  
  Future<SyncResult> syncPendingOperations();
  Future<void> applyAIRecommendation(AIRecommendation recommendation);
}

// Data classes for API operations
class VitalCreate {
  final String clientId;
  final String patientId;
  final String type;
  final double value;
  final String unit;
  final String? notes;
  final DateTime recordedAt;
  
  VitalCreate({
    required this.clientId,
    required this.patientId,
    required this.type,
    required this.value,
    required this.unit,
    this.notes,
    required this.recordedAt,
  });
  
  Map<String, dynamic> toJson() => {
    'client_id': clientId,
    'patient_id': patientId,
    'type': type,
    'value': value,
    'unit': unit,
    'notes': notes,
    'recorded_at': recordedAt.toIso8601String(),
  };
}

class VitalUpdate {
  final double? value;
  final String? notes;
  final int version;
  
  VitalUpdate({this.value, this.notes, required this.version});
  
  Map<String, dynamic> toJson() => {
    if (value != null) 'value': value,
    if (notes != null) 'notes': notes,
    'version': version,
  };
}

class BPReadingCreate {
  final String clientId;
  final String patientId;
  final int systolic;
  final int diastolic;
  final int? heartRate;
  final String? position;
  final String? arm;
  final double? fatigueLevel;
  final List<String>? symptoms;
  final DateTime recordedAt;
  
  BPReadingCreate({
    required this.clientId,
    required this.patientId,
    required this.systolic,
    required this.diastolic,
    this.heartRate,
    this.position,
    this.arm,
    this.fatigueLevel,
    this.symptoms,
    required this.recordedAt,
  });
  
  Map<String, dynamic> toJson() => {
    'client_id': clientId,
    'patient_id': patientId,
    'systolic': systolic,
    'diastolic': diastolic,
    'heart_rate': heartRate,
    'position': position,
    'arm': arm,
    'fatigue_level': fatigueLevel,
    'symptoms': symptoms,
    'recorded_at': recordedAt.toIso8601String(),
  };
}

class SyncResult {
  final int successful;
  final int failed;
  final int conflicts;
  final List<String> errors;
  
  SyncResult({
    required this.successful,
    required this.failed,
    required this.conflicts,
    required this.errors,
  });
}

// Sync operation types
enum SyncOpType {
  createVital('create_vital'),
  updateVital('update_vital'),
  createBPReading('create_bp_reading'),
  updateBPReading('update_bp_reading'),
  createAssessment('create_assessment');
  
  const SyncOpType(this.value);
  final String value;
}

class SyncOperation {
  final String clientId;
  final SyncOpType type;
  final String entityType;
  final String? entityId;
  final Map<String, dynamic> payload;
  final DateTime createdAt;
  
  SyncOperation({
    required this.clientId,
    required this.type,
    required this.entityType,
    this.entityId,
    required this.payload,
    required this.createdAt,
  });
}

// Production Repository Implementation
class VitalsRepositoryImpl implements VitalsRepository {
  final DgtlDatabase _database;
  final ApiClient _apiClient;
  final _uuid = const Uuid();
  
  VitalsRepositoryImpl(this._database, this._apiClient);
  
  @override
  Stream<List<Vital>> watchVitals(String patientId, {String? type}) {
    var query = _database.select(_database.vitals)
      ..where((v) => v.patientId.equals(patientId))
      ..orderBy([(v) => OrderingTerm.desc(v.recordedAt)]);
      
    if (type != null) {
      query = query..where((v) => v.type.equals(type));
    }
    
    return query.watch();
  }
  
  @override
  Stream<List<BPReading>> watchBPReadings(String patientId) {
    return (_database.select(_database.bPReadings)
      ..where((bp) => bp.patientId.equals(patientId))
      ..orderBy([(bp) => OrderingTerm.desc(bp.recordedAt)])
      ..limit(50)).watch();
  }
  
  @override
  Stream<List<AIRecommendation>> watchRecommendations(String patientId) {
    return (_database.select(_database.aIRecommendations)
      ..where((rec) => rec.patientId.equals(patientId))
      ..where((rec) => rec.validUntil.isBiggerThanValue(DateTime.now()))
      ..orderBy([(rec) => OrderingTerm.desc(rec.createdAt)])).watch();
  }
  
  @override
  Future<void> addVital(VitalCreate vital) async {
    final id = _uuid.v4();
    
    // Insert into local database immediately (optimistic UI)
    await _database.into(_database.vitals).insert(
      VitalsCompanion.insert(
        id: id,
        clientId: vital.clientId,
        patientId: vital.patientId,
        type: vital.type,
        value: vital.value,
        unit: vital.unit,
        notes: Value(vital.notes),
        recordedAt: vital.recordedAt,
        synced: false,
        deviceId: Value(await _getDeviceId()),
      ),
    );
    
    // Add sync operation to queue
    await _enqueueSyncOperation(
      SyncOperation(
        clientId: vital.clientId,
        type: SyncOpType.createVital,
        entityType: 'vital',
        entityId: id,
        payload: vital.toJson(),
        createdAt: DateTime.now(),
      ),
    );
    
    // Trigger immediate sync if online
    unawaited(_attemptImmediateSync());
  }
  
  @override
  Future<void> addBPReading(BPReadingCreate reading) async {
    final id = _uuid.v4();
    final status = _calculateBPStatus(reading.systolic, reading.diastolic);
    
    // Insert into local database
    await _database.into(_database.bPReadings).insert(
      BPReadingsCompanion.insert(
        id: id,
        clientId: reading.clientId,
        patientId: reading.patientId,
        systolic: reading.systolic,
        diastolic: reading.diastolic,
        heartRate: Value(reading.heartRate),
        status: status,
        position: Value(reading.position),
        arm: Value(reading.arm),
        fatigueLevel: Value(reading.fatigueLevel),
        symptoms: Value(reading.symptoms?.join(',')),
        recordedAt: reading.recordedAt,
        synced: false,
      ),
    );
    
    // Queue for sync
    await _enqueueSyncOperation(
      SyncOperation(
        clientId: reading.clientId,
        type: SyncOpType.createBPReading,
        entityType: 'bp_reading',
        entityId: id,
        payload: reading.toJson(),
        createdAt: DateTime.now(),
      ),
    );
    
    unawaited(_attemptImmediateSync());
  }
  
  @override
  Future<void> updateVital(String id, VitalUpdate update) async {
    final existing = await (_database.select(_database.vitals)
      ..where((v) => v.id.equals(id))).getSingleOrNull();
      
    if (existing == null) throw Exception('Vital not found: $id');
    
    // Update local record
    await (_database.update(_database.vitals)
      ..where((v) => v.id.equals(id))).write(
      VitalsCompanion(
        value: Value(update.value ?? existing.value),
        notes: Value(update.notes ?? existing.notes),
        version: Value(existing.version + 1),
        synced: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
    
    // Queue sync operation
    await _enqueueSyncOperation(
      SyncOperation(
        clientId: _uuid.v4(), // New client ID for update
        type: SyncOpType.updateVital,
        entityType: 'vital',
        entityId: id,
        payload: update.toJson(),
        createdAt: DateTime.now(),
      ),
    );
  }
  
  @override
  Future<SyncResult> syncPendingOperations() async {
    final pendingOps = await (_database.select(_database.syncQueue)
      ..where((sq) => sq.status.equals('pending'))
      ..orderBy([(sq) => OrderingTerm.asc(sq.createdAt)])
      ..limit(20)).get();
      
    if (pendingOps.isEmpty) {
      return SyncResult(successful: 0, failed: 0, conflicts: 0, errors: []);
    }
    
    int successful = 0;
    int failed = 0;
    int conflicts = 0;
    final errors = <String>[];
    
    for (final op in pendingOps) {
      try {
        // Mark as in progress
        await (_database.update(_database.syncQueue)
          ..where((sq) => sq.id.equals(op.id))).write(
          const SyncQueueCompanion(
            status: Value('in_progress'),
            updatedAt: Value.absent(),
          ),
        );
        
        final result = await _syncSingleOperation(op);
        
        if (result.success) {
          successful++;
          // Mark as completed and update local record if needed
          await _completeSyncOperation(op, result.data);
        } else if (result.isConflict) {
          conflicts++;
          await _handleSyncConflict(op, result);
        } else {
          failed++;
          errors.add('${op.opType}: ${result.error}');
          await _handleSyncFailure(op, result.error!);
        }
      } catch (e) {
        failed++;
        errors.add('${op.opType}: $e');
        await _handleSyncFailure(op, e.toString());
      }
    }
    
    return SyncResult(
      successful: successful,
      failed: failed,
      conflicts: conflicts,
      errors: errors,
    );
  }
  
  @override
  Future<void> applyRemoteChange(AIRecommendation recommendation) async {
    // Insert or update AI recommendation from WebSocket/server push
    await _database.into(_database.aIRecommendations).insertOnConflictUpdate(
      AIRecommendationsCompanion.insert(
        id: recommendation.id,
        patientId: recommendation.patientId,
        type: recommendation.type,
        title: recommendation.title,
        content: recommendation.content,
        priority: recommendation.priority,
        confidence: recommendation.confidence,
        triggers: Value(recommendation.triggers?.join(',')),
        relatedVitals: Value(recommendation.relatedVitals?.join(',')),
        validUntil: Value(recommendation.validUntil),
        synced: true,
        acknowledged: recommendation.acknowledged,
      ),
    );
  }
  
  // Helper methods
  Future<void> _enqueueSyncOperation(SyncOperation op) async {
    await _database.into(_database.syncQueue).insert(
      SyncQueueCompanion.insert(
        opType: op.type.value,
        entityType: op.entityType,
        entityId: Value(op.entityId),
        clientId: op.clientId,
        payload: jsonEncode(op.payload),
        createdAt: op.createdAt,
      ),
    );
  }
  
  Future<void> _attemptImmediateSync() async {
    // Only sync if we have connectivity and not already syncing
    if (await _hasConnectivity() && !_isSyncing) {
      unawaited(syncPendingOperations());
    }
  }
  
  bool _isSyncing = false;
  
  Future<SyncOperationResult> _syncSingleOperation(SyncQueueData op) async {
    final payload = jsonDecode(op.payload);
    
    try {
      switch (SyncOpType.values.firstWhere((e) => e.value == op.opType)) {
        case SyncOpType.createVital:
          final response = await _apiClient.createVital(
            payload['patient_id'],
            VitalCreate.fromJson(payload),
            idempotencyKey: op.clientId,
          );
          return SyncOperationResult.success(response.data);
          
        case SyncOpType.createBPReading:
          final response = await _apiClient.createBPReading(
            payload['patient_id'],
            BPReadingCreate.fromJson(payload),
            idempotencyKey: op.clientId,
          );
          return SyncOperationResult.success(response.data);
          
        case SyncOpType.updateVital:
          final response = await _apiClient.updateVital(
            payload['patient_id'],
            op.entityId!,
            VitalUpdate.fromJson(payload),
            idempotencyKey: op.clientId,
          );
          return SyncOperationResult.success(response.data);
          
        default:
          return SyncOperationResult.error('Unknown operation type: ${op.opType}');
      }
    } on ApiException catch (e) {
      if (e.statusCode == 409) {
        return SyncOperationResult.conflict(e.message, e.data);
      }
      return SyncOperationResult.error(e.message);
    }
  }
  
  Future<void> _completeSyncOperation(SyncQueueData op, dynamic serverData) async {
    // Update local record with server data
    if (op.entityType == 'vital' && serverData != null) {
      await (_database.update(_database.vitals)
        ..where((v) => v.id.equals(op.entityId!))).write(
        VitalsCompanion(
          synced: const Value(true),
          version: Value(serverData['version']),
        ),
      );
    }
    
    // Mark sync operation as completed
    await (_database.delete(_database.syncQueue)
      ..where((sq) => sq.id.equals(op.id))).go();
  }
  
  Future<void> _handleSyncConflict(SyncQueueData op, SyncOperationResult result) async {
    // Implement conflict resolution strategy
    // For now, server wins - update local record and mark as resolved
    
    if (op.entityType == 'vital' && result.conflictData != null) {
      final serverVital = result.conflictData!;
      await (_database.update(_database.vitals)
        ..where((v) => v.id.equals(op.entityId!))).write(
        VitalsCompanion(
          value: Value(serverVital['value']),
          notes: Value(serverVital['notes']),
          version: Value(serverVital['version']),
          synced: const Value(true),
          updatedAt: Value(DateTime.parse(serverVital['updated_at'])),
        ),
      );
    }
    
    // Remove from sync queue
    await (_database.delete(_database.syncQueue)
      ..where((sq) => sq.id.equals(op.id))).go();
  }
  
  Future<void> _handleSyncFailure(SyncQueueData op, String error) async {
    final newAttempts = op.attempts + 1;
    final maxAttempts = 5;
    
    if (newAttempts >= maxAttempts) {
      // Mark as permanently failed
      await (_database.update(_database.syncQueue)
        ..where((sq) => sq.id.equals(op.id))).write(
        SyncQueueCompanion(
          status: const Value('failed'),
          lastError: Value(error),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } else {
      // Schedule retry with exponential backoff
      final backoff = _calculateBackoff(newAttempts);
      await (_database.update(_database.syncQueue)
        ..where((sq) => sq.id.equals(op.id))).write(
        SyncQueueCompanion(
          status: const Value('pending'),
          attempts: Value(newAttempts),
          nextAttemptAt: Value(DateTime.now().add(backoff)),
          lastError: Value(error),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }
  
  Duration _calculateBackoff(int attempts) {
    final base = 2; // seconds
    final jitter = Random().nextInt(1000);
    final seconds = pow(2, attempts).clamp(1, 300).toInt();
    return Duration(seconds: seconds, milliseconds: jitter);
  }
  
  String _calculateBPStatus(int systolic, int diastolic) {
    if (systolic < 90 || diastolic < 60) return 'low';
    if (systolic < 120 && diastolic < 80) return 'normal';
    if (systolic < 130 && diastolic < 80) return 'elevated';
    if (systolic < 140 || diastolic < 90) return 'high_stage1';
    if (systolic < 180 || diastolic < 120) return 'high_stage2';
    return 'crisis';
  }
  
  Future<bool> _hasConnectivity() async {
    // Implement connectivity check
    return true; // Placeholder
  }
  
  Future<String> _getDeviceId() async {
    // Get unique device identifier
    return 'device_123'; // Placeholder
  }
}

// Sync result classes
class SyncOperationResult {
  final bool success;
  final String? error;
  final dynamic data;
  final dynamic conflictData;
  
  SyncOperationResult._({
    required this.success,
    this.error,
    this.data,
    this.conflictData,
  });
  
  factory SyncOperationResult.success(dynamic data) =>
      SyncOperationResult._(success: true, data: data);
      
  factory SyncOperationResult.error(String error) =>
      SyncOperationResult._(success: false, error: error);
      
  factory SyncOperationResult.conflict(String error, dynamic conflictData) =>
      SyncOperationResult._(
        success: false,
        error: error,
        conflictData: conflictData,
      );
      
  bool get isConflict => conflictData != null;
}
