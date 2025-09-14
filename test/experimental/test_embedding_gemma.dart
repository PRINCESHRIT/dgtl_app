import 'dart:io';
import '../../lib/core/ai/embedding_gemma_service.dart';

/// Test script for EmbeddingGemma Phase 1.4 implementation
void main() async {
  print('🚀 Testing EmbeddingGemma Phase 1.4 Implementation');
  print('=' * 60);
  
  // Initialize the service
  final embeddingService = EmbeddingGemmaService();
  
  try {
    // Test 1: Service Initialization
    print('\n📋 Test 1: Service Initialization');
    print('🔄 Preloading EmbeddingGemma model...');
    await embeddingService.preloadModel();
    print('✅ Service initialized: ${embeddingService.isModelLoaded}');
    
    // Test 2: Model Information
    print('\n📋 Test 2: Model Information');
    final modelInfo = embeddingService.getModelInfo();
    modelInfo.forEach((key, value) {
      print('  - $key: $value');
    });
    
    // Test 3: Basic Embedding Generation
    print('\n📋 Test 3: Basic Embedding Generation');
    final testText = 'Patient has elevated blood pressure and reports headache';
    print('🔄 Input text: "$testText"');
    
    final embedding1 = await embeddingService.generateEmbedding(testText);
    print('✅ Generated embedding: ${embedding1.length}D vector');
    print('📊 First 5 dimensions: ${embedding1.take(5).toList()}');
    
    // Test 4: Different Task Types
    print('\n📋 Test 4: Task-Specific Embeddings');
    final queryText = 'high blood pressure symptoms';
    final documentText = 'Hypertension is a condition where blood pressure is consistently elevated';
    
    final queryEmbedding = await embeddingService.generateEmbedding(
      queryText,
      task: 'retrieval_query',
    );
    
    final docEmbedding = await embeddingService.generateEmbedding(
      documentText,
      task: 'retrieval_document',
    );
    
    print('✅ Query embedding (${queryText.length} chars): ${queryEmbedding.length}D');
    print('✅ Document embedding (${documentText.length} chars): ${docEmbedding.length}D');
    
    // Test 5: Similarity Calculation
    print('\n📋 Test 5: Cosine Similarity');
    final similarity = embeddingService.calculateCosineSimilarity(
      queryEmbedding,
      docEmbedding,
    );
    print('🎯 Similarity between query and document: ${similarity.toStringAsFixed(4)}');
    
    // Test 6: Medical Text Processing
    print('\n📋 Test 6: Medical Domain Testing');
    final medicalTexts = [
      'Patient reports chest pain and shortness of breath',
      'Blood glucose level is 180 mg/dL, indicating hyperglycemia',
      'ECG shows normal sinus rhythm with no abnormalities',
      'Laboratory results show elevated creatinine and low eGFR',
      'Patient has been prescribed metformin for diabetes management'
    ];
    
    print('🔄 Processing ${medicalTexts.length} medical texts...');
    final medicalEmbeddings = <List<double>>[];
    
    for (int i = 0; i < medicalTexts.length; i++) {
      final text = medicalTexts[i];
      final embedding = await embeddingService.generateEmbedding(
        text,
        task: 'retrieval_document',
      );
      medicalEmbeddings.add(embedding);
      print('  ✅ Text ${i + 1}: ${embedding.length}D embedding generated');
    }
    
    // Test 7: Similarity Matrix
    print('\n📋 Test 7: Medical Text Similarity Matrix');
    print('Similarity scores between medical texts:');
    for (int i = 0; i < medicalEmbeddings.length; i++) {
      for (int j = i + 1; j < medicalEmbeddings.length; j++) {
        final similarity = embeddingService.calculateCosineSimilarity(
          medicalEmbeddings[i],
          medicalEmbeddings[j],
        );
        print('  Text ${i + 1} ↔ Text ${j + 1}: ${similarity.toStringAsFixed(4)}');
      }
    }
    
    // Test 8: Embedding Consistency
    print('\n📋 Test 8: Embedding Consistency');
    final sameText = 'diabetes blood sugar glucose';
    final embedding2a = await embeddingService.generateEmbedding(sameText);
    final embedding2b = await embeddingService.generateEmbedding(sameText);
    final consistency = embeddingService.calculateCosineSimilarity(embedding2a, embedding2b);
    print('🔄 Same text embedded twice');
    print('✅ Consistency score: ${consistency.toStringAsFixed(4)} (should be 1.0000)');
    
    // Test 9: Performance Test
    print('\n📋 Test 9: Performance Test');
    final startTime = DateTime.now();
    final performanceTexts = List.generate(10, (i) => 'Performance test text number $i with some medical terms like blood pressure hypertension diabetes');
    
    for (final text in performanceTexts) {
      await embeddingService.generateEmbedding(text);
    }
    
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    print('✅ Generated ${performanceTexts.length} embeddings in ${duration.inMilliseconds}ms');
    print('📊 Average: ${duration.inMilliseconds / performanceTexts.length}ms per embedding');
    
    // Final Summary
    print('\n' + '=' * 60);
    print('✅ EmbeddingGemma Phase 1.4 Implementation Test Complete!');
    print('📊 Summary:');
    print('  - Model loaded: ${embeddingService.isModelLoaded}');
    print('  - Embedding dimensions: ${embeddingService.embeddingDimensions}');
    print('  - Vocabulary size: ${embeddingService.vocabularySize}');
    print('  - Supported tasks: ${modelInfo['supportedTasks']}');
    print('  - Real model available: ${modelInfo['hasRealModel']}');
    
    if (!modelInfo['hasRealModel']) {
      print('\n💡 Note: Using development mode with semantic embeddings');
      print('💡 To use real EmbeddingGemma model:');
      print('   1. Obtain embedding-gemma-308m-e2b.tflite from Google');
      print('   2. Place in assets/models/ directory');
      print('   3. Restart the application');
    }
    
  } catch (e) {
    print('❌ Test failed: $e');
  } finally {
    // Cleanup
    await embeddingService.dispose();
    print('\n🧹 Service disposed');
  }
}
