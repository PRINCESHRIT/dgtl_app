import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/models/health_data.dart';
import '../../../core/providers/api_provider.dart';

part 'health_repository.g.dart';

/// Health Data Repository - Manages BP readings, symptoms, and vitals
@riverpod
class HealthRepository extends _$HealthRepository {
  late ApiClient _apiClient;
  late String _currentUserId;

  @override
  Future<List<BPReading>> build() async {
    _apiClient = ref.read(apiClientProvider);
    _currentUserId = ref.read(currentUserIdProvider);
    
    // Load initial BP history
    return await _loadBPHistory();
  }

  /// Submit BP Reading to Backend
  Future<void> submitBPReading(int systolic, int diastolic, {String? notes}) async {
    try {
      final request = BPReadingRequest(
        systolic: systolic,
        diastolic: diastolic,
        timestamp: DateTime.now(),
        userId: _currentUserId,
        notes: notes,
      );

      final response = await _apiClient.submitBPReading(request);
      
      if (response.success) {
        // Create a new BP reading for local state
        final newReading = BPReading(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          systolic: systolic,
          diastolic: diastolic,
          timestamp: DateTime.now(),
          status: _calculateBPStatus(systolic, diastolic),
          userId: _currentUserId,
          notes: notes,
        );
        
        // Update local state
        final currentState = state.value ?? [];
        state = AsyncValue.data([newReading, ...currentState]);
        
        // Invalidate related providers to refresh UI
        ref.invalidate(bpHistoryProvider);
        ref.invalidate(bpTrendDataProvider);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      // Keep current state but show error
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  /// Load BP History from Backend
  Future<List<BPReading>> _loadBPHistory() async {
    try {
      final response = await _apiClient.getBPHistory(_currentUserId, 30); // Last 30 days
      if (response.success && response.data != null) {
        return response.data!;
      }
      return [];
    } catch (e) {
      // Return empty list for now, could implement offline fallback
      return [];
    }
  }

  /// Refresh BP History
  Future<void> refreshBPHistory() async {
    state = const AsyncValue.loading();
    try {
      final history = await _loadBPHistory();
      state = AsyncValue.data(history);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Calculate BP Status based on values
  String _calculateBPStatus(int systolic, int diastolic) {
    if (systolic < 90 || diastolic < 60) {
      return 'low';
    } else if (systolic <= 120 && diastolic <= 80) {
      return 'normal';
    } else if (systolic <= 139 || diastolic <= 89) {
      return 'high_normal';
    } else {
      return 'high';
    }
  }
}

/// BP History Provider (last 7 readings for chart)
@riverpod
List<Map<String, dynamic>> bpHistoryProvider(BpHistoryProviderRef ref) {
  final healthData = ref.watch(healthRepositoryProvider);
  
  return healthData.when(
    loading: () => _getDefaultBPHistory(),
    error: (_, __) => _getDefaultBPHistory(),
    data: (readings) {
      if (readings.isEmpty) return _getDefaultBPHistory();
      
      // Take last 7 readings and convert to chart format
      final last7 = readings.take(7).toList();
      final chartData = <Map<String, dynamic>>[];
      
      // Fill in the last 7 days
      for (int i = 6; i >= 0; i--) {
        final date = DateTime.now().subtract(Duration(days: i));
        final dateStr = i == 0 ? 'आज' : '${date.day} ${_getHindiMonth(date.month)}';
        
        // Find reading for this day
        final dayReading = last7.where((reading) {
          final readingDate = reading.timestamp;
          return readingDate.year == date.year &&
                 readingDate.month == date.month &&
                 readingDate.day == date.day;
        }).firstOrNull;
        
        chartData.add({
          'date': dateStr,
          'systolic': dayReading?.systolic ?? 0,
          'diastolic': dayReading?.diastolic ?? 0,
        });
      }
      
      return chartData;
    },
  );
}

/// BP Trend Data Provider for enhanced visualization
@riverpod
Map<String, dynamic> bpTrendDataProvider(BpTrendDataProviderRef ref) {
  final healthData = ref.watch(healthRepositoryProvider);
  
  return healthData.when(
    loading: () => {'trend': 'stable', 'change': 0},
    error: (_, __) => {'trend': 'stable', 'change': 0},
    data: (readings) {
      if (readings.length < 2) return {'trend': 'stable', 'change': 0};
      
      final latest = readings.first;
      final previous = readings[1];
      
      final latestAvg = (latest.systolic + latest.diastolic) / 2;
      final previousAvg = (previous.systolic + previous.diastolic) / 2;
      final change = latestAvg - previousAvg;
      
      String trend = 'stable';
      if (change > 5) {
        trend = 'increasing';
      } else if (change < -5) {
        trend = 'decreasing';
      }
      
      return {
        'trend': trend,
        'change': change.round(),
        'latest': latest,
        'previous': previous,
      };
    },
  );
}

/// Default BP history for when no data is available
List<Map<String, dynamic>> _getDefaultBPHistory() {
  return [
    {"date": "6 सितं", "systolic": 0, "diastolic": 0},
    {"date": "7 सितं", "systolic": 0, "diastolic": 0},
    {"date": "8 सितं", "systolic": 0, "diastolic": 0},
    {"date": "9 सितं", "systolic": 0, "diastolic": 0},
    {"date": "10 सितं", "systolic": 0, "diastolic": 0},
    {"date": "11 सितं", "systolic": 0, "diastolic": 0},
    {"date": "आज", "systolic": 0, "diastolic": 0},
  ];
}

/// Hindi month names
String _getHindiMonth(int month) {
  const months = [
    '', 'जन', 'फर', 'मार', 'अप्र', 'मई', 'जून',
    'जुल', 'अग', 'सितं', 'अक्टू', 'नव', 'दिस'
  ];
  return months[month];
}

/// Extension to add firstOrNull method
extension FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      return iterator.current;
    }
    return null;
  }
}
