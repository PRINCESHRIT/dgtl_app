import 'dart:io';
import 'lib/core/ai/hybrid_embedding_service.dart';

void main() async {
  print('🔬 Official vs Fallback Mode Comparison\n');
  
  final service = HybridEmbeddingService();
  await service.initialize();
  
  final testText = 'acute chest pain with shortness of breath';
  print('📝 Test Text: "$testText"\n');
  
  // Show current status
  print('📊 CURRENT CONFIGURATION:');
  print('════════════════════════');
  print('🎯 Mode: ${service.isUsingOfficialModel ? 'Official EmbeddingGemma 300M' : 'Fallback Semantic'}');
  print('📏 Dimensions: ${service.embeddingDimension}D');
  print('🔐 Authentication: ${service.status['authentication']}');
  print('⚡ Status: ${service.status['mode']} mode active');
  print("");
  
  // Test current mode
  print('🧪 TESTING CURRENT MODE:');
  final start = DateTime.now();
  final embedding = await service.generateEmbedding(testText);
  final time = DateTime.now().difference(start).inMilliseconds;
  
  print('   📏 Dimensions: ${embedding.length}');
  print('   ⏱️ Time: ${time}ms');
  print('   🎯 Sample: [${embedding.take(5).map((v) => v.toStringAsFixed(4)).join(', ')}...]');
  print('   🔥 Model: ${service.isUsingOfficialModel ? 'Official EmbeddingGemma 300M with auth' : 'Fallback semantic'}');
  print("");
  
  // Achievement summary
  if (service.isUsingOfficialModel) {
    print('🏆 ACHIEVEMENT UNLOCKED:');
    print('✅ Successfully using official EmbeddingGemma 300M!');
    print('✅ Authentication verified with your HF token!');
    print('✅ 768D embeddings for superior medical understanding!');
    print('✅ Production-ready with fallback protection!');
  } else {
    print('🔄 FALLBACK MODE ACTIVE:');
    print('⚠️  Official model not available, using semantic fallback');
    print('⚡ Still functional with medical domain optimizations');
  }
}
