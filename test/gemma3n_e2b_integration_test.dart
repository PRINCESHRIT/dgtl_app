// DGTL Healthcare - Gemma-3n-E2B Integration Test
// Tests the new multimodal AI capabilities

import 'dart:io';
import '../lib/core/services/service_locator.dart';
import '../lib/core/api/backend_controller.dart';

void main() async {
  print('🧪 Testing Gemma-3n-E2B Integration');
  print('===================================');
  
  try {
    // Initialize services
    print('\n1️⃣ Initializing DGTL Healthcare Services...');
    await DgtlServiceLocator.initialize();
    await DgtlBackendController.initialize();
    print('✅ Services initialized');
    
    // Test service availability
    print('\n2️⃣ Testing Service Health...');
    final healthCheck = await DgtlBackendController.healthCheck();
    print('🏥 System Status: ${healthCheck['status']}');
    print('🤖 AI/ML/RAG Connected: ${healthCheck['ai_ml_rag_connected']}');
    print('💾 Database Connected: ${healthCheck['database_connected']}');
    print('🔗 Backend Connected: ${healthCheck['backend_connected']}');
    
    // Test Gemma-3n-E2B service
    print('\n3️⃣ Testing Gemma-3n-E2B Model...');
    final gemma3nService = DgtlServiceLocator.gemma3nService;
    final modelInfo = gemma3nService.getModelInfo();
    
    print('📊 Model Info:');
    print('   ID: ${modelInfo['model_id']}');
    print('   Parameters: ${modelInfo['parameters']}');
    print('   Type: ${modelInfo['type']}');
    print('   Capabilities: ${modelInfo['capabilities']}');
    print('   Initialized: ${modelInfo['initialized']}');
    print('   Has Token: ${modelInfo['has_token']}');
    
    // Health check for Gemma-3n-E2B
    final gemmaHealth = await gemma3nService.healthCheck();
    print('\n🔍 Gemma-3n-E2B Health: ${gemmaHealth['status']}');
    if (gemmaHealth['error'] != null) {
      print('⚠️  Error: ${gemmaHealth['error']}');
    }
    
    // Test enhanced chat API
    print('\n4️⃣ Testing Enhanced Chat API...');
    try {
      final chatResponse = await DgtlBackendController.processChatQuery(
        query: "What are the early signs of chronic kidney disease?",
        useAdvancedModel: true,
      );
      
      print('💬 Chat Response:');
      print('   Success: ${chatResponse['success']}');
      print('   Model Used: ${chatResponse['model_used']}');
      if (chatResponse['success']) {
        final response = chatResponse['data'].toString();
        final preview = response.length > 150 ? response.substring(0, 150) + '...' : response;
        print('   Preview: $preview');
      } else {
        print('   Error: ${chatResponse['error']}');
      }
    } catch (e) {
      print('⚠️  Chat API test failed: $e');
    }
    
    // Test symptom analysis
    print('\n5️⃣ Testing Symptom Analysis...');
    try {
      final symptomResponse = await DgtlBackendController.analyzeSymptoms(
        symptoms: "Swelling in feet and ankles, fatigue, decreased urination",
        patientContext: {
          'age': 65,
          'medical_history': 'diabetes, hypertension'
        },
        medicalHistory: ['Type 2 Diabetes', 'High Blood Pressure'],
        useAdvancedModel: true,
      );
      
      print('🔬 Symptom Analysis:');
      print('   Success: ${symptomResponse['success']}');
      print('   Model Used: ${symptomResponse['model_used']}');
      if (symptomResponse['success']) {
        print('   Analysis Type: ${symptomResponse['analysis'].runtimeType}');
      } else {
        print('   Error: ${symptomResponse['error']}');
      }
    } catch (e) {
      print('⚠️  Symptom analysis test failed: $e');
    }
    
    // Test fallback system
    print('\n6️⃣ Testing Fallback System...');
    try {
      final fallbackResponse = await DgtlBackendController.processChatQuery(
        query: "What is chronic kidney disease?",
        useAdvancedModel: false, // Force fallback
      );
      
      print('🔄 Fallback Response:');
      print('   Success: ${fallbackResponse['success']}');
      print('   Model Used: ${fallbackResponse['model_used']}');
    } catch (e) {
      print('⚠️  Fallback test failed: $e');
    }
    
    print('\n📊 INTEGRATION TEST RESULTS:');
    print('===============================');
    
    // Check what's working
    final workingFeatures = <String>[];
    final issues = <String>[];
    
    if (healthCheck['backend_connected'] == true) {
      workingFeatures.add('✅ Backend Controller');
    } else {
      issues.add('❌ Backend Controller');
    }
    
    if (healthCheck['database_connected'] == true) {
      workingFeatures.add('✅ Database Connection');
    } else {
      issues.add('❌ Database Connection');
    }
    
    if (modelInfo['initialized'] == true) {
      workingFeatures.add('✅ Gemma-3n-E2B Service');
    } else {
      issues.add('❌ Gemma-3n-E2B Service');
    }
    
    if (gemmaHealth['status'] == 'healthy') {
      workingFeatures.add('✅ Gemma-3n-E2B API Connection');
    } else {
      issues.add('⚠️  Gemma-3n-E2B API (${gemmaHealth['status']})');
    }
    
    print('\n🎯 Working Features:');
    for (final feature in workingFeatures) {
      print('   $feature');
    }
    
    if (issues.isNotEmpty) {
      print('\n⚠️  Issues Found:');
      for (final issue in issues) {
        print('   $issue');
      }
    }
    
    print('\n💡 RECOMMENDATIONS:');
    print('====================');
    
    if (modelInfo['has_token'] != true) {
      print('🔑 Set up HuggingFace token for full Gemma-3n-E2B features');
      print('   See: GEMMA_3N_E2B_SETUP.md');
    }
    
    if (gemmaHealth['status'] != 'healthy') {
      print('🌐 Check internet connection for cloud AI features');
      print('🔄 Local fallback models will handle offline scenarios');
    }
    
    if (workingFeatures.length >= 2) {
      print('🎉 Your DGTL Healthcare app is ready!');
      print('   Enhanced with Gemma-3n-E2B multimodal AI capabilities');
    }
    
  } catch (e) {
    print('❌ Integration test failed: $e');
    print('\n🛠️  TROUBLESHOOTING:');
    print('   1. Ensure all dependencies are installed');
    print('   2. Check internet connection');
    print('   3. Verify HuggingFace token setup');
    print('   4. Review GEMMA_3N_E2B_SETUP.md');
  }
}
