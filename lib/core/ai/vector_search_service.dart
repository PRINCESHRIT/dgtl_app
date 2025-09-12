import 'dart:math' as math;
import 'embedding_gemma_service.dart';
import '../database/database.dart';

/// Represents a similar symptom with its similarity score
class SimilarSymptom {
  final SymptomLog symptomLog;
  final double similarity;
  
  SimilarSymptom({
    required this.symptomLog,
    required this.similarity,
  });
}

/// Vector search service for finding similar symptoms and events
/// Uses cosine similarity to match embedded symptom descriptions
class VectorSearchService {
  final EmbeddingGemmaService embeddingService;
  final AppDatabase database;
  
  VectorSearchService({
    required this.embeddingService,
    required this.database,
  });
  
  /// Search for similar symptom logs using vector similarity
  Future<List<SimilarSymptom>> findSimilarSymptoms({
    required String queryText,
    required int patientId,
    int limit = 5,
    double threshold = 0.7,
  }) async {
    print('🔍 Searching for symptoms similar to: "$queryText"');
    
    // Generate embedding for the query
    final queryVector = await embeddingService.generateEmbedding(queryText);
    
    // Get all symptom logs for this patient
    final allSymptoms = await database.getSymptomsForPatient(patientId);
    
    final similarSymptoms = <SimilarSymptom>[];
    
    for (final symptom in allSymptoms) {
      // Generate embedding for stored symptom
      final symptomVector = await embeddingService.generateEmbedding(symptom.symptom);
      
      // Calculate cosine similarity
      final similarity = _cosineSimilarity(queryVector, symptomVector);
      
      // Only include if above threshold and not identical
      if (similarity >= threshold && similarity < 0.99) {
        similarSymptoms.add(SimilarSymptom(
          symptomLog: symptom,
          similarity: similarity,
        ));
      }
    }
    
    // Sort by similarity and return top results
    similarSymptoms.sort((a, b) => b.similarity.compareTo(a.similarity));
    return similarSymptoms.take(limit).toList();
  }
  
  /// Search for lab results with specific conditions
  Future<List<LabResult>> findLabResultsWithCondition({
    required int patientId,
    required String condition, // "high", "low", "abnormal"
    String? testName,
  }) async {
    print('🔍 Searching for $condition lab results${testName != null ? ' for $testName' : ''}');
    
    final allResults = await database.getLabResultsForPatient(patientId);
    
    return allResults.where((result) {
      // Filter by test name if specified
      if (testName != null) {
        // This would need to join with LabTests table in a real implementation
        // For now, we'll do a simple string match
        return result.status?.toLowerCase().contains(condition.toLowerCase()) == true;
      }
      return result.status?.toLowerCase().contains(condition.toLowerCase()) == true;
    }).toList();
  }
  
  /// Calculate cosine similarity between two vectors
  double _cosineSimilarity(List<double> vec1, List<double> vec2) {
    if (vec1.length != vec2.length) return 0.0;
    
    double dotProduct = 0.0;
    double norm1 = 0.0;
    double norm2 = 0.0;
    
    for (int i = 0; i < vec1.length; i++) {
      dotProduct += vec1[i] * vec2[i];
      norm1 += vec1[i] * vec1[i];
      norm2 += vec2[i] * vec2[i];
    }
    
    if (norm1 == 0.0 || norm2 == 0.0) return 0.0;
    
    return dotProduct / (math.sqrt(norm1) * math.sqrt(norm2));
  }
}
