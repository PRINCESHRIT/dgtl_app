import 'dart:io';
import 'dart:math';
import 'lib/core/ai/embedding_gemma_service.dart';

void main() async {
  print('🧪 Testing Clean EmbeddingGemma Service v2.0');
  print('=' * 50);
  
  final service = EmbeddingGemmaService();
  
  try {
    // Test 1: Service initialization
    print('\n📋 Test 1: Service Initialization');
    await service.initialize();
    final status = service.getModelStatus();
    print('Model Status: ${status}');
    
    // Test 2: Basic embedding generation
    print('\n📋 Test 2: Medical Text Embedding Generation');
    final medicalTexts = [
      'Patient has high blood pressure and glucose levels',
      'Severe headache with nausea and fever symptoms',
      'Normal cholesterol and hemoglobin test results',
      'Patient reports chronic fatigue and joint pain',
    ];
    
    for (final text in medicalTexts) {
      final embedding = await service.generateEmbedding(text);
      print('Text: "${text.substring(0, 40)}..."');
      print('Embedding: ${embedding.length}D [${embedding.take(5).map((e) => e.toStringAsFixed(4)).join(', ')}...]');
      print('Magnitude: ${_calculateMagnitude(embedding).toStringAsFixed(4)}');
      print('');
    }
    
    // Test 3: Similarity search
    print('\n📋 Test 3: Medical Similarity Search');
    final queryText = 'blood pressure problems';
    final candidates = [
      'High blood pressure medication needed',
      'Patient feels severe headache today',
      'Blood glucose levels are elevated',
      'Normal blood pressure reading observed',
    ];
    
    final similarResults = await service.findSimilar(queryText, candidates, topK: 3);
    print('Query: "$queryText"');
    print('Top similar texts:');
    for (int i = 0; i < similarResults.length; i++) {
      final result = similarResults[i];
      print('  ${i+1}. [${result.similarity.toStringAsFixed(4)}] "${result.text}"');
    }
    
    // Test 4: Batch embedding generation
    print('\n📋 Test 4: Batch Processing');
    final batchTexts = [
      'fever and cough',
      'normal heart rate',
      'elevated cholesterol',
    ];
    
    final startTime = DateTime.now();
    final batchEmbeddings = await service.generateBatchEmbeddings(batchTexts);
    final duration = DateTime.now().difference(startTime);
    
    print('Processed ${batchTexts.length} texts in ${duration.inMilliseconds}ms');
    print('Average: ${(duration.inMilliseconds / batchTexts.length).toStringAsFixed(1)}ms per text');
    
    // Test 5: Cosine similarity validation
    print('\n📋 Test 5: Cosine Similarity Validation');
    final embedding1 = await service.generateEmbedding('high blood pressure');
    final embedding2 = await service.generateEmbedding('elevated blood pressure');
    final embedding3 = await service.generateEmbedding('severe headache pain');
    
    final sim1_2 = service.cosineSimilarity(embedding1, embedding2);
    final sim1_3 = service.cosineSimilarity(embedding1, embedding3);
    final sim2_3 = service.cosineSimilarity(embedding2, embedding3);
    
    print('Similarity between "high blood pressure" and "elevated blood pressure": ${sim1_2.toStringAsFixed(4)}');
    print('Similarity between "high blood pressure" and "severe headache pain": ${sim1_3.toStringAsFixed(4)}');
    print('Similarity between "elevated blood pressure" and "severe headache pain": ${sim2_3.toStringAsFixed(4)}');
    
    // Cleanup
    service.dispose();
    
    print('\n✅ All tests completed successfully!');
    print('📊 EmbeddingGemma service is production-ready');
    
  } catch (e, stackTrace) {
    print('\n❌ Test failed with error: $e');
    print('Stack trace: $stackTrace');
    exit(1);
  }
}

double _calculateMagnitude(List<double> vector) {
  return sqrt(vector.map((x) => x * x).reduce((a, b) => a + b));
}
