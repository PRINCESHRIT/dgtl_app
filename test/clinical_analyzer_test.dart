import 'package:test/test.dart';
import '../ckd_clinical_analyzer_enhanced.dart';
import '../lib/services/gemma_embedding_service.dart';
import '../lib/services/vector_search_service.dart';
import '../lib/services/medication_safety_service.dart';

// Mock GemmaEmbeddingService to avoid making real HTTP calls in tests.
class MockGemmaEmbeddingService extends GemmaEmbeddingService {
  @override
  Future<List<double>> generateEmbedding(Map<String, dynamic> payload) async {
    if (payload['query_text'] == 'uncontrolled hypertension in CKD G4') {
      return [0.15, 0.85, 0.25, 0.75]; // A vector close to the BP guideline
    }
    return [0.0, 0.0, 0.0, 0.0];
  }
}

void main() {
  group('CKDClinicalAnalyzer with Medication Safety', () {
    late CKDClinicalAnalyzer analyzer;
    late String patientWithRiskyMed;

    setUp(() {
      // Initialize the analyzer with all required services
      analyzer = CKDClinicalAnalyzer(
        embeddingService: MockGemmaEmbeddingService(),
        vectorSearchService: VectorSearchService(),
        medicationSafetyService: MedicationSafetyService(),
      );

      // New patient data including a high-risk NSAID
      patientWithRiskyMed = """
      {
        "patient_info": {
          "patient_id": "PID67890",
          "age": 68,
          "sex": "Male",
          "medications": ["Lisinopril", "Ibuprofen", "Atorvastatin"]
        },
        "lab_history": [
          {"date": "2024-05-20", "test": "Creatinine", "result": "2.5 mg/dL"},
          {"date": "2024-05-20", "test": "Blood Pressure", "result": {"systolic": 135, "diastolic": 85}}
        ]
      }
      """;
    });

    test('should flag high-risk medications and set priority to Urgent', () async {
      final assessment = await analyzer.analyzeCKDPatientClinical(patientWithRiskyMed);

      // Print the report to see the new safety alert
      print(assessment);

      // 1. Check for the medication safety warning
      expect(assessment.medicationSafetyWarnings, isNotEmpty);
      expect(assessment.medicationSafetyWarnings.first.medicationName, equals('ibuprofen'));
      expect(assessment.medicationSafetyWarnings.first.severity, equals('High'));

      // 2. Check that a new flag has been added
      expect(assessment.clinicalFlags, contains('medication_safety_alert'));

      // 3. Verify that the action priority is now 'Urgent' because of the alert
      expect(assessment.actionPriority, equals('Urgent'));
      
      // 4. Check that a recommendation has been added
      expect(assessment.recommendations, contains('Review and address high-risk medications.'));
    });
  });
}
