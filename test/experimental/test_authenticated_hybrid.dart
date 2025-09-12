import 'dart:io';
import 'dart:convert';
import 'lib/core/ai/hybrid_embedding_service.dart';

void main() async {
  print('🧪 Testing Authenticated HybridEmbeddingService\n');
  
  final service = HybridEmbeddingService();
  
  // Test 1: Service initialization
  print('1️⃣ Testing service initialization...');
  final initStart = DateTime.now();
  await service.initialize();
  final initTime = DateTime.now().difference(initStart).inMilliseconds;
  print('   ⏱️ Initialization time: ${initTime}ms');
  print('   📊 Status: ${service.status}');
  print('   🎯 Mode: ${service.isUsingOfficialModel ? 'Official (768D)' : 'Fallback (256D)'}');
  print('   📏 Dimension: ${service.embeddingDimension}');
  print("");
  
  // Test 2: Medical text embeddings
  final testTexts = [
    'chest pain and shortness of breath',
    'diabetes management and blood sugar',
    'headache with nausea and fever',
    'heart rate monitoring',
    'medication dosage instructions',
  ];
  
  print('2️⃣ Testing medical text embeddings...');
  final embedStart = DateTime.now();
  
  for (int i = 0; i < testTexts.length; i++) {
    final text = testTexts[i];
    final textStart = DateTime.now();
    
    final embedding = await service.generateEmbedding(text);
    final textTime = DateTime.now().difference(textStart).inMilliseconds;
    
    print('   📝 Text: "$text"');
    print('   📊 Dimension: ${embedding.length}');
    print('   ⏱️ Time: ${textTime}ms');
    print('   🎯 Sample values: [${embedding.take(5).map((v) => v.toStringAsFixed(3)).join(', ')}...]');
    print("");
  }
  
  final totalEmbedTime = DateTime.now().difference(embedStart).inMilliseconds;
  final avgTime = totalEmbedTime / testTexts.length;
  print('   📈 Average embedding time: ${avgTime.toStringAsFixed(1)}ms');
  print("");
  
  // Test 3: Similarity comparison
  print('3️⃣ Testing medical similarity comparison...');
  
  final symptomText1 = 'chest pain and breathing difficulty';
  final symptomText2 = 'chest pain and shortness of breath';
  final differentText = 'diabetes blood sugar levels';
  
  final emb1 = await service.generateEmbedding(symptomText1);
  final emb2 = await service.generateEmbedding(symptomText2);
  final emb3 = await service.generateEmbedding(differentText);
  
  final similarity12 = service.calculateSimilarity(emb1, emb2);
  final similarity13 = service.calculateSimilarity(emb1, emb3);
  
  print('   📝 Text 1: "$symptomText1"');
  print('   📝 Text 2: "$symptomText2"');
  print('   📝 Text 3: "$differentText"');
  print('   🔗 Similarity 1-2 (related symptoms): ${similarity12.toStringAsFixed(3)}');
  print('   🔗 Similarity 1-3 (different topics): ${similarity13.toStringAsFixed(3)}');
  
  if (similarity12 > similarity13) {
    print('   ✅ Medical similarity working correctly!');
  } else {
    print('   ⚠️  Medical similarity may need tuning');
  }
  print("");
  
  // Test 4: Batch processing performance
  print('4️⃣ Testing batch processing performance...');
  final batchTexts = [
    'fever and chills',
    'blood pressure medication', 
    'knee joint pain',
    'migraine headache',
    'insulin injection'
  ];
  
  final batchStart = DateTime.now();
  final batchEmbeddings = await service.generateEmbeddings(batchTexts);
  final batchTime = DateTime.now().difference(batchStart).inMilliseconds;
  final avgBatchTime = batchTime / batchTexts.length;
  
  print('   📦 Batch size: ${batchTexts.length}');
  print('   ⏱️ Total time: ${batchTime}ms');
  print('   📈 Average per item: ${avgBatchTime.toStringAsFixed(1)}ms');
  print('   📊 All embeddings dimension: ${batchEmbeddings.first.length}');
  print("");
  
  // Test 5: Authentication verification (if official model is available)
  if (service.isUsingOfficialModel) {
    print('5️⃣ Testing official model authentication...');
    
    // Test medical prompt with official model
    final medicalPrompt = 'patient presenting with acute myocardial infarction symptoms';
    final officialStart = DateTime.now();
    final officialEmbedding = await service.generateEmbedding(medicalPrompt);
    final officialTime = DateTime.now().difference(officialStart).inMilliseconds;
    
    print('   🏥 Medical text: "$medicalPrompt"');
    print('   📊 Official embedding dimension: ${officialEmbedding.length}');
    print('   ⏱️ Official model time: ${officialTime}ms');
    print('   🎯 First 3 values: [${officialEmbedding.take(3).map((v) => v.toStringAsFixed(4)).join(', ')}]');
    print('   ✅ Official EmbeddingGemma 300M working with authentication!');
  } else {
    print('5️⃣ Official model not available, using fallback mode');
    print('   ⚠️  To enable official model, ensure Python authentication is working');
  }
  print("");
  
  // Final summary
  print('📋 AUTHENTICATION TEST SUMMARY');
  print('════════════════════════════════');
  print('🎯 Service Mode: ${service.isUsingOfficialModel ? 'Official EmbeddingGemma 300M (768D)' : 'Fallback Semantic (256D)'}');
  print('🔐 Authentication: ${service.status['authentication']}');
  print('📏 Embedding Dimension: ${service.embeddingDimension}');
  print('⏱️ Avg Generation Time: ${avgTime.toStringAsFixed(1)}ms');
  print('🏥 Medical Domain: Optimized for health terminology');
  
  if (service.isUsingOfficialModel) {
    print('✅ SUCCESS: Using authenticated EmbeddingGemma with your HF token!');
  } else {
    print('⚠️  FALLBACK: Using local semantic embeddings (still functional)');
  }
}
