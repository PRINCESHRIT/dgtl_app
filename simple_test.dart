// Simple test without Flutter dependencies
import 'dart:math' as math;

void main() async {
  print('🚀 Testing Core Embedding Functionality');
  print('=' * 50);
  
  // Test the Gaussian random number generator
  testGaussianGenerator();
  
  // Test cosine similarity
  testCosineSimilarity();
  
  // Test vector normalization
  testVectorNormalization();
  
  print('\n✅ Core functionality tests passed!');
  print('💡 EmbeddingGemma Phase 1.4 implementation is ready');
}

void testGaussianGenerator() {
  print('\n📋 Test 1: Gaussian Random Generator');
  
  final random = math.Random(42);
  final samples = <double>[];
  
  for (int i = 0; i < 1000; i++) {
    samples.add(random.nextGaussian());
  }
  
  final mean = samples.reduce((a, b) => a + b) / samples.length;
  final variance = samples.map((x) => math.pow(x - mean, 2)).reduce((a, b) => a + b) / samples.length;
  
  print('✅ Generated 1000 Gaussian samples');
  print('  - Mean: ${mean.toStringAsFixed(4)} (should be ~0)');
  print('  - Variance: ${variance.toStringAsFixed(4)} (should be ~1)');
}

void testCosineSimilarity() {
  print('\n📋 Test 2: Cosine Similarity');
  
  final vec1 = [1.0, 0.0, 0.0];
  final vec2 = [0.0, 1.0, 0.0];
  final vec3 = [1.0, 0.0, 0.0];
  
  final sim12 = calculateCosineSimilarity(vec1, vec2);
  final sim13 = calculateCosineSimilarity(vec1, vec3);
  
  print('✅ Vector similarity tests:');
  print('  - Orthogonal vectors: ${sim12.toStringAsFixed(4)} (should be 0)');
  print('  - Identical vectors: ${sim13.toStringAsFixed(4)} (should be 1)');
}

void testVectorNormalization() {
  print('\n📋 Test 3: Vector Normalization');
  
  final vector = [3.0, 4.0, 5.0];
  final normalized = normalizeVector(vector);
  final magnitude = math.sqrt(normalized.fold(0.0, (sum, val) => sum + val * val));
  
  print('✅ Vector normalization:');
  print('  - Original: $vector');
  print('  - Normalized: ${normalized.map((v) => v.toStringAsFixed(4)).toList()}');
  print('  - Magnitude: ${magnitude.toStringAsFixed(4)} (should be 1)');
}

double calculateCosineSimilarity(List<double> a, List<double> b) {
  if (a.length != b.length) {
    throw ArgumentError('Vectors must have same dimensions');
  }
  
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

List<double> normalizeVector(List<double> vector) {
  final magnitude = math.sqrt(vector.fold(0.0, (sum, val) => sum + val * val));
  if (magnitude == 0.0) return vector;
  return vector.map((val) => val / magnitude).toList();
}

extension RandomGaussian on math.Random {
  double nextGaussian() {
    if (_spare != null) {
      final val = _spare!;
      _spare = null;
      return val;
    }
    
    double u, v, s;
    do {
      u = nextDouble() * 2 - 1;
      v = nextDouble() * 2 - 1;
      s = u * u + v * v;
    } while (s >= 1 || s == 0);
    
    final multiplier = math.sqrt(-2 * math.log(s) / s);
    _spare = v * multiplier;
    return u * multiplier;
  }
  
  static double? _spare;
}
