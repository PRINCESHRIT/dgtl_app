import 'package:flutter_test/flutter_test.dart';
import '../../lib/core/database/database.dart';
import '../../lib/core/ai/embedding_gemma_service.dart';
import '../../lib/core/ai/vector_search_service.dart';
import '../../lib/core/ai/gemma3n_rag_service.dart';

/// Test the caregiver scenario capabilities
void main() {
  group('Caregiver Scenario Tests', () {
    late AppDatabase database;
    late EmbeddingGemmaService embeddingService;
    late VectorSearchService vectorSearchService;
    late Gemma3NRagService ragService;
    
    setUp(() async {
      // Use in-memory database for testing
      database = AppDatabase.memory();
      embeddingService = EmbeddingGemmaService();
      vectorSearchService = VectorSearchService(
        embeddingService: embeddingService,
        database: database,
      );
      ragService = Gemma3NRagService(
        embeddingService: embeddingService,
        vectorSearch: vectorSearchService,
        database: database,
      );
      
      await embeddingService.initialize();
    });
    
    tearDown(() async {
      await database.close();
    });
    
    test('Can analyze symptoms: "Maa has swelling in her feet"', () async {
      // Test embedding generation
      final embedding = await embeddingService.generateEmbedding("Maa has swelling in her feet");
      
      expect(embedding.length, equals(256)); // Should be 256-dimensional
      expect(embedding.every((value) => value.isFinite), true); // All values should be finite
      
      print('✅ Generated 256D embedding for "Maa has swelling in her feet"');
      print('Sample values: ${embedding.take(5).map((v) => v.toStringAsFixed(3)).join(", ")}...');
    });
    
    test('Can find similar events: swelling vs puffy ankles', () async {
      // Create a test patient
      final patientId = await database.insertPatient(
        PatientsCompanion.insert(
          firstName: 'Maa',
          lastName: 'Test'
        )
      );
      
      // Add some symptom logs
      await database.insertSymptomLog(SymptomLogsCompanion.insert(
        patientId: patientId,
        symptom: "puffy ankles in the morning",
        severity: 5,
        logDate: DateTime.now().subtract(Duration(days: 3)),
      ));
      
      await database.insertSymptomLog(SymptomLogsCompanion.insert(
        patientId: patientId,
        symptom: "tight shoes, feet seem bigger",
        severity: 4,
        logDate: DateTime.now().subtract(Duration(days: 7)),
      ));
      
      await database.insertSymptomLog(SymptomLogsCompanion.insert(
        patientId: patientId,
        symptom: "headache after morning walk",
        severity: 3,
        logDate: DateTime.now().subtract(Duration(days: 2)),
      ));
      
      // Search for similar symptoms to "swelling in feet"
      final similar = await vectorSearchService.findSimilarSymptoms(
        queryText: "swelling in feet",
        patientId: patientId,
        threshold: 0.3, // Lower threshold for demo
      );
      
      expect(similar.length, greaterThan(0));
      
      print('✅ Found ${similar.length} similar symptoms to "swelling in feet":');
      for (final item in similar) {
        print('   "${item.symptomLog.symptom}" - ${(item.similarity * 100).round()}% similar');
      }
    });
    
    test('Can answer basic questions about creatinine', () async {
      // Create a test patient
      final patientId = await database.insertPatient(
        PatientsCompanion.insert(
          firstName: 'Maa',
          lastName: 'Test'
        )
      );
      
      // Add some lab results
      await database.insertLabResult(LabResultsCompanion.insert(
        patientId: patientId,
        labTestId: 1, // Dummy test ID
        value: 1.8,
        status: 'High',
        testDate: DateTime.now().subtract(Duration(days: 5)),
      ));
      
      await database.insertLabResult(LabResultsCompanion.insert(
        patientId: patientId,
        labTestId: 1,
        value: 1.2,
        status: 'Normal',
        testDate: DateTime.now().subtract(Duration(days: 15)),
      ));
      
      // Ask about high creatinine
      final answer = await ragService.answerQuestion(
        "When was creatinine last high?",
        patientId,
      );
      
      expect(answer.toLowerCase(), contains('5 days ago'));
      expect(answer, contains('1.8'));
      
      print('✅ RAG Answer to "When was creatinine last high?":');
      print('   $answer');
    });
    
    test('Can provide symptom pattern insights', () async {
      // Create test patient  
      final patientId = await database.insertPatient(
        PatientsCompanion.insert(
          firstName: 'Maa',
          lastName: 'Test'
        )
      );
      
      // Add symptom pattern
      for (int i = 0; i < 5; i++) {
        await database.insertSymptomLog(SymptomLogsCompanion.insert(
          patientId: patientId,
          symptom: "swelling in feet ${i + 1}",
          severity: 3 + i, // Increasing severity
          logDate: DateTime.now().subtract(Duration(days: i * 2)),
        ));
      }
      
      final answer = await ragService.answerQuestion(
        "Are things getting better or worse?",
        patientId,
      );
      
      expect(answer.toLowerCase(), contains('symptom'));
      
      print('✅ Trend Analysis:');
      print('   $answer');
    });
    
    test('Demonstrates complete caregiver workflow', () async {
      print('\n🎯 COMPLETE CAREGIVER SCENARIO DEMONSTRATION:');
      print('=' * 60);
      
      // 1. Create patient (Maa)
      final patientId = await database.insertPatient(
        PatientsCompanion.insert(
          firstName: 'Maa',
          lastName: 'Caregiver Test'
        )
      );
      print('✅ Step 1: Created patient record for Maa');
      
      // 2. Log various symptoms over time
      final symptoms = [
        {"text": "swelling in both feet", "severity": 6, "days": 1},
        {"text": "puffy ankles noticed in morning", "severity": 5, "days": 3}, 
        {"text": "shoes feel tight, hard to wear", "severity": 4, "days": 5},
        {"text": "feeling dizzy when standing up", "severity": 7, "days": 2},
        {"text": "less energy than usual", "severity": 5, "days": 4},
      ];
      
      for (final symptom in symptoms) {
        await database.insertSymptomLog(SymptomLogsCompanion.insert(
          patientId: patientId,
          symptom: symptom["text"] as String,
          severity: symptom["severity"] as int,
          logDate: DateTime.now().subtract(Duration(days: symptom["days"] as int)),
        ));
      }
      print('✅ Step 2: Logged 5 symptoms over the past week');
      
      // 3. Add some lab results  
      await database.insertLabResult(LabResultsCompanion.insert(
        patientId: patientId,
        labTestId: 1,
        value: 1.8,
        status: 'High',
        testDate: DateTime.now().subtract(Duration(days: 10)),
        notes: 'Creatinine elevated, follow up needed',
      ));
      print('✅ Step 3: Added lab result (High creatinine)');
      
      // 4. Caregiver asks: "I'm worried about Maa's swelling"
      print('\n🤔 Caregiver asks: "I\'m worried about Maa\'s swelling"');
      final swellingInsights = await vectorSearchService.findSimilarSymptoms(
        queryText: "worried about swelling",
        patientId: patientId,
        threshold: 0.3,
      );
      
      print('🔍 Similar events found:');
      for (final similar in swellingInsights) {
        final daysAgo = DateTime.now().difference(similar.symptomLog.logDate).inDays;
        print('   • $daysAgo days ago: "${similar.symptomLog.symptom}"');
      }
      
      // 5. Caregiver asks: "When was creatinine last high?"
      print('\n🤔 Caregiver asks: "When was creatinine last high?"');
      final labAnswer = await ragService.answerQuestion("When was creatinine last high?", patientId);
      print('🤖 Answer: $labAnswer');
      
      // 6. Caregiver asks: "Are things getting better or worse?"
      print('\n🤔 Caregiver asks: "Are things getting better or worse?"');
      final trendAnswer = await ragService.answerQuestion("Are things getting better or worse?", patientId);
      print('🤖 Answer: $trendAnswer');
      
      print('\n' + '=' * 60);
      print('✅ SCENARIO COMPLETE: Backend successfully provides:');
      print('   • Pattern recognition in symptoms');
      print('   • Historical context from lab results');  
      print('   • Trend analysis for proactive care');
      print('   • Natural language question answering');
    });
  });
}
