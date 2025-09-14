import 'dart:io';
import 'dart:math' as math;
import 'package:test/test.dart';
import '../../../lib/core/ai/embedding_gemma_service.dart';

/// Simple test for EmbeddingGemma service with semantic embeddings
void main() {
  group('EmbeddingGemma Service Tests', () {
    late EmbeddingGemmaService service;

    setUp(() {
      service = EmbeddingGemmaService();
    });

    test('Service initialization', () async {
      await service.initialize();
      expect(service, isNotNull);
      print('✅ Service initialized successfully');
    });

    test('Basic embedding generation', () async {
      await service.initialize();
      
      const testText = 'Patient has elevated blood pressure and reports headache';
      final embedding = await service.generateEmbedding(testText);
      
      expect(embedding, isNotNull);
      expect(embedding.length, greaterThan(0));
      expect(embedding.length, equals(256)); // Expected dimension
      
      print('✅ Generated ${embedding.length}D embedding for medical text');
      print('   First 5 values: ${embedding.take(5).toList()}');
    });

    test('Medical text similarity', () async {
      await service.initialize();
      
      const text1 = 'chest pain and shortness of breath';
      const text2 = 'chest discomfort and difficulty breathing';
      const text3 = 'headache and nausea';
      
      final embedding1 = await service.generateEmbedding(text1);
      final embedding2 = await service.generateEmbedding(text2);
      final embedding3 = await service.generateEmbedding(text3);
      
      // Calculate cosine similarity
      final similarity12 = _cosineSimilarity(embedding1, embedding2);
      final similarity13 = _cosineSimilarity(embedding1, embedding3);
      
      expect(similarity12, greaterThan(similarity13));
      
      print('✅ Medical text similarity test passed');
      print('   Similar symptoms similarity: ${similarity12.toStringAsFixed(3)}');
      print('   Different symptoms similarity: ${similarity13.toStringAsFixed(3)}');
    });

    test('Embedding consistency', () async {
      await service.initialize();
      
      const testText = 'chronic kidney disease stage 3';
      
      final embedding1 = await service.generateEmbedding(testText);
      final embedding2 = await service.generateEmbedding(testText);
      
      final consistency = _cosineSimilarity(embedding1, embedding2);
      
      expect(consistency, greaterThan(0.99)); // Should be very similar
      
      print('✅ Embedding consistency test passed');
      print('   Consistency score: ${consistency.toStringAsFixed(4)}');
    });

    test('Hindi text support', () async {
      await service.initialize();
      
      const hindiText = 'सिरदर्द और चक्कर आना';
      const englishText = 'headache and dizziness';
      
      final hindiEmbedding = await service.generateEmbedding(hindiText);
      final englishEmbedding = await service.generateEmbedding(englishText);
      
      expect(hindiEmbedding, isNotNull);
      expect(englishEmbedding, isNotNull);
      expect(hindiEmbedding.length, equals(256));
      expect(englishEmbedding.length, equals(256));
      
      final crossLingualSimilarity = _cosineSimilarity(hindiEmbedding, englishEmbedding);
      
      print('✅ Hindi text support test passed');
      print('   Hindi text processed: ${hindiEmbedding.length}D embedding');
      print('   Cross-lingual similarity: ${crossLingualSimilarity.toStringAsFixed(3)}');
    });
  });
}

/// Calculate cosine similarity between two vectors
double _cosineSimilarity(List<double> a, List<double> b) {
  if (a.length != b.length) return 0.0;
  
  double dotProduct = 0.0;
  double normA = 0.0;
  double normB = 0.0;
  
  for (int i = 0; i < a.length; i++) {
    dotProduct += a[i] * b[i];
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }
  
  if (normA == 0.0 || normB == 0.0) return 0.0;
  return dotProduct / (math.sqrt(normA) * math.sqrt(normB));
}
