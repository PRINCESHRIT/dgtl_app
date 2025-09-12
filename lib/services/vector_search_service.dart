import 'dart:math';

// A placeholder for a vector search service.
// In a real application, this would connect to a vector database like Pinecone,
// Chroma, or a custom-built search index.
class VectorSearchService {
  // A mock database of pre-computed vectors and their corresponding documents.
  // The keys are document IDs, and the values are the vector embeddings.
  final Map<String, List<double>> _mockVectorDB = {
    'doc_kdigo_bp_guideline': [0.1, 0.9, 0.2, 0.8], // Example vector
    'doc_kdigo_anemia_guideline': [0.8, 0.2, 0.9, 0.1], // Example vector
    'paper_on_sglt2i_in_ckd': [0.2, 0.8, 0.3, 0.7], // Example vector
  };

  /// Calculates the cosine similarity between two vectors.
  double _cosineSimilarity(List<double> vec1, List<double> vec2) {
    if (vec1.length != vec2.length) {
      throw ArgumentError('Vectors must have the same dimension');
    }

    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < vec1.length; i++) {
      dotProduct += vec1[i] * vec2[i];
      normA += pow(vec1[i], 2);
      normB += pow(vec2[i], 2);
    }

    if (normA == 0 || normB == 0) {
      return 0.0;
    }

    return dotProduct / (sqrt(normA) * sqrt(normB));
  }

  /// Searches the vector database for the most similar documents.
  ///
  /// Takes a [queryVector] and returns a list of document IDs sorted by similarity.
  Future<List<Map<String, dynamic>>> search(List<double> queryVector, {int topK = 2}) async {
    if (queryVector.isEmpty) {
      return [];
    }

    var results = <Map<String, dynamic>>[];

    _mockVectorDB.forEach((docId, docVector) {
      final similarity = _cosineSimilarity(queryVector, docVector);
      results.add({'id': docId, 'score': similarity});
    });

    // Sort results by score in descending order
    results.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

    // Return the top K results
    return results.take(topK).toList();
  }
}
