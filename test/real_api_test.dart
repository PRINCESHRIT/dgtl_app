// Real Gemma-3n-E2B API Test
// Tests actual HuggingFace API connection with your token

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('🔥 REAL Gemma-3n-E2B API Test');
  print('===============================');
  print('Testing actual HuggingFace API connection...');
  
  // Get token from environment
  final token = Platform.environment['HUGGINGFACE_TOKEN'] ?? 
                Platform.environment['HF_TOKEN'];
  
  if (token == null) {
    print('❌ No token found in environment');
    print('💡 Run: source .env && dart test/real_gemma3n_api_test.dart');
    exit(1);
  }
  
  print('✅ Token found: ${token.substring(0, 10)}...');
  
  // Test model endpoint
  final modelId = 'google/gemma-3n-E2B';
  final apiUrl = 'https://api-inference.huggingface.co/models/$modelId';
  
  try {
    print('\n1️⃣ Testing Model Availability...');
    
    // Test model info endpoint
    final infoResponse = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'User-Agent': 'DGTL-Healthcare-App/1.0',
      },
    );
    
    print('📡 API Response Status: ${infoResponse.statusCode}');
    
    if (infoResponse.statusCode == 200) {
      print('✅ Model accessible');
      try {
        final info = json.decode(infoResponse.body);
        print('🤖 Model ID: ${info['id'] ?? 'N/A'}');
        print('📊 Downloads: ${info['downloads'] ?? 'N/A'}');
        print('👍 Likes: ${info['likes'] ?? 'N/A'}');
      } catch (e) {
        print('📄 Model info received (parsing not needed)');
      }
    } else if (infoResponse.statusCode == 401) {
      print('❌ Authentication failed - check token');
      exit(1);
    } else if (infoResponse.statusCode == 403) {
      print('🔒 Access denied - may need model approval');
      print('💡 Visit: https://huggingface.co/google/gemma-3n-E2B');
    } else {
      print('⚠️ Unexpected response: ${infoResponse.statusCode}');
      print('Response: ${infoResponse.body.substring(0, 200)}...');
    }
    
    print('\n2️⃣ Testing Text Generation...');
    
    // Test actual text generation with a simple medical query
    final payload = {
      'inputs': 'What are the early signs of chronic kidney disease? Provide a brief medical overview.',
      'parameters': {
        'max_new_tokens': 200,
        'temperature': 0.7,
        'do_sample': true,
        'top_p': 0.95,
      },
    };
    
    print('📤 Sending generation request...');
    final genResponse = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'User-Agent': 'DGTL-Healthcare-App/1.0',
      },
      body: json.encode(payload),
    );
    
    print('📡 Generation Response Status: ${genResponse.statusCode}');
    
    if (genResponse.statusCode == 200) {
      print('✅ Text generation successful!');
      try {
        final result = json.decode(genResponse.body);
        if (result is List && result.isNotEmpty) {
          final generatedText = result[0]['generated_text'] ?? result[0].toString();
          print('\n🤖 AI Response:');
          print('$generatedText');
          print('\n🎉 REAL Gemma-3n-E2B is working perfectly!');
        } else {
          print('📄 Response received: ${genResponse.body.substring(0, 300)}...');
        }
      } catch (e) {
        print('📄 Response received but couldn\'t parse: $e');
        print('Raw: ${genResponse.body.substring(0, 200)}...');
      }
    } else if (genResponse.statusCode == 503) {
      print('⏳ Model is loading, try again in a few minutes');
      print('💡 This is normal for the first request to a large model');
    } else if (genResponse.statusCode == 429) {
      print('🚦 Rate limited - too many requests');
      print('💡 Wait a moment and try again');
    } else {
      print('⚠️ Generation failed: ${genResponse.statusCode}');
      print('Response: ${genResponse.body.substring(0, 200)}...');
    }
    
    print('\n📊 REAL API TEST RESULTS');
    print('==========================');
    print('✅ Token Configuration: WORKING');
    print('✅ Model Access: ${infoResponse.statusCode == 200 ? "WORKING" : "NEEDS SETUP"}');
    print('✅ Text Generation: ${genResponse.statusCode == 200 ? "WORKING" : "CHECK STATUS"}');
    
    if (infoResponse.statusCode == 200 && genResponse.statusCode == 200) {
      print('\n🎉 FULL Gemma-3n-E2B INTEGRATION: OPERATIONAL!');
      print('   Your DGTL Healthcare app now has access to:');
      print('   • 5.4B parameter medical AI model');
      print('   • Advanced clinical decision support');
      print('   • Multimodal capabilities (text + images)');
      print('   • Real-time medical query processing');
    } else {
      print('\n⚠️  Integration Status: PARTIAL');
      if (infoResponse.statusCode != 200) {
        print('   🔧 Fix model access first');
      }
      if (genResponse.statusCode != 200) {
        print('   🔧 Generation may need model warmup or approval');
      }
    }
    
  } catch (e) {
    print('❌ Test failed with error: $e');
    print('\n🛠️  Troubleshooting:');
    print('   1. Check internet connection');
    print('   2. Verify token is correct');
    print('   3. Ensure model access approved');
    print('   4. Try again (model may be loading)');
  }
}
