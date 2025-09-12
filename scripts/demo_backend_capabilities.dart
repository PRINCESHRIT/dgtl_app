import 'package:dgtl_app/core/database/database.dart';
import 'package:dgtl_app/core/ai/embedding_gemma_service.dart';
import 'package:dgtl_app/core/ai/vector_search_service.dart';
import 'package:dgtl_app/core/ai/gemma3n_rag_service.dart';

/// Demonstration of backend capabilities for caregiver scenario
void main() async {
  print('🎯 DGTL BACKEND CAPABILITIES DEMONSTRATION');
  print('=' * 50);
  
  // Initialize services
  final database = AppDatabase.memory();
  final embeddingService = EmbeddingGemmaService();
  final vectorSearchService = VectorSearchService(
    embeddingService: embeddingService,
    database: database,
  );
  final ragService = Gemma3NRagService(
    embeddingService: embeddingService,
    vectorSearch: vectorSearchService,
    database: database,
  );
  
  await embeddingService.initialize();
  
  print('✅ Services initialized successfully\n');
  
  // === CAPABILITY 1: Analyze Symptoms ===
  print('📊 CAPABILITY 1: Symptom Analysis');
  print('-' * 30);
  
  final symptomEmbedding = await embeddingService.generateEmbedding("Maa has swelling in her feet");
  print('✅ Generated embedding for "Maa has swelling in her feet"');
  print('   Dimensions: ${symptomEmbedding.length}');
  print('   Sample values: ${symptomEmbedding.take(5).map((v) => v.toStringAsFixed(3)).join(", ")}...\n');
  
  // === CAPABILITY 2: Find Similar Events ===
  print('🔍 CAPABILITY 2: Similar Event Detection');
  print('-' * 30);
  
  // Create test patient
  final patientId = await database.insertPatient(
    PatientsCompanion.insert(
      firstName: 'Maa',
      lastName: 'Demo'
    )
  );
  
  // Add historical symptoms
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
    symptom: "headache after walking",
    severity: 3,
    logDate: DateTime.now().subtract(Duration(days: 2)),
  ));
  
  // Search for similar symptoms
  final similarSymptoms = await vectorSearchService.findSimilarSymptoms(
    queryText: "swelling in feet",
    patientId: patientId,
    threshold: 0.3,
  );
  
  print('✅ Found ${similarSymptoms.length} similar symptoms to "swelling in feet":');
  for (final similar in similarSymptoms) {
    final daysAgo = DateTime.now().difference(similar.symptomLog.logDate).inDays;
    print('   • $daysAgo days ago: "${similar.symptomLog.symptom}" (${(similar.similarity * 100).round()}% similar)');
  }
  print('');
  
  // === CAPABILITY 3: Answer Questions ===
  print('💬 CAPABILITY 3: Question Answering');
  print('-' * 30);
  
  // Add lab results for testing
  await database.insertLabResult(LabResultsCompanion.insert(
    patientId: patientId,
    labTestId: 1,
    value: 1.8,
    status: 'High',
    testDate: DateTime.now().subtract(Duration(days: 5)),
  ));
  
  await database.insertLabResult(LabResultsCompanion.insert(
    patientId: patientId,
    labTestId: 2,
    value: 1.2,
    status: 'Normal',
    testDate: DateTime.now().subtract(Duration(days: 15)),
  ));
  
  // Test various questions
  final questions = [
    "When was creatinine last high?",
    "Show me recent symptoms",
    "Are things getting better or worse?",
  ];
  
  for (final question in questions) {
    print('❓ Question: "$question"');
    final answer = await ragService.answerQuestion(question, patientId);
    print('🤖 Answer: $answer\n');
  }
  
  // === REAL-WORLD SCENARIO ===
  print('🏥 REAL-WORLD CAREGIVER SCENARIO');
  print('-' * 30);
  
  print('📋 Scenario: Caregiver notices Maa has swelling and is worried');
  print('');
  
  // 1. Log the current concern
  await database.insertSymptomLog(SymptomLogsCompanion.insert(
    patientId: patientId,
    symptom: "Maa has swelling in both feet, looks worried",
    severity: 7,
    logDate: DateTime.now(),
  ));
  print('✅ Logged: "Maa has swelling in both feet, looks worried"');
  
  // 2. Ask for historical context
  final contextAnswer = await ragService.answerQuestion(
    "Has this happened before?", 
    patientId
  );
  print('🔍 Historical context: $contextAnswer');
  
  // 3. Check if lab results might be related
  final labAnswer = await ragService.answerQuestion(
    "When was creatinine last high?", 
    patientId
  );
  print('📊 Lab context: $labAnswer');
  
  // 4. Get trend analysis
  final trendAnswer = await ragService.answerQuestion(
    "Are things getting better or worse?", 
    patientId
  );
  print('📈 Trend analysis: $trendAnswer');
  
  print('\n' + '=' * 50);
  print('✅ DEMONSTRATION COMPLETE');
  print('🎯 The backend can RIGHT NOW:');
  print('   • Turn symptoms into searchable vectors');
  print('   • Find patterns in historical data'); 
  print('   • Answer questions in natural language');
  print('   • Provide context for worried caregivers');
  print('   • Track trends over time');
  print('');
  print('🚀 Ready for frontend integration!');
  
  // Cleanup
  await database.close();
}
