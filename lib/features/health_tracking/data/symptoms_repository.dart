import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/models/health_data.dart';
import '../../../core/providers/api_provider.dart';

part 'symptoms_repository.g.dart';

/// Symptoms Tracking Repository - Manages symptom logging and analysis
@riverpod
class SymptomsRepository extends _$SymptomsRepository {
  late ApiClient _apiClient;
  late String _currentUserId;

  @override
  Future<List<HealthSymptoms>> build() async {
    _apiClient = ref.read(apiClientProvider);
    _currentUserId = ref.read(currentUserIdProvider);
    
    // Load recent symptoms
    return await _loadRecentSymptoms();
  }

  /// Submit symptoms to backend with AI analysis
  Future<Map<String, dynamic>> submitSymptoms({
    required List<String> symptoms,
    required int severityLevel,
    String? additionalNotes,
  }) async {
    try {
      final request = SymptomsSubmissionRequest(
        symptoms: symptoms,
        severityLevel: severityLevel,
        timestamp: DateTime.now(),
        userId: _currentUserId,
        notes: additionalNotes,
      );

      final response = await _apiClient.submitSymptoms(request);
      
      if (response.success && response.data != null) {
        // Create new symptom entry for local state
        final newSymptom = HealthSymptoms(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          symptoms: symptoms,
          severity: severityLevel,
          timestamp: DateTime.now(),
          userId: _currentUserId,
          notes: additionalNotes,
          aiAnalysis: response.data!.analysis,
        );
        
        // Update local state
        final currentState = state.value ?? [];
        state = AsyncValue.data([newSymptom, ...currentState]);
        
        // Return AI analysis and recommendations
        return {
          'success': true,
          'analysis': response.data!.analysis,
          'recommendations': response.data!.recommendations,
          'riskLevel': response.data!.riskLevel,
          'urgencyLevel': response.data!.urgencyLevel,
        };
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Load recent symptoms from backend
  Future<List<HealthSymptoms>> _loadRecentSymptoms() async {
    try {
      final response = await _apiClient.getRecentSymptoms(_currentUserId, 14); // Last 14 days
      if (response.success && response.data != null) {
        return response.data!;
      }
      return [];
    } catch (e) {
      return []; // Return empty list for offline mode
    }
  }

  /// Refresh symptoms history
  Future<void> refreshSymptoms() async {
    state = const AsyncValue.loading();
    try {
      final symptoms = await _loadRecentSymptoms();
      state = AsyncValue.data(symptoms);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Get symptom trends and patterns
  Map<String, dynamic> getSymptomsAnalytics() {
    final symptoms = state.value ?? [];
    
    if (symptoms.isEmpty) {
      return {
        'totalEntries': 0,
        'commonSymptoms': <String>[],
        'averageSeverity': 0.0,
        'lastEntryDaysAgo': 0,
      };
    }

    // Calculate analytics
    final totalEntries = symptoms.length;
    final symptomCounts = <String, int>{};
    int totalSeverity = 0;

    for (final entry in symptoms) {
      totalSeverity += entry.severity;
      for (final symptom in entry.symptoms) {
        symptomCounts[symptom] = (symptomCounts[symptom] ?? 0) + 1;
      }
    }

    // Find most common symptoms
    final sortedSymptoms = symptomCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final commonSymptoms = sortedSymptoms
        .take(3)
        .map((e) => e.key)
        .toList();

    final averageSeverity = totalSeverity / totalEntries;
    final lastEntryDaysAgo = DateTime.now().difference(symptoms.first.timestamp).inDays;

    return {
      'totalEntries': totalEntries,
      'commonSymptoms': commonSymptoms,
      'averageSeverity': averageSeverity,
      'lastEntryDaysAgo': lastEntryDaysAgo,
    };
  }
}

/// Symptoms Analytics Provider
@riverpod
Map<String, dynamic> symptomsAnalyticsProvider(SymptomsAnalyticsProviderRef ref) {
  final repository = ref.watch(symptomsRepositoryProvider.notifier);
  return repository.getSymptomsAnalytics();
}

/// Recent Symptoms Provider (for display in UI)
@riverpod
List<Map<String, dynamic>> recentSymptomsDisplayProvider(RecentSymptomsDisplayProviderRef ref) {
  final symptomsData = ref.watch(symptomsRepositoryProvider);
  
  return symptomsData.when(
    loading: () => [],
    error: (_, __) => [],
    data: (symptoms) {
      return symptoms.take(5).map((symptom) => {
        'date': _formatDateHindi(symptom.timestamp),
        'symptoms': symptom.symptoms.take(3).join(', '),
        'severity': symptom.severity,
        'severityText': _getSeverityTextHindi(symptom.severity),
        'hasAiAnalysis': symptom.aiAnalysis != null,
      }).toList();
    },
  );
}

/// Common Symptoms Provider for quick selection
@riverpod
List<Map<String, String>> commonSymptomsProvider(CommonSymptomsProviderRef ref) {
  return [
    {'hindi': 'सिर दर्द', 'english': 'Headache'},
    {'hindi': 'बुखार', 'english': 'Fever'},
    {'hindi': 'खांसी', 'english': 'Cough'},
    {'hindi': 'गले में खराश', 'english': 'Sore Throat'},
    {'hindi': 'थकान', 'english': 'Fatigue'},
    {'hindi': 'मतली', 'english': 'Nausea'},
    {'hindi': 'पेट दर्द', 'english': 'Stomach Pain'},
    {'hindi': 'चक्कर आना', 'english': 'Dizziness'},
    {'hindi': 'सांस लेने में तकलीफ', 'english': 'Shortness of Breath'},
    {'hindi': 'छाती में दर्द', 'english': 'Chest Pain'},
    {'hindi': 'जोड़ों में दर्द', 'english': 'Joint Pain'},
    {'hindi': 'नींद न आना', 'english': 'Insomnia'},
  ];
}

/// Format date in Hindi
String _formatDateHindi(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date).inDays;
  
  if (difference == 0) {
    return 'आज';
  } else if (difference == 1) {
    return 'कल';
  } else if (difference < 7) {
    return '$difference दिन पहले';
  } else {
    return '${date.day} ${_getHindiMonth(date.month)}';
  }
}

/// Get severity text in Hindi
String _getSeverityTextHindi(int severity) {
  switch (severity) {
    case 1:
      return 'हल्का';
    case 2:
      return 'मध्यम';
    case 3:
      return 'गंभीर';
    case 4:
      return 'अत्यधिक गंभीर';
    case 5:
      return 'आपातकालीन';
    default:
      return 'अज्ञात';
  }
}

/// Hindi month names
String _getHindiMonth(int month) {
  const months = [
    '', 'जन', 'फर', 'मार', 'अप्र', 'मई', 'जून',
    'जुल', 'अग', 'सितं', 'अक्टू', 'नव', 'दिस'
  ];
  return months[month];
}
