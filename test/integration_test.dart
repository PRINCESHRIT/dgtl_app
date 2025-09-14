// DGTL Healthcare Integration Test
// Tests Database + AI/ML/RAG + Backend connectivity

import 'dart:io';
import '../lib/core/services/service_locator.dart';
import '../lib/core/api/backend_controller.dart';

void main() async {
  print('🧪 DGTL Healthcare Integration Test');
  print('=====================================');
  
  try {
    // 1. Initialize Services
    print('\n1️⃣  Initializing Services...');
    await DgtlServiceLocator.initialize();
    print('✅ Service Locator initialized');
    
    await DgtlBackendController.initialize();
    print('✅ Backend Controller initialized');
    
    // 2. Health Check
    print('\n2️⃣  Running Health Check...');
    final healthStatus = await DgtlBackendController.healthCheck();
    print('📊 Health Status:');
    healthStatus.forEach((key, value) {
      print('   $key: $value');
    });
    
    // 3. Test Database Connection
    print('\n3️⃣  Testing Database Connection...');
    final database = DgtlServiceLocator.database;
    print('✅ Database service obtained');
    
    // 4. Test AI/ML/RAG Connection  
    print('\n4️⃣  Testing AI/ML/RAG Connection...');
    try {
      final ragService = DgtlServiceLocator.ragService;
      print('✅ RAG service obtained');
      
      // Test a simple RAG query
      final ragResponse = await DgtlBackendController.ragQuery(
        query: 'What is hypertension?',
        context: {'test': true},
      );
      print('🤖 RAG Query Test:');
      print('   Success: ${ragResponse['success']}');
      if (ragResponse['success'] == true) {
        print('   Response length: ${ragResponse['rag_response'].toString().length} chars');
      } else {
        print('   Error: ${ragResponse['error']}');
      }
    } catch (e) {
      print('⚠️  RAG test error: $e');
    }
    
    // 5. Test Backend API Endpoints
    print('\n5️⃣  Testing Backend API Endpoints...');
    
    // Test CKD Assessment
    try {
      final ckdResponse = await DgtlBackendController.assessCkd(
        patientData: {
          'age': 65,
          'creatinine': 1.5,
          'egfr': 45,
          'test_mode': true,
        },
      );
      print('🏥 CKD Assessment:');
      print('   Success: ${ckdResponse['success']}');
    } catch (e) {
      print('⚠️  CKD test error: $e');
    }
    
    // Test Chat Query
    try {
      final chatResponse = await DgtlBackendController.processChatQuery(
        query: 'What should I know about diabetes?',
        context: 'test_context',
        patientContext: {'test': true},
      );
      print('💬 Chat Query:');
      print('   Success: ${chatResponse['success']}');
      if (chatResponse['success'] == true) {
        print('   Response length: ${chatResponse['response'].toString().length} chars');
      }
    } catch (e) {
      print('⚠️  Chat test error: $e');
    }
    
    // Test Symptom Processing
    try {
      final symptomResponse = await DgtlBackendController.processSymptoms(
        symptoms: [
          {'name': 'headache', 'severity': 7, 'duration': '2 days'},
          {'name': 'fatigue', 'severity': 5, 'duration': '1 week'},
        ],
        patientContext: {'age': 45, 'test': true},
      );
      print('🩺 Symptom Processing:');
      print('   Success: ${symptomResponse['success']}');
    } catch (e) {
      print('⚠️  Symptom test error: $e');
    }
    
    // 6. Test Service Health
    print('\n6️⃣  Service Health Summary...');
    final serviceHealth = await DgtlServiceLocator.healthCheck();
    print('📈 Service Health:');
    serviceHealth.forEach((service, status) {
      final emoji = status ? '✅' : '❌';
      print('   $emoji $service: ${status ? 'HEALTHY' : 'OFFLINE'}');
    });
    
    // 7. Integration Status
    print('\n🎉 INTEGRATION TEST COMPLETE!');
    print('=====================================');
    
    final overallHealth = healthStatus['status'] == 'healthy';
    final dbConnected = healthStatus['database_connected'] == true;
    final aiConnected = healthStatus['ai_ml_rag_connected'] == true;  
    final backendConnected = healthStatus['backend_connected'] == true;
    
    print('📊 FINAL RESULTS:');
    print('   ${overallHealth ? '✅' : '❌'} Overall System: ${overallHealth ? 'HEALTHY' : 'ISSUES'}');
    print('   ${dbConnected ? '✅' : '❌'} Database Connected: $dbConnected');
    print('   ${aiConnected ? '✅' : '❌'} AI/ML/RAG Connected: $aiConnected');
    print('   ${backendConnected ? '✅' : '❌'} Backend Connected: $backendConnected');
    
    if (overallHealth && dbConnected && aiConnected && backendConnected) {
      print('\n🎊 SUCCESS: All systems fully integrated and operational!');
      exit(0);
    } else {
      print('\n⚠️  WARNING: Some systems need attention');
      exit(1);
    }
    
  } catch (e, stackTrace) {
    print('\n❌ TEST FAILED: $e');
    print('Stack trace: $stackTrace');
    exit(1);
  }
}
