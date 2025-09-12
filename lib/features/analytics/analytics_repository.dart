import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:math' as math;

import '../../../core/api/api_client.dart';
import '../../../core/models/health_data.dart';
import '../../../core/models/lab_models.dart';
import '../../../core/providers/api_provider.dart';
import '../health_tracking/data/health_repository.dart';
import '../lab_integration/lab_repository.dart';

part 'analytics_repository.g.dart';

/// Health Analytics Data Model
class HealthAnalytics {
  final String id;
  final String userId;
  final DateTime analysisDate;
  final Map<String, double> healthScores;
  final Map<String, String> trends;
  final List<String> predictions;
  final List<String> recommendations;
  final double overallRiskScore;
  final String riskCategory;
  final Map<String, dynamic> metadata;

  const HealthAnalytics({
    required this.id,
    required this.userId,
    required this.analysisDate,
    required this.healthScores,
    required this.trends,
    required this.predictions,
    required this.recommendations,
    required this.overallRiskScore,
    required this.riskCategory,
    required this.metadata,
  });

  String get riskCategoryInHindi {
    switch (riskCategory.toLowerCase()) {
      case 'low':
        return 'कम जोखिम';
      case 'moderate':
        return 'मध्यम जोखिम';
      case 'high':
        return 'उच्च जोखिम';
      case 'critical':
        return 'गंभीर जोखिम';
      default:
        return 'अज्ञात जोखिम';
    }
  }
}

/// Predictive Health Insights
class PredictiveInsight {
  final String type; // 'blood_pressure', 'kidney_function', 'medication_adherence'
  final String prediction;
  final double confidence;
  final DateTime predictedDate;
  final List<String> factors;
  final List<String> preventiveActions;

  const PredictiveInsight({
    required this.type,
    required this.prediction,
    required this.confidence,
    required this.predictedDate,
    required this.factors,
    required this.preventiveActions,
  });

  String get typeInHindi {
    switch (type) {
      case 'blood_pressure':
        return 'रक्तचाप';
      case 'kidney_function':
        return 'गुर्दा कार्यप्रणाली';
      case 'medication_adherence':
        return 'दवा अनुपालन';
      case 'lab_trends':
        return 'लैब परिणाम रुझान';
      default:
        return type;
    }
  }
}

/// Analytics Repository - Manages health analytics and predictions
@riverpod
class AnalyticsRepository extends _$AnalyticsRepository {
  late ApiClient _apiClient;
  late String _currentUserId;
  late Box<HealthAnalytics> _analyticsBox;

  @override
  Future<HealthAnalytics?> build() async {
    _apiClient = ref.read(apiClientProvider);
    _currentUserId = ref.read(currentUserIdProvider);
    
    // Initialize Hive box for analytics cache
    _analyticsBox = await Hive.openBox<HealthAnalytics>('health_analytics');
    
    // Load latest analytics
    return await _loadLatestAnalytics();
  }

  /// Load latest analytics from backend
  Future<HealthAnalytics?> _loadLatestAnalytics() async {
    try {
      final response = await _apiClient.getHealthAnalytics(_currentUserId);
      if (response.success && response.data != null) {
        // Cache analytics locally
        await _analyticsBox.put('latest', response.data!);
        return response.data!;
      }
      
      // Fallback to cached data
      return _analyticsBox.get('latest');
    } catch (e) {
      // Return cached analytics on error
      return _analyticsBox.get('latest');
    }
  }

  /// Generate new analytics
  Future<HealthAnalytics?> generateAnalytics() async {
    try {
      // Trigger analytics generation on backend
      final response = await _apiClient.generateHealthAnalytics(_currentUserId);
      
      if (response.success && response.data != null) {
        // Cache new analytics
        await _analyticsBox.put('latest', response.data!);
        
        // Update state
        state = AsyncValue.data(response.data!);
        
        return response.data!;
      }
      
      return null;
    } catch (e) {
      // Generate basic analytics locally
      return await _generateLocalAnalytics();
    }
  }

  /// Generate basic analytics locally when backend unavailable
  Future<HealthAnalytics?> _generateLocalAnalytics() async {
    try {
      final healthData = ref.read(healthRepositoryProvider).value ?? [];
      final labResults = ref.read(labRepositoryProvider).value ?? [];
      
      if (healthData.isEmpty && labResults.isEmpty) {
        return null;
      }

      // Basic BP trend analysis
      final bpTrend = _analyzeBPTrend(healthData);
      
      // Basic lab trend analysis
      final labTrends = _analyzeLabTrends(labResults);
      
      // Calculate simple risk score
      final riskScore = _calculateBasicRiskScore(healthData, labResults);
      
      final analytics = HealthAnalytics(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: _currentUserId,
        analysisDate: DateTime.now(),
        healthScores: {
          'blood_pressure': bpTrend['score'] ?? 0.0,
          'lab_results': labTrends['overall_score'] ?? 0.0,
          'overall': riskScore,
        },
        trends: {
          'blood_pressure': bpTrend['trend'] ?? 'stable',
          'lab_results': labTrends['trend'] ?? 'stable',
        },
        predictions: _generateBasicPredictions(healthData, labResults),
        recommendations: _generateBasicRecommendations(healthData, labResults),
        overallRiskScore: riskScore,
        riskCategory: _getRiskCategory(riskScore),
        metadata: {
          'generated_locally': true,
          'data_points': healthData.length + labResults.length,
        },
      );

      // Cache locally
      await _analyticsBox.put('latest', analytics);
      state = AsyncValue.data(analytics);
      
      return analytics;
    } catch (e) {
      return null;
    }
  }

  /// Analyze BP trend
  Map<String, dynamic> _analyzeBPTrend(List<BPReading> readings) {
    if (readings.length < 2) {
      return {'trend': 'insufficient_data', 'score': 50.0};
    }

    final recentReadings = readings.take(10).toList();
    final avgSystolic = recentReadings.map((r) => r.systolic).reduce((a, b) => a + b) / recentReadings.length;
    final avgDiastolic = recentReadings.map((r) => r.diastolic).reduce((a, b) => a + b) / recentReadings.length;
    
    String trend = 'stable';
    double score = 75.0;
    
    // Simple trend analysis
    if (avgSystolic > 140 || avgDiastolic > 90) {
      trend = 'concerning';
      score = 30.0;
    } else if (avgSystolic < 120 && avgDiastolic < 80) {
      trend = 'good';
      score = 90.0;
    }

    return {'trend': trend, 'score': score};
  }

  /// Analyze lab trends
  Map<String, dynamic> _analyzeLabTrends(List<LabResult> results) {
    if (results.isEmpty) {
      return {'trend': 'no_data', 'overall_score': 50.0};
    }

    final criticalCount = results.where((r) => r.status.toLowerCase() == 'critical').length;
    final abnormalCount = results.where((r) => r.status.toLowerCase() == 'abnormal').length;
    final normalCount = results.where((r) => r.status.toLowerCase() == 'normal').length;
    
    double score = 75.0;
    String trend = 'stable';
    
    if (criticalCount > 0) {
      score = 20.0;
      trend = 'critical';
    } else if (abnormalCount > normalCount) {
      score = 40.0;
      trend = 'concerning';
    } else if (normalCount > abnormalCount) {
      score = 90.0;
      trend = 'improving';
    }

    return {'trend': trend, 'overall_score': score};
  }

  /// Calculate basic risk score
  double _calculateBasicRiskScore(List<BPReading> bpReadings, List<LabResult> labResults) {
    double totalScore = 50.0; // Base score
    int factors = 1;

    // BP factor
    if (bpReadings.isNotEmpty) {
      final recentBP = bpReadings.first;
      if (recentBP.systolic > 140 || recentBP.diastolic > 90) {
        totalScore += 30;
      } else if (recentBP.systolic < 120 && recentBP.diastolic < 80) {
        totalScore -= 10;
      }
      factors++;
    }

    // Lab results factor
    if (labResults.isNotEmpty) {
      final criticalCount = labResults.where((r) => r.status.toLowerCase() == 'critical').length;
      if (criticalCount > 0) {
        totalScore += 40;
      }
      factors++;
    }

    return math.min(100.0, totalScore / factors);
  }

  /// Generate basic predictions
  List<String> _generateBasicPredictions(List<BPReading> bpReadings, List<LabResult> labResults) {
    final predictions = <String>[];

    if (bpReadings.isNotEmpty) {
      final recentBP = bpReadings.first;
      if (recentBP.systolic > 140) {
        predictions.add('अगले 3 महीनों में BP नियंत्रण की आवश्यकता');
      }
    }

    if (labResults.any((r) => r.status.toLowerCase() == 'abnormal')) {
      predictions.add('अगली लैब जांच में सुधार की संभावना');
    }

    if (predictions.isEmpty) {
      predictions.add('वर्तमान स्वास्थ्य स्थिति स्थिर है');
    }

    return predictions;
  }

  /// Generate basic recommendations
  List<String> _generateBasicRecommendations(List<BPReading> bpReadings, List<LabResult> labResults) {
    final recommendations = <String>[];

    if (bpReadings.isNotEmpty) {
      final recentBP = bpReadings.first;
      if (recentBP.systolic > 140) {
        recommendations.add('नियमित BP मॉनिटरिंग और डॉक्टर से सलाह');
        recommendations.add('नमक कम करें और नियमित व्यायाम करें');
      }
    }

    if (labResults.any((r) => r.status.toLowerCase() == 'critical')) {
      recommendations.add('तुरंत डॉक्टर से मिलें');
    }

    if (recommendations.isEmpty) {
      recommendations.addAll([
        'नियमित स्वास्थ्य जांच कराते रहें',
        'संतुलित आहार और व्यायाम जारी रखें',
        'दवा अनुपालन बनाए रखें'
      ]);
    }

    return recommendations;
  }

  /// Get risk category
  String _getRiskCategory(double riskScore) {
    if (riskScore < 25) return 'low';
    if (riskScore < 50) return 'moderate';
    if (riskScore < 75) return 'high';
    return 'critical';
  }

  /// Refresh analytics
  Future<void> refreshAnalytics() async {
    state = const AsyncValue.loading();
    try {
      final analytics = await generateAnalytics();
      state = AsyncValue.data(analytics);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

/// Predictive Insights Provider
@riverpod
Future<List<PredictiveInsight>> predictiveInsightsProvider(
    PredictiveInsightsProviderRef ref) async {
  final analytics = await ref.watch(analyticsRepositoryProvider.future);
  
  if (analytics == null) {
    return [];
  }

  final insights = <PredictiveInsight>[];

  // BP predictions
  if (analytics.healthScores['blood_pressure'] != null) {
    insights.add(PredictiveInsight(
      type: 'blood_pressure',
      prediction: analytics.predictions.isNotEmpty 
          ? analytics.predictions.first 
          : 'BP स्थिति स्थिर रहने की संभावना',
      confidence: analytics.healthScores['blood_pressure']! / 100,
      predictedDate: DateTime.now().add(const Duration(days: 30)),
      factors: ['पिछले BP रीडिंग', 'दवा अनुपालन', 'जीवनशैली'],
      preventiveActions: analytics.recommendations.take(2).toList(),
    ));
  }

  // Lab trends predictions
  if (analytics.healthScores['lab_results'] != null) {
    insights.add(PredictiveInsight(
      type: 'lab_trends',
      prediction: 'अगली लैब रिपोर्ट में ${analytics.trends['lab_results'] == 'improving' ? 'सुधार' : 'स्थिरता'} की संभावना',
      confidence: analytics.healthScores['lab_results']! / 100,
      predictedDate: DateTime.now().add(const Duration(days: 90)),
      factors: ['हाल की लैब रिपोर्ट', 'दवा प्रभावशीलता', 'जीवनशैली परिवर्तन'],
      preventiveActions: analytics.recommendations.skip(1).take(2).toList(),
    ));
  }

  return insights;
}

/// Health Score Trends Provider
@riverpod
Future<Map<String, List<Map<String, dynamic>>>> healthScoreTrendsProvider(
    HealthScoreTrendsProviderRef ref) async {
  // This would typically fetch historical analytics data
  // For now, return mock trend data
  final now = DateTime.now();
  
  return {
    'blood_pressure': List.generate(7, (index) => {
      'date': now.subtract(Duration(days: 6 - index)),
      'score': 75.0 + (math.Random().nextDouble() - 0.5) * 20,
    }),
    'lab_results': List.generate(7, (index) => {
      'date': now.subtract(Duration(days: 6 - index)),
      'score': 80.0 + (math.Random().nextDouble() - 0.5) * 15,
    }),
    'overall': List.generate(7, (index) => {
      'date': now.subtract(Duration(days: 6 - index)),
      'score': 77.5 + (math.Random().nextDouble() - 0.5) * 18,
    }),
  };
}

/// Risk Factors Provider
@riverpod
Future<List<Map<String, dynamic>>> riskFactorsProvider(
    RiskFactorsProviderRef ref) async {
  final analytics = await ref.watch(analyticsRepositoryProvider.future);
  
  if (analytics == null) {
    return [];
  }

  return [
    {
      'factor': 'रक्तचाप नियंत्रण',
      'level': analytics.healthScores['blood_pressure'] ?? 50.0,
      'status': analytics.trends['blood_pressure'] ?? 'stable',
      'impact': analytics.healthScores['blood_pressure'] != null && 
               analytics.healthScores['blood_pressure']! < 50 ? 'high' : 'medium',
    },
    {
      'factor': 'लैब परिणाम',
      'level': analytics.healthScores['lab_results'] ?? 50.0,
      'status': analytics.trends['lab_results'] ?? 'stable',
      'impact': analytics.healthScores['lab_results'] != null && 
               analytics.healthScores['lab_results']! < 50 ? 'high' : 'medium',
    },
    {
      'factor': 'समग्र स्वास्थ्य',
      'level': analytics.overallRiskScore,
      'status': analytics.riskCategory,
      'impact': analytics.riskCategory == 'critical' || analytics.riskCategory == 'high' 
               ? 'high' : 'medium',
    },
  ];
}
