import 'package:test/test.dart';
import '../lib/services/gemma_embedding_service.dart';
import '../lib/services/vector_search_service.dart';

// Mock GemmaEmbeddingService to avoid making real HTTP calls in tests.
class MockGemmaEmbeddingService extends GemmaEmbeddingService {
  @override
  Future<List<double>> generateEmbedding(Map<String, dynamic> payload) async {
    // This mock will return a predefined vector based on the payload content.
    // This simulates the behavior of a real embedding service.
    if (payload['query_text'] == 'uncontrolled hypertension in CKD G4') {
      return [0.15, 0.85, 0.25, 0.75]; // A vector close to the BP guideline
    }
    return [0.0, 0.0, 0.0, 0.0]; // Default zero-vector
  }
}

void main() {
  group('Week 2: Vector Search Integration', () {
    late MockGemmaEmbeddingService embeddingService;
    late VectorSearchService vectorSearchService;

    setUp(() {
      embeddingService = MockGemmaEmbeddingService();
      vectorSearchService = VectorSearchService();
    });

    test('Should retrieve relevant clinical documents based on a patient query', () async {
      // 1. Define a clinical query for a patient.
      final patientQuery = {
        'patient_id': 'PID12345',
        'query_text': 'uncontrolled hypertension in CKD G4',
        'context': {
          'eGFR': 16.8,
          'blood_pressure': '143/94 mmHg',
        }
      };

      // 2. Generate an embedding for the query using the (mocked) Gemma service.
      final queryVector = await embeddingService.generateEmbedding(patientQuery);

      // 3. Use the generated vector to search for relevant documents.
      final searchResults = await vectorSearchService.search(queryVector);

      // 4. Assert the expected outcome.
      // We expect the most relevant document to be the KDIGO BP guideline.
      expect(searchResults, isNotEmpty);
      expect(searchResults.first['id'], equals('doc_kdigo_bp_guideline'));
      expect(searchResults.first['score'], greaterThan(0.95)); // Expect high similarity

      print('Vector search test passed!');
      print('Query: "${patientQuery['query_text']}"');
      print('Query Vector: $queryVector');
      print('Top matching document: ${searchResults.first['id']} (Score: ${searchResults.first['score']})');
    });
  });
}
