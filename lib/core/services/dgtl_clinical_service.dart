import 'dart:convert';
import '../ai/dgtl_rag_service.dart';
import '../database/database_production.dart';
import '../../services/medication_safety_service.dart';

/// DGTL Clinical Service - Complete Backend API
/// Ready for hassle-free frontend integration
class DgtlClinicalService {
  final DgtlRagService _ragService = DgtlRagService();
  final DgtlDatabase _database = DgtlDatabase();
  final MedicationSafetyService _medicationService = MedicationSafetyService();
  
  bool _isInitialized = false;

  /// Initialize all clinical services - call this first!
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      await _ragService.initialize();
      await _medicationService.initialize();
      _isInitialized = true;
      print('✅ DGTL Clinical Service Ready for Frontend Integration');
    } catch (e) {
      throw Exception('Clinical service initialization failed: $e');
    }
  }

  /// MAIN API: Complete CKD Assessment with RAG
  Future<Map<String, dynamic>> performCkdAssessment({
    required int patientId,
    required Map<String, dynamic> labData,
    required List<String> medications,
    required List<String> symptoms,
  }) async {
    if (!_isInitialized) await initialize();
    
    try {
      // Build clinical context
      final clinicalContext = '''
Lab Data: ${jsonEncode(labData)}
Medications: ${medications.join(", ")}
Symptoms: ${symptoms.join(", ")}
      ''';
      
      // CKD Assessment Query
      final query = '''
Analyze CKD patient with eGFR: ${labData['egfr']}, creatinine: ${labData['creatinine']}.
Symptoms: ${symptoms.join(", ")}.
Provide staging, risk assessment, and management recommendations.
      ''';
      
      // Get RAG recommendations
      final ragResponse = await _ragService.performRag(
        query: query,
        context: clinicalContext,
        category: 'nephrology',
      );
      
      // Medication safety check
      final medicationAlerts = await _medicationService.checkMedicationSafety(
        medications,
        labData,
      );
      
      // CKD Analysis
      final ckdAnalysis = _analyzeCkdStage(labData);
      
      return {
        'patientId': patientId,
        'ckdStage': ckdAnalysis['stage'],
        'eGfrValue': ckdAnalysis['egfr'],
        'riskFactors': ckdAnalysis['riskFactors'],
        'aiRecommendations': ragResponse.generatedResponse,
        'medicationAlerts': medicationAlerts,
        'labRecommendations': _getLabRecommendations(ckdAnalysis['stage']),
        'lifestyleRecommendations': _getLifestyleRecommendations(),
        'followUpRecommendations': _getFollowUpRecommendations(ckdAnalysis['stage']),
        'confidenceScore': ragResponse.relevanceScore,
        'sources': ragResponse.sources,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': true,
        'message': 'Assessment failed: $e',
      };
    }
  }

  /// AI Chat API for Frontend
  Future<Map<String, dynamic>> processChatQuery({
    required String query,
    required int patientId,
  }) async {
    if (!_isInitialized) await initialize();
    
    try {
      final ragResponse = await _ragService.performRag(
        query: query,
        context: 'Patient ID: $patientId',
        category: _getChatCategory(query),
      );
      
      return {
        'query': query,
        'response': ragResponse.generatedResponse,
        'confidence': ragResponse.relevanceScore,
        'sources': ragResponse.sources,
        'category': _getChatCategory(query),
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': true,
        'message': 'Chat failed: $e',
      };
    }
  }

  /// Symptom Processing API
  Future<Map<String, dynamic>> processSymptoms({
    required int patientId,
    required String symptomText,
    String? severity,
  }) async {
    if (!_isInitialized) await initialize();
    
    try {
      final ragResponse = await _ragService.performRag(
        query: 'Analyze CKD symptoms: $symptomText',
        context: 'Patient ID: $patientId, Severity: ${severity ?? "not specified"}',
        category: 'symptom',
      );
      
      return {
        'originalText': symptomText,
        'aiAnalysis': ragResponse.generatedResponse,
        'severity': severity ?? 'unspecified',
        'relevanceScore': ragResponse.relevanceScore,
        'recommendations': _getSymptomRecommendations(symptomText),
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': true,
        'message': 'Symptom processing failed: $e',
      };
    }
  }

  /// Lab Results API
  Future<Map<String, dynamic>> processLabResults({
    required int patientId,
    required Map<String, dynamic> labData,
  }) async {
    if (!_isInitialized) await initialize();
    
    try {
      final ragResponse = await _ragService.performRag(
        query: 'Interpret lab results: ${jsonEncode(labData)}',
        context: 'CKD patient analysis',
        category: 'laboratory',
      );
      
      return {
        'patientId': patientId,
        'currentValues': labData,
        'aiInterpretation': ragResponse.generatedResponse,
        'alerts': _generateLabAlerts(labData),
        'recommendations': _generateLabRecommendations(labData),
        'confidence': ragResponse.relevanceScore,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': true,
        'message': 'Lab analysis failed: $e',
      };
    }
  }

  // =============================================================================
  // HELPER METHODS
  // =============================================================================

  Map<String, dynamic> _analyzeCkdStage(Map<String, dynamic> labData) {
    final egfr = _parseDouble(labData['egfr'] ?? labData['eGFR']);
    final creatinine = _parseDouble(labData['creatinine']);
    
    String stage = 'Unknown';
    List<String> riskFactors = [];
    
    if (egfr != null) {
      if (egfr >= 90) stage = 'Stage 1';
      else if (egfr >= 60) stage = 'Stage 2';
      else if (egfr >= 45) stage = 'Stage 3a';
      else if (egfr >= 30) stage = 'Stage 3b';
      else if (egfr >= 15) stage = 'Stage 4';
      else stage = 'Stage 5';
      
      if (egfr < 60) riskFactors.add('Reduced kidney function');
      if (egfr < 30) riskFactors.add('Advanced CKD - urgent nephrology referral');
    }
    
    if (creatinine != null && creatinine > 1.5) {
      riskFactors.add('Elevated creatinine');
    }
    
    return {
      'stage': stage,
      'egfr': egfr,
      'riskFactors': riskFactors,
    };
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  List<String> _getLabRecommendations(String stage) {
    final recommendations = [
      'Monitor eGFR and creatinine every 3-6 months',
    ];
    
    if (stage.contains('Stage 3') || stage.contains('Stage 4') || stage.contains('Stage 5')) {
      recommendations.addAll([
        'Check albumin/creatinine ratio',
        'Monitor electrolytes and phosphorus',
      ]);
    }
    
    if (stage.contains('Stage 4') || stage.contains('Stage 5')) {
      recommendations.addAll([
        'Check CBC for anemia',
        'Monitor PTH and vitamin D levels',
      ]);
    }
    
    return recommendations;
  }

  List<String> _getLifestyleRecommendations() {
    return [
      'Limit sodium to <2g per day',
      'Control blood pressure <130/80 mmHg',
      'Maintain diabetes control if applicable',
      'Avoid NSAIDs and nephrotoxic drugs',
      'Regular exercise as tolerated',
      'Adequate hydration',
    ];
  }

  List<String> _getFollowUpRecommendations(String stage) {
    if (stage == 'Stage 1' || stage == 'Stage 2') {
      return [
        'Annual nephrology follow-up',
        'Focus on cardiovascular protection',
      ];
    } else if (stage.contains('Stage 3')) {
      return [
        'Nephrology referral recommended',
        'Monitor every 6 months',
      ];
    } else {
      return [
        'Urgent nephrology consultation',
        'Discuss renal replacement therapy',
      ];
    }
  }

  String _getChatCategory(String query) {
    final q = query.toLowerCase();
    if (q.contains('medication')) return 'medication';
    if (q.contains('lab')) return 'laboratory';
    if (q.contains('symptom')) return 'symptom';
    if (q.contains('diet')) return 'nutrition';
    return 'nephrology';
  }

  List<String> _getSymptomRecommendations(String symptomText) {
    final text = symptomText.toLowerCase();
    final recommendations = <String>[];
    
    if (text.contains('fatigue')) {
      recommendations.add('Check hemoglobin for anemia');
    }
    if (text.contains('swelling')) {
      recommendations.add('Monitor fluid balance');
    }
    if (text.contains('nausea')) {
      recommendations.add('Check electrolytes');
    }
    
    recommendations.add('Document symptom progression');
    recommendations.add('Follow up if symptoms worsen');
    
    return recommendations;
  }

  List<String> _generateLabAlerts(Map<String, dynamic> labData) {
    final alerts = <String>[];
    final egfr = _parseDouble(labData['egfr']);
    
    if (egfr != null && egfr < 30) {
      alerts.add('🚨 Critical: eGFR <30 - Urgent nephrology needed');
    }
    
    final creatinine = _parseDouble(labData['creatinine']);
    if (creatinine != null && creatinine > 2.0) {
      alerts.add('⚠️ Elevated creatinine');
    }
    
    return alerts;
  }

  List<String> _generateLabRecommendations(Map<String, dynamic> labData) {
    return [
      'Repeat labs in 3-6 months',
      'Track trends over time',
      'Review medications for kidney safety',
    ];
  }
}
