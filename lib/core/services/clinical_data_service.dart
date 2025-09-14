import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

/// Clinical Data Service
/// Connects frontend to clinical dataset and recommendations
class ClinicalDataService {
  static final ClinicalDataService _instance = ClinicalDataService._internal();
  factory ClinicalDataService() => _instance;
  ClinicalDataService._internal();

  Map<String, dynamic>? _cachedPatientContext;
  Map<String, dynamic>? _cachedRecommendations;
  Map<String, dynamic>? _cachedPersonalizedInsights;

  /// Get comprehensive patient context from clinical dataset analysis
  Future<Map<String, dynamic>?> getPatientContext(String patientId) async {
    if (_cachedPatientContext != null) {
      return _cachedPatientContext;
    }

    try {
      // Load clinical dataset
      final datasetContent = await rootBundle.loadString('assets/data/patient_clinical_dataset.csv');
      final lines = datasetContent.trim().split('\n');
      
      // Parse clinical data
      final clinicalData = <Map<String, dynamic>>[];
      for (int i = 1; i < lines.length; i++) {
        final values = lines[i].split(',');
        if (values.length >= 3) {
          clinicalData.add({
            'date': values[0].trim(),
            'test_name': values[1].trim().toLowerCase(),
            'result': values[2].trim(),
            'unit': values.length > 3 ? values[3].trim() : '',
          });
        }
      }

      // Extract key values
      final context = {
        'patient_id': patientId,
        'total_records': clinicalData.length,
        'data_range': _getDataRange(clinicalData),
        'latest_egfr': _getLatestValue(clinicalData, ['egfr', 'gfr']),
        'latest_creatinine': _getLatestValue(clinicalData, ['creatinine']),
        'latest_hemoglobin': _getLatestValue(clinicalData, ['hemoglobin', 'hgb']),
        'latest_pth': _getLatestValue(clinicalData, ['pth', 'parathyroid']),
        'blood_pressure_readings': _getBloodPressureReadings(clinicalData),
        'medications': _getMedications(clinicalData),
        'ckd_stage': _determineCKDStage(clinicalData),
        'created_at': DateTime.now().toIso8601String(),
      };

      _cachedPatientContext = context;
      return context;

    } catch (e) {
      print('Error loading patient context: $e');
      return null;
    }
  }

  /// Get clinical recommendations from guidelines integration
  Future<Map<String, dynamic>?> getClinicalRecommendations() async {
    if (_cachedRecommendations != null) {
      return _cachedRecommendations;
    }

    try {
      final content = await rootBundle.loadString('assets/data/clinical_recommendations.json');
      _cachedRecommendations = jsonDecode(content);
      return _cachedRecommendations;
    } catch (e) {
      print('Error loading recommendations: $e');
      return null;
    }
  }

  /// Get personalized insights
  Future<Map<String, dynamic>?> getPersonalizedInsights() async {
    if (_cachedPersonalizedInsights != null) {
      return _cachedPersonalizedInsights;
    }

    try {
      final content = await rootBundle.loadString('assets/data/personalized_insights.json');
      _cachedPersonalizedInsights = jsonDecode(content);
      return _cachedPersonalizedInsights;
    } catch (e) {
      print('Error loading personalized insights: $e');
      return null;
    }
  }

  /// Get monitoring plan
  Future<Map<String, dynamic>?> getMonitoringPlan() async {
    try {
      final content = await rootBundle.loadString('assets/data/monitoring_plan.json');
      return jsonDecode(content);
    } catch (e) {
      print('Error loading monitoring plan: $e');
      return null;
    }
  }

  /// Get compliance gaps assessment
  Future<Map<String, dynamic>?> getComplianceGaps() async {
    try {
      final content = await rootBundle.loadString('assets/data/compliance_gaps.json');
      return jsonDecode(content);
    } catch (e) {
      print('Error loading compliance gaps: $e');
      return null;
    }
  }

  /// Get personalized query responses for AI chat
  Future<List<Map<String, dynamic>>> getPersonalizedQueryResponses() async {
    try {
      final content = await rootBundle.loadString('assets/data/personalized_query_responses.json');
      final data = jsonDecode(content);
      return List<Map<String, dynamic>>.from(data['queries'] ?? []);
    } catch (e) {
      print('Error loading query responses: $e');
      return [];
    }
  }

  /// Get latest value for specific test types
  Map<String, dynamic>? _getLatestValue(List<Map<String, dynamic>> data, List<String> testNames) {
    final matchingResults = <Map<String, dynamic>>[];
    
    for (final record in data) {
      final testName = record['test_name'] as String;
      for (final searchTerm in testNames) {
        if (testName.contains(searchTerm)) {
          final numericValue = _extractNumericValue(record['result'] as String);
          if (numericValue != null) {
            matchingResults.add({
              'date': record['date'],
              'value': numericValue,
              'unit': record['unit'],
              'test_name': testName,
            });
          }
          break;
        }
      }
    }

    if (matchingResults.isEmpty) return null;

    // Sort by date and return the latest
    matchingResults.sort((a, b) {
      final dateA = DateTime.tryParse(a['date']) ?? DateTime(1900);
      final dateB = DateTime.tryParse(b['date']) ?? DateTime(1900);
      return dateB.compareTo(dateA);
    });

    return matchingResults.first;
  }

  /// Extract numeric value from result string
  double? _extractNumericValue(String result) {
    final cleanResult = result.replaceAll(RegExp(r'[^\d\.]'), '');
    return double.tryParse(cleanResult);
  }

  /// Get data range
  Map<String, String> _getDataRange(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return {'start': 'Unknown', 'end': 'Unknown'};

    final dates = data
        .map((record) => DateTime.tryParse(record['date'] as String))
        .where((date) => date != null)
        .cast<DateTime>()
        .toList();

    if (dates.isEmpty) return {'start': 'Unknown', 'end': 'Unknown'};

    dates.sort();
    return {
      'start': dates.first.toString().split(' ')[0],
      'end': dates.last.toString().split(' ')[0],
    };
  }

  /// Get blood pressure readings
  List<Map<String, dynamic>> _getBloodPressureReadings(List<Map<String, dynamic>> data) {
    return data
        .where((record) => (record['test_name'] as String).contains('blood pressure'))
        .map((record) => {
              'date': record['date'],
              'reading': record['result'],
            })
        .toList();
  }

  /// Get medications
  List<String> _getMedications(List<Map<String, dynamic>> data) {
    return data
        .where((record) =>
            (record['test_name'] as String).contains('prescription') ||
            (record['test_name'] as String).contains('medication'))
        .map((record) => record['result'] as String)
        .toSet()
        .toList();
  }

  /// Determine CKD stage based on eGFR
  String _determineCKDStage(List<Map<String, dynamic>> data) {
    final latestEgfr = _getLatestValue(data, ['egfr', 'gfr']);
    if (latestEgfr == null) return 'Unknown (no eGFR data)';

    final egfr = latestEgfr['value'] as double;

    if (egfr >= 90) return 'Stage 1 (Normal/High)';
    if (egfr >= 60) return 'Stage 2 (Mild decrease)';
    if (egfr >= 30) return 'Stage 3 (Moderate decrease)';
    if (egfr >= 15) return 'Stage 4 (Severe decrease)';
    return 'Stage 5 (Kidney failure)';
  }

  /// Get health trends for dashboard
  Future<Map<String, List<Map<String, dynamic>>>> getHealthTrends() async {
    try {
      final context = await getPatientContext('CLINICAL-P001');
      if (context == null) return {};

      // Load full dataset for trending
      final datasetContent = await rootBundle.loadString('assets/data/patient_clinical_dataset.csv');
      final lines = datasetContent.trim().split('\n');
      
      final clinicalData = <Map<String, dynamic>>[];
      for (int i = 1; i < lines.length; i++) {
        final values = lines[i].split(',');
        if (values.length >= 3) {
          clinicalData.add({
            'date': values[0].trim(),
            'test_name': values[1].trim().toLowerCase(),
            'result': values[2].trim(),
            'unit': values.length > 3 ? values[3].trim() : '',
          });
        }
      }

      return {
        'creatinine': _getTrendData(clinicalData, ['creatinine']),
        'egfr': _getTrendData(clinicalData, ['egfr', 'gfr']),
        'hemoglobin': _getTrendData(clinicalData, ['hemoglobin', 'hgb']),
        'pth': _getTrendData(clinicalData, ['pth', 'parathyroid']),
      };
    } catch (e) {
      print('Error getting health trends: $e');
      return {};
    }
  }

  /// Get trend data for specific tests
  List<Map<String, dynamic>> _getTrendData(List<Map<String, dynamic>> data, List<String> testNames) {
    final trendData = <Map<String, dynamic>>[];
    
    for (final record in data) {
      final testName = record['test_name'] as String;
      for (final searchTerm in testNames) {
        if (testName.contains(searchTerm)) {
          final numericValue = _extractNumericValue(record['result'] as String);
          final date = DateTime.tryParse(record['date'] as String);
          if (numericValue != null && date != null) {
            trendData.add({
              'date': date,
              'value': numericValue,
              'unit': record['unit'],
            });
          }
          break;
        }
      }
    }

    // Sort by date
    trendData.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
    return trendData;
  }

  /// Clear cache (useful for testing or data refresh)
  void clearCache() {
    _cachedPatientContext = null;
    _cachedRecommendations = null;
    _cachedPersonalizedInsights = null;
  }
}
