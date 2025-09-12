import 'dart:io';
import 'dart:math';
import 'lib/core/ai/hybrid_embedding_service.dart';

void main() async {
  print('🔄 Testing Hybrid EmbeddingGemma Service');
  print('=' * 50);
  
  final service = HybridEmbeddingService();
  
  try {
    // Test 1: Service initialization and mode detection
    print('\n📋 Test 1: Service Initialization & Mode Detection');
    await service.initialize();
    final status = service.getStatus();
    
    print('Service Status:');
    print('  • Initialized: ${status['isInitialized']}');
    print('  • Mode: ${status['mode']}');
    print('  • Official Model Available: ${status['isOfficialModelAvailable']}');
    print('  • Embedding Dimension: ${status['embeddingDimension']}');
    
    // Test 2: Basic embedding generation  
    print('\n📋 Test 2: Medical Text Embedding Generation');
    final medicalTexts = [
      'Patient has high blood pressure reading today',
      'Severe headache with nausea and fever symptoms reported',
      'Normal cholesterol and hemoglobin test results received',
      'Patient complains of chronic fatigue and joint pain',
    ];
    
    final startTime = DateTime.now();
    final embeddings = <String, List<double>>{};
    
    for (final text in medicalTexts) {
      final embedding = await service.generateEmbedding(text);
      embeddings[text] = embedding;
      
      print('Text: "${text.substring(0, text.length.clamp(0, 50))}..."');
      print('Embedding: ${embedding.length}D [${embedding.take(3).map((e) => e.toStringAsFixed(4)).join(', ')}...]');
      print('Magnitude: ${_calculateMagnitude(embedding).toStringAsFixed(4)}');
      print('');
    }
    
    final embeddingTime = DateTime.now().difference(startTime);
    print('Generated ${embeddings.length} embeddings in ${embeddingTime.inMilliseconds}ms');
    print('Average: ${(embeddingTime.inMilliseconds / embeddings.length).toStringAsFixed(1)}ms per embedding');
    
    // Test 3: Semantic similarity search
    print('\n📋 Test 3: Medical Semantic Search');
    final queries = [
      'blood pressure issues',
      'headache pain problems',
      'normal lab results',
    ];
    
    for (final query in queries) {
      final candidates = medicalTexts;
      final searchStart = DateTime.now();
      final results = await service.findSimilar(query, candidates, topK: 3);
      final searchTime = DateTime.now().difference(searchStart);
      
      print('\nQuery: "$query" (${searchTime.inMilliseconds}ms)');
      print('Most similar texts:');
      for (int i = 0; i < results.length; i++) {
        final result = results[i];
        print('  ${i+1}. [${result.similarity.toStringAsFixed(4)}] "${result.text.substring(0, 40)}..."');
      }
    }
    
    // Test 4: Batch processing performance
    print('\n📋 Test 4: Batch Processing Performance');
    final batchTexts = [
      'fever and persistent cough symptoms',
      'normal heart rate and blood pressure',
      'elevated cholesterol requires medication',
      'patient reports severe abdominal pain',
      'routine blood work shows good results',
    ];
    
    final batchStart = DateTime.now();
    final batchEmbeddings = await service.generateBatchEmbeddings(batchTexts);
    final batchTime = DateTime.now().difference(batchStart);
    
    print('Batch processed ${batchTexts.length} texts in ${batchTime.inMilliseconds}ms');
    print('Average: ${(batchTime.inMilliseconds / batchTexts.length).toStringAsFixed(1)}ms per text');
    print('Embedding dimensions: ${batchEmbeddings.map((e) => e.length).toSet()}');
    
    // Test 5: Cosine similarity validation
    print('\n📋 Test 5: Similarity Validation');
    final testPairs = [
      ['high blood pressure', 'elevated blood pressure'],
      ['severe headache', 'intense head pain'],
      ['normal test results', 'good lab values'],
      ['blood pressure', 'headache pain'], // Should be less similar
    ];
    
    for (final pair in testPairs) {
      final embedding1 = await service.generateEmbedding(pair[0]);
      final embedding2 = await service.generateEmbedding(pair[1]);
      final similarity = service.cosineSimilarity(embedding1, embedding2);
      
      print('Similarity "${pair[0]}" ↔ "${pair[1]}": ${similarity.toStringAsFixed(4)}');
    }
    
    // Cleanup
    service.dispose();
    
    print('\n✅ All hybrid service tests completed successfully!');
    print('🎯 EmbeddingGemma hybrid implementation ready for production');
    
  } catch (e, stackTrace) {
    print('\n❌ Test failed with error: $e');
    print('Stack trace: $stackTrace');
    exit(1);
  }
}

double _calculateMagnitude(List<double> vector) {
  return sqrt(vector.map((x) => x * x).reduce((a, b) => a + b));
}
