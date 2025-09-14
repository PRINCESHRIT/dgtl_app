// Test script to verify Google Gemma models functionality
// Tests both Embedding Gemma (308M) and Gemma 2B Instruction-Tuned models

import 'dart:io';
import '../lib/core/services/service_locator.dart';
import '../lib/core/ai/embedding_gemma_service.dart';
import '../lib/core/ai/dgtl_rag_service.dart';

void main() async {
  print('🧪 Testing Google Gemma Models');
  print('=================================');
  
  try {
    // Initialize the service locator
    print('\n1️⃣ Initializing DGTL Services...');
    await DgtlServiceLocator.initialize();
    print('✅ Services initialized');
    
    // Test 1: Embedding Gemma (308M parameters)
    print('\n2️⃣ Testing Embedding Gemma (308M)...');
    await testEmbeddingGemma();
    
    // Test 2: Gemma 2B Instruction-Tuned (Generation)
    print('\n3️⃣ Testing Gemma 2B Instruction-Tuned...');
    await testGemma2BGeneration();
    
    // Test 3: End-to-end RAG pipeline
    print('\n4️⃣ Testing Complete RAG Pipeline...');
    await testFullRAGPipeline();
    
    print('\n🎉 All Gemma model tests completed!');
    
  } catch (e) {
    print('❌ Test failed: $e');
    exit(1);
  }
}

Future<void> testEmbeddingGemma() async {
  try {
    final embeddingService = DgtlServiceLocator.getIt<EmbeddingGemmaService>();
    
    // Test medical text embedding
    final medicalText = "Patient has elevated creatinine levels of 2.5 mg/dL";
    
    print('   📝 Input: "$medicalText"');
    
    final embedding = await embeddingService.getEmbedding(medicalText);
    
    if (embedding != null && embedding.isNotEmpty) {
      print('   ✅ Embedding generated: ${embedding.length} dimensions');
      print('   📊 Sample values: [${embedding.take(5).map((e) => e.toStringAsFixed(3)).join(', ')}...]');
      
      // Test if embeddings are meaningful (not all zeros/ones)
      final hasVariation = embedding.any((val) => val > 0.1) && embedding.any((val) => val < 0.1);
      if (hasVariation) {
        print('   ✅ Embedding has semantic variation');
      } else {
        print('   ⚠️  Embedding lacks variation (may be fallback mode)');
      }
    } else {
      print('   ❌ Failed to generate embedding');
    }
  } catch (e) {
    print('   ❌ Embedding test failed: $e');
  }
}

Future<void> testGemma2BGeneration() async {
  try {
    final ragService = DgtlServiceLocator.getIt<DgtlRagService>();
    
    // Test medical question answering
    final medicalQuery = "What does elevated creatinine indicate?";
    
    print('   🤔 Query: "$medicalQuery"');
    
    final response = await ragService.answerMedicalQuestion(
      question: medicalQuery,
      patientId: 'test-patient-123',
      context: {
        'recent_labs': {'creatinine': 2.5, 'BUN': 45},
        'symptoms': ['fatigue', 'swelling']
      }
    );
    
    if (response != null && response.isNotEmpty) {
      print('   ✅ Generated response: ${response.length} characters');
      print('   💬 Response preview: "${response.substring(0, response.length < 100 ? response.length : 100)}..."');
      
      // Check if response contains medical terminology
      final containsMedicalTerms = response.toLowerCase().contains('creatinine') || 
                                  response.toLowerCase().contains('kidney') ||
                                  response.toLowerCase().contains('renal');
      
      if (containsMedicalTerms) {
        print('   ✅ Response contains relevant medical terminology');
      } else {
        print('   ⚠️  Response may be generic (fallback mode)');
      }
    } else {
      print('   ❌ Failed to generate response');
    }
  } catch (e) {
    print('   ❌ Generation test failed: $e');
  }
}

Future<void> testFullRAGPipeline() async {
  try {
    final ragService = DgtlServiceLocator.getIt<DgtlRagService>();
    
    print('   🔄 Testing full RAG pipeline...');
    
    // Test retrieval + generation pipeline
    final complexQuery = "Show me the patient's CKD progression and recommend next steps";
    
    final result = await ragService.processComplexMedicalQuery(
      query: complexQuery,
      patientId: 'test-patient-456',
      includeContext: true
    );
    
    if (result != null) {
      print('   ✅ RAG pipeline functional');
      print('   📋 Result type: ${result.runtimeType}');
      
      if (result is Map<String, dynamic>) {
        final keys = result.keys.toList();
        print('   🔑 Result keys: ${keys.join(', ')}');
        
        if (result.containsKey('answer')) {
          final answer = result['answer']?.toString() ?? '';
          print('   💬 Answer length: ${answer.length} characters');
        }
        
        if (result.containsKey('confidence')) {
          print('   📊 Confidence: ${result['confidence']}');
        }
      }
    } else {
      print('   ⚠️  RAG pipeline returned null (may be in fallback mode)');
    }
  } catch (e) {
    print('   ❌ RAG pipeline test failed: $e');
  }
}
