import 'package:flutter_test/flutter_test.dart';
import 'package:dgtl_app/core/ai/embedding_gemma_service.dart';
import 'dart:math' as math;

void main() {
  group('EmbeddingGemmaService Tests - Phase 1.4', () {
    late EmbeddingGemmaService embeddingService;

    setUp(() {
      embeddingService = EmbeddingGemmaService();
    });

    tearDown(() async {
      await embeddingService.dispose();
    });

    test('should initialize model successfully', () async {
      expect(embeddingService.isModelLoaded, isFalse);
      
      await embeddingService.preloadModel();
      
      expect(embeddingService.isModelLoaded, isTrue);
      expect(embeddingService.embeddingDimensions, equals(768));
      expect(embeddingService.vocabularySize, greaterThan(0));
    });

    test('should generate consistent embeddings for same text', () async {
      const testText = 'Patient has high blood pressure and diabetes';
      
      final embedding1 = await embeddingService.generateEmbedding(testText);
      final embedding2 = await embeddingService.generateEmbedding(testText);
      
      expect(embedding1.length, equals(768));
      expect(embedding2.length, equals(768));
      
      // Should be identical (deterministic)
      for (int i = 0; i < embedding1.length; i++) {
        expect(embedding1[i], closeTo(embedding2[i], 1e-10));
      }
    });

    test('should generate different embeddings for different texts', () async {
      const text1 = 'Patient has high blood pressure';
      const text2 = 'Patient has low cholesterol levels';
      
      final embedding1 = await embeddingService.generateEmbedding(text1);
      final embedding2 = await embeddingService.generateEmbedding(text2);
      
      expect(embedding1.length, equals(embedding2.length));
      
      // Should be different
      final similarity = embeddingService.cosineSimilarity(embedding1, embedding2);
      expect(similarity, lessThan(0.99)); // Not identical
    });

    test('should generate normalized embeddings', () async {
      const testText = 'Glucose levels are elevated at 150 mg/dl';
      
      final embedding = await embeddingService.generateEmbedding(testText);
      
      // Check if vector is normalized (magnitude should be ~1.0)
      double magnitude = 0.0;
      for (final value in embedding) {
        magnitude += value * value;
      }
      magnitude = math.sqrt(magnitude);
      
      expect(magnitude, closeTo(1.0, 0.01));
    });

    test('should handle medical terminology appropriately', () async {
      const medicalText = 'Creatinine 1.2 mg/dl, eGFR 65, hemoglobin 12.5 g/dl';
      const generalText = 'The weather is nice today';
      
      final medicalEmbedding = await embeddingService.generateEmbedding(medicalText);
      final generalEmbedding = await embeddingService.generateEmbedding(generalText);
      
      expect(medicalEmbedding.length, equals(768));
      expect(generalEmbedding.length, equals(768));
      
      // Medical text should cluster differently
      final similarity = embeddingService.cosineSimilarity(medicalEmbedding, generalEmbedding);
      expect(similarity, lessThan(0.85)); // Should be fairly different
    });

    test('should calculate cosine similarity correctly', () async {
      const text1 = 'Blood pressure is high';
      const text2 = 'Hypertension detected';
      const unrelatedText = 'Beautiful sunset today';
      
      final embedding1 = await embeddingService.generateEmbedding(text1);
      final embedding2 = await embeddingService.generateEmbedding(text2);
      final embedding3 = await embeddingService.generateEmbedding(unrelatedText);
      
      final similarity12 = embeddingService.cosineSimilarity(embedding1, embedding2);
      final similarity13 = embeddingService.cosineSimilarity(embedding1, embedding3);
      
      // Medical texts should be more similar than medical vs non-medical
      expect(similarity12, greaterThan(similarity13));
      expect(similarity12, greaterThan(0.0));
      expect(similarity12, lessThanOrEqualTo(1.0));
    });

    test('should handle empty text gracefully', () async {
      final embedding = await embeddingService.generateEmbedding('');
      
      expect(embedding.length, equals(768));
      expect(embedding.every((value) => value == 0.0), isTrue);
    });

    test('should handle very long text', () async {
      final longText = 'Patient history: ' + 
          List.generate(200, (i) => 'chronic condition $i diabetes hypertension').join(' ');
      
      final embedding = await embeddingService.generateEmbedding(longText);
      
      expect(embedding.length, equals(768));
      
      // Should still be normalized
      double magnitude = 0.0;
      for (final value in embedding) {
        magnitude += value * value;
      }
      expect(math.sqrt(magnitude), closeTo(1.0, 0.01));
    });

    test('should preload model only once', () async {
      expect(embeddingService.isModelLoaded, isFalse);
      
      await embeddingService.preloadModel();
      expect(embeddingService.isModelLoaded, isTrue);
      
      // Second call should not reload
      await embeddingService.preloadModel();
      expect(embeddingService.isModelLoaded, isTrue);
    });

    test('should dispose resources properly', () async {
      await embeddingService.preloadModel();
      expect(embeddingService.isModelLoaded, isTrue);
      
      await embeddingService.dispose();
      expect(embeddingService.isModelLoaded, isFalse);
      expect(embeddingService.vocabularySize, equals(0));
    });

    test('should cluster similar medical concepts', () async {
      // Test medical concept clustering
      final texts = [
        'Blood pressure 140/90 mmHg',
        'Hypertension stage 1',
        'Elevated systolic pressure',
        'Glucose level 180 mg/dl',
        'Diabetes mellitus type 2',
        'High blood sugar',
      ];
      
      final embeddings = <List<double>>[];
      for (final text in texts) {
        embeddings.add(await embeddingService.generateEmbedding(text));
      }
      
      // BP-related texts (0, 1, 2) should be similar
      final bpSimilarity01 = embeddingService.cosineSimilarity(embeddings[0], embeddings[1]);
      final bpSimilarity02 = embeddingService.cosineSimilarity(embeddings[0], embeddings[2]);
      
      // Diabetes-related texts (3, 4, 5) should be similar  
      final diabetesSimilarity34 = embeddingService.cosineSimilarity(embeddings[3], embeddings[4]);
      final diabetesSimilarity35 = embeddingService.cosineSimilarity(embeddings[3], embeddings[5]);
      
      // Cross-category should be less similar
      final crossSimilarity03 = embeddingService.cosineSimilarity(embeddings[0], embeddings[3]);
      
      expect(bpSimilarity01, greaterThan(0.3));
      expect(bpSimilarity02, greaterThan(0.3));
      expect(diabetesSimilarity34, greaterThan(0.3));
      expect(diabetesSimilarity35, greaterThan(0.3));
      expect(crossSimilarity03, lessThan(math.max(bpSimilarity01, diabetesSimilarity34)));
    });
  });
}
