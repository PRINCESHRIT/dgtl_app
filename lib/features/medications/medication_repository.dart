import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/api/api_client.dart';
import '../../../core/models/medication_models.dart';
import '../../../core/models/notification_models.dart';
import '../../../core/providers/api_provider.dart';
import '../notifications/notification_service.dart';

part 'medication_repository.g.dart';

/// Medication Repository - Manages medications and adherence
@riverpod
class MedicationRepository extends _$MedicationRepository {
  late ApiClient _apiClient;
  late String _currentUserId;
  late Box<Medication> _medicationBox;
  late Box<MedicationAdherence> _adherenceBox;

  @override
  Future<List<Medication>> build() async {
    _apiClient = ref.read(apiClientProvider);
    _currentUserId = ref.read(currentUserIdProvider);
    
    // Initialize Hive boxes for offline storage
    _medicationBox = await Hive.openBox<Medication>('medications');
    _adherenceBox = await Hive.openBox<MedicationAdherence>('adherence');
    
    // Load medications from backend and cache locally
    return await _loadMedications();
  }

  /// Load medications from backend
  Future<List<Medication>> _loadMedications() async {
    try {
      final response = await _apiClient.getUserMedications(_currentUserId);
      if (response.success && response.data != null) {
        // Cache medications locally
        await _medicationBox.clear();
        for (final medication in response.data!) {
          await _medicationBox.put(medication.id, medication);
        }
        return response.data!;
      }
      
      // Fallback to cached data
      return _medicationBox.values.toList();
    } catch (e) {
      // Return cached medications on error
      return _medicationBox.values.toList();
    }
  }

  /// Add new medication
  Future<void> addMedication(Medication medication) async {
    try {
      final response = await _apiClient.addMedication(medication);
      
      if (response.success && response.data != null) {
        // Cache locally
        await _medicationBox.put(medication.id, response.data!);
        
        // Schedule notifications for this medication
        await _scheduleMedicationNotifications(response.data!);
        
        // Update state
        final current = state.value ?? [];
        state = AsyncValue.data([...current, response.data!]);
      } else {
        throw Exception(response.message ?? 'Failed to add medication');
      }
    } catch (e) {
      // Add to local cache for offline support
      await _medicationBox.put(medication.id, medication);
      await _scheduleMedicationNotifications(medication);
      
      final current = state.value ?? [];
      state = AsyncValue.data([...current, medication]);
      
      // TODO: Queue for sync when online
      rethrow;
    }
  }

  /// Update medication
  Future<void> updateMedication(Medication medication) async {
    try {
      final response = await _apiClient.updateMedication(medication);
      
      if (response.success && response.data != null) {
        // Update local cache
        await _medicationBox.put(medication.id, response.data!);
        
        // Reschedule notifications
        await _cancelMedicationNotifications(medication.id);
        await _scheduleMedicationNotifications(response.data!);
        
        // Update state
        final current = state.value ?? [];
        final updated = current.map((med) {
          return med.id == medication.id ? response.data! : med;
        }).toList();
        state = AsyncValue.data(updated);
      }
    } catch (e) {
      // Update locally for offline support
      await _medicationBox.put(medication.id, medication);
      await _cancelMedicationNotifications(medication.id);
      await _scheduleMedicationNotifications(medication);
      
      final current = state.value ?? [];
      final updated = current.map((med) {
        return med.id == medication.id ? medication : med;
      }).toList();
      state = AsyncValue.data(updated);
      
      rethrow;
    }
  }

  /// Delete medication
  Future<void> deleteMedication(String medicationId) async {
    try {
      final response = await _apiClient.deleteMedication(_currentUserId, medicationId);
      
      if (response.success) {
        // Remove from local cache
        await _medicationBox.delete(medicationId);
        
        // Cancel notifications
        await _cancelMedicationNotifications(medicationId);
        
        // Update state
        final current = state.value ?? [];
        final updated = current.where((med) => med.id != medicationId).toList();
        state = AsyncValue.data(updated);
      }
    } catch (e) {
      // Remove locally for offline support
      await _medicationBox.delete(medicationId);
      await _cancelMedicationNotifications(medicationId);
      
      final current = state.value ?? [];
      final updated = current.where((med) => med.id != medicationId).toList();
      state = AsyncValue.data(updated);
      
      rethrow;
    }
  }

  /// Log medication adherence
  Future<void> logMedicationTaken({
    required String medicationId,
    required DateTime scheduledTime,
    required bool taken,
    String? reason,
    String? notes,
  }) async {
    final adherence = MedicationAdherence(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      medicationId: medicationId,
      userId: _currentUserId,
      scheduledTime: scheduledTime,
      actualTime: taken ? DateTime.now() : null,
      taken: taken,
      reason: reason,
      notes: notes,
      adherenceScore: taken ? 1.0 : 0.0,
    );

    try {
      final response = await _apiClient.logMedicationAdherence(adherence);
      
      if (response.success) {
        // Cache locally
        await _adherenceBox.put(adherence.id, adherence);
      }
    } catch (e) {
      // Cache locally for offline support
      await _adherenceBox.put(adherence.id, adherence);
    }

    // Update adherence statistics
    ref.invalidate(medicationAdherenceStatsProvider);
  }

  /// Schedule medication notifications
  Future<void> _scheduleMedicationNotifications(Medication medication) async {
    if (!medication.isActive) return;

    for (final timeStr in medication.timesPerDay) {
      final time = _parseTime(timeStr);
      final now = DateTime.now();
      var scheduledDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      // If time has passed today, schedule for tomorrow
      if (scheduledDateTime.isBefore(now)) {
        scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
      }

      final notification = MedicationNotification(
        id: '${medication.id}_$timeStr',
        medicationId: medication.id,
        medicationName: medication.name,
        dosage: medication.dosage,
        scheduledTime: scheduledDateTime,
        type: NotificationType.medication,
        title: 'दवा का समय हो गया',
        body: '${medication.name} (${medication.dosage}) लेने का समय है',
        isRepeating: true,
        cronExpression: _generateCronExpression(time, medication.frequency),
        isActive: true,
        createdAt: DateTime.now(),
      );

      await NotificationService.scheduleMedicationReminder(
        notification: notification,
      );
    }
  }

  /// Cancel medication notifications
  Future<void> _cancelMedicationNotifications(String medicationId) async {
    // Cancel all notifications for this medication
    final pendingNotifications = await NotificationService.getPendingNotifications();
    
    for (final pending in pendingNotifications) {
      if (pending.payload?.contains(medicationId) == true) {
        await NotificationService.cancelNotification(pending.id.toString());
      }
    }
  }

  /// Parse time string to DateTime
  DateTime _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    return DateTime(2000, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
  }

  /// Generate cron expression for medication frequency
  String _generateCronExpression(DateTime time, MedicationFrequency frequency) {
    final minute = time.minute;
    final hour = time.hour;

    switch (frequency) {
      case MedicationFrequency.daily:
        return '$minute $hour * * *';
      case MedicationFrequency.weekly:
        return '$minute $hour * * 1'; // Every Monday
      case MedicationFrequency.monthly:
        return '$minute $hour 1 * *'; // 1st of every month
      default:
        return '$minute $hour * * *'; // Default to daily
    }
  }

  /// Refresh medications from backend
  Future<void> refreshMedications() async {
    state = const AsyncValue.loading();
    try {
      final medications = await _loadMedications();
      state = AsyncValue.data(medications);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

/// Active medications provider
@riverpod
List<Medication> activeMedicationsProvider(ActiveMedicationsProviderRef ref) {
  final medications = ref.watch(medicationRepositoryProvider);
  
  return medications.when(
    loading: () => [],
    error: (_, __) => [],
    data: (meds) => meds.where((med) => med.isActive).toList(),
  );
}

/// Today's medication schedule provider
@riverpod
List<Map<String, dynamic>> todaysMedicationScheduleProvider(
    TodaysMedicationScheduleProviderRef ref) {
  final activeMedications = ref.watch(activeMedicationsProvider);
  final now = DateTime.now();
  final schedule = <Map<String, dynamic>>[];

  for (final medication in activeMedications) {
    for (final timeStr in medication.timesPerDay) {
      final time = _parseTimeStatic(timeStr);
      final scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      schedule.add({
        'medication': medication,
        'scheduledTime': scheduledTime,
        'timeString': timeStr,
        'isPast': scheduledTime.isBefore(now),
        'isWithinHour': scheduledTime.difference(now).inMinutes.abs() <= 60,
      });
    }
  }

  // Sort by time
  schedule.sort((a, b) => 
      (a['scheduledTime'] as DateTime).compareTo(b['scheduledTime'] as DateTime));

  return schedule;
}

/// Medication adherence statistics provider
@riverpod
Future<Map<String, dynamic>> medicationAdherenceStatsProvider(
    MedicationAdherenceStatsProviderRef ref) async {
  // This would typically calculate from the adherence box
  final adherenceBox = await Hive.openBox<MedicationAdherence>('adherence');
  final adherenceRecords = adherenceBox.values.toList();
  
  final last7Days = DateTime.now().subtract(const Duration(days: 7));
  final recentRecords = adherenceRecords
      .where((record) => record.scheduledTime.isAfter(last7Days))
      .toList();

  if (recentRecords.isEmpty) {
    return {
      'adherenceRate': 0.0,
      'totalScheduled': 0,
      'totalTaken': 0,
      'missedDoses': 0,
      'onTimeRate': 0.0,
    };
  }

  final totalScheduled = recentRecords.length;
  final totalTaken = recentRecords.where((r) => r.taken).length;
  final onTime = recentRecords.where((r) => 
      r.taken && r.actualTime != null &&
      r.actualTime!.difference(r.scheduledTime).inMinutes.abs() <= 30
  ).length;

  return {
    'adherenceRate': (totalTaken / totalScheduled * 100),
    'totalScheduled': totalScheduled,
    'totalTaken': totalTaken,
    'missedDoses': totalScheduled - totalTaken,
    'onTimeRate': totalTaken > 0 ? (onTime / totalTaken * 100) : 0.0,
  };
}

/// Static helper function for parsing time
DateTime _parseTimeStatic(String timeStr) {
  final parts = timeStr.split(':');
  return DateTime(2000, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
}
