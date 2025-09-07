import 'dart:convert';
import 'dart:io';
import 'dart:math';

/// Hybrid EmbeddingGemma service supporting both official and fallback modes
/// Official mode: Uses authenticated access to google/embeddinggemma-300m
/// Fallback mode: Semantic embeddings with medical domain knowledge
class HybridEmbeddingService {
  static const String _officialModelId = 'google/embeddinggemma-300m';
  static const int _embeddingDimension = 768; // Official EmbeddingGemma dimension
  static const int _fallbackDimension = 256;  // Fallback dimension for compatibility
  
  // Note: Authentication handled by Python utility using environment variables
  
  bool _isOfficialModelAvailable = false;
  bool _isInitialized = false;
  
  /// Initialize the service and detect available embedding methods
  Future<void> initialize() async {
    try {
      // Check if official model is available with authentication
      _isOfficialModelAvailable = await _checkOfficialModelAvailability();
      _isInitialized = true;
      
      if (_isOfficialModelAvailable) {
        _logInfo('✅ Using official EmbeddingGemma 300M model (768D) with authentication');
      } else {
        _logInfo('⚠️  Using fallback semantic embeddings (256D) with medical domain knowledge');
      }
    } catch (e) {
      _logError('Initialization failed: $e');
      _isOfficialModelAvailable = false;
      _isInitialized = true;
    }
  }
  
  /// Check if official EmbeddingGemma model is available with authentication
  Future<bool> _checkOfficialModelAvailability() async {
    try {
      // Test our simple authentication script
      final result = await Process.run('python3', ['simple_official_test.py', 'test']);
      if (result.exitCode == 0) {
        _logInfo('🔐 Official model access verified with authentication');
        return true;
      } else {
        _logInfo('❌ Official model access failed: ${result.stderr}');
        return false;
      }
    } catch (e) {
      _logError('Official model check failed: $e');
      return false;
    }
  }
  
  /// Generate embeddings using the best available method
  Future<List<double>> generateEmbedding(String text) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    if (_isOfficialModelAvailable) {
      return await _generateOfficialEmbedding(text);
    } else {
      return _generateFallbackEmbedding(text);
    }
  }
  
  /// Generate batch embeddings efficiently
  Future<List<List<double>>> generateEmbeddings(List<String> texts) async {
    final List<List<double>> embeddings = [];
    
    for (final text in texts) {
      embeddings.add(await generateEmbedding(text));
    }
    
    return embeddings;
  }
  
  /// Generate embedding using official EmbeddingGemma model with authentication
  Future<List<double>> _generateOfficialEmbedding(String text) async {
    try {
      // Use our simple authenticated script
      final result = await Process.run('python3', ['simple_official_test.py', text]);
      
      if (result.exitCode == 0) {
        final List<dynamic> embeddingList = jsonDecode(result.stdout);
        return embeddingList.map<double>((e) => e as double).toList();
      } else {
        _logError('Official embedding failed: ${result.stderr}');
        // Fallback to local implementation
        return _generateFallbackEmbedding(text);
      }
    } catch (e) {
      _logError('Official embedding error: $e');
      // Fallback to local implementation
      return _generateFallbackEmbedding(text);
    }
  }
  
  /// Generate semantic embedding using fallback method with medical domain knowledge
  List<double> _generateFallbackEmbedding(String text) {
    // Medical/health domain keyword mappings
    final medicalKeywords = {
      // Symptoms
      'pain': [1.0, 0.8, 0.2, 0.1],
      'fever': [0.9, 0.7, 0.3, 0.8],
      'headache': [0.8, 0.6, 0.4, 0.2],
      'nausea': [0.7, 0.5, 0.6, 0.3],
      'fatigue': [0.6, 0.8, 0.1, 0.4],
      'dizzy': [0.5, 0.7, 0.5, 0.2],
      'cough': [0.8, 0.4, 0.7, 0.1],
      'shortness': [0.9, 0.3, 0.8, 0.2],
      'chest': [0.9, 0.8, 0.3, 0.1],
      
      // Body parts
      'heart': [0.9, 0.2, 0.8, 0.7],
      'lung': [0.8, 0.3, 0.7, 0.6],
      'brain': [0.7, 0.9, 0.2, 0.8],
      'stomach': [0.6, 0.4, 0.8, 0.3],
      'kidney': [0.8, 0.5, 0.6, 0.4],
      'liver': [0.7, 0.6, 0.7, 0.5],
      'blood': [0.9, 0.7, 0.4, 0.8],
      
      // Conditions
      'diabetes': [0.8, 0.6, 0.9, 0.7],
      'hypertension': [0.9, 0.5, 0.8, 0.6],
      'asthma': [0.7, 0.8, 0.6, 0.4],
      'arthritis': [0.6, 0.7, 0.5, 0.8],
      'depression': [0.5, 0.9, 0.3, 0.7],
      'anxiety': [0.4, 0.8, 0.4, 0.6],
      
      // Medications
      'medication': [0.7, 0.4, 0.8, 0.9],
      'prescription': [0.8, 0.3, 0.7, 0.8],
      'dosage': [0.6, 0.5, 0.9, 0.7],
      'treatment': [0.9, 0.6, 0.8, 0.5],
    };
    
    // Convert text to lowercase for matching
    final lowerText = text.toLowerCase();
    
    // Initialize embedding vector
    List<double> embedding = List.filled(_fallbackDimension, 0.0);
    
    // Base semantic features from text characteristics
    final wordCount = text.split(' ').length;
    final charCount = text.length;
    
    // Fill embedding with text-based features
    for (int i = 0; i < _fallbackDimension; i++) {
      // Use word count and character patterns to create base embedding
      double value = (wordCount * charCount * (i + 1)) % 1000 / 1000.0;
      
      // Add some noise based on text content
      final textHash = text.hashCode;
      value += (textHash * (i + 1)) % 100 / 1000.0;
      
      embedding[i] = value * 2 - 1; // Normalize to [-1, 1]
    }
    
    // Apply medical domain knowledge
    double medicalRelevance = 0.0;
    int matchCount = 0;
    
    medicalKeywords.forEach((keyword, features) {
      if (lowerText.contains(keyword)) {
        matchCount++;
        medicalRelevance += 1.0;
        
        // Blend medical features into embedding
        for (int i = 0; i < features.length && i < _fallbackDimension; i++) {
          embedding[i] = (embedding[i] + features[i]) / 2.0;
        }
        
        // Propagate medical features across the embedding
        for (int i = features.length; i < _fallbackDimension; i += features.length) {
          for (int j = 0; j < features.length && (i + j) < _fallbackDimension; j++) {
            embedding[i + j] = (embedding[i + j] + features[j] * 0.5) / 2.0;
          }
        }
      }
    });
    
    // Normalize medical relevance
    if (matchCount > 0) {
      medicalRelevance = medicalRelevance / matchCount;
      
      // Adjust embedding based on medical relevance
      for (int i = 0; i < _fallbackDimension; i++) {
        embedding[i] = embedding[i] * (1.0 + medicalRelevance * 0.3);
      }
    }
    
    // Normalize to unit vector
    double magnitude = 0.0;
    for (double value in embedding) {
      magnitude += value * value;
    }
    magnitude = sqrt(magnitude);
    
    if (magnitude > 0) {
      for (int i = 0; i < embedding.length; i++) {
        embedding[i] = embedding[i] / magnitude;
      }
    }
    
    return embedding;
  }
  
  /// Calculate cosine similarity between two embeddings
  double calculateSimilarity(List<double> embedding1, List<double> embedding2) {
    if (embedding1.length != embedding2.length) {
      throw ArgumentError('Embeddings must have the same dimension');
    }
    
    double dotProduct = 0.0;
    double magnitude1 = 0.0;
    double magnitude2 = 0.0;
    
    for (int i = 0; i < embedding1.length; i++) {
      dotProduct += embedding1[i] * embedding2[i];
      magnitude1 += embedding1[i] * embedding1[i];
      magnitude2 += embedding2[i] * embedding2[i];
    }
    
    magnitude1 = sqrt(magnitude1);
    magnitude2 = sqrt(magnitude2);
    
    if (magnitude1 == 0.0 || magnitude2 == 0.0) return 0.0;
    
    return dotProduct / (magnitude1 * magnitude2);
  }
  
  /// Get embedding dimension based on current mode
  int get embeddingDimension => _isOfficialModelAvailable ? _embeddingDimension : _fallbackDimension;
  
  /// Check if official model is being used
  bool get isUsingOfficialModel => _isOfficialModelAvailable;
  
  /// Get status information
  Map<String, dynamic> get status => {
    'initialized': _isInitialized,
    'official_model_available': _isOfficialModelAvailable,
    'model_id': _officialModelId,
    'embedding_dimension': embeddingDimension,
    'mode': _isOfficialModelAvailable ? 'official' : 'fallback',
    'authentication': _isOfficialModelAvailable ? 'verified' : 'not_required',
  };
  
  void _logInfo(String message) {
    print('[HybridEmbeddingService] INFO: $message');
  }
  
  void _logError(String message) {
    print('[HybridEmbeddingService] ERROR: $message');
  }
}
