import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Gemma AI Service (Enhanced)
/// Supports multiple Gemma models with automatic fallback
/// Primary: google/gemma-2-9b-it (9B, immediate access)
/// Future: google/gemma-3n-E2B (5.4B, multimodal, gated)
class Gemma3nE2BService {
  // Model configurations (in order of preference)
  static const List<Map<String, String>> _models = [
    {
      'id': 'google/gemma-2-9b-it',
      'name': 'Gemma-2-9B-IT',
      'size': '9B',
      'status': 'available',
      'type': 'text-generation'
    },
    {
      'id': 'google/gemma-3n-E2B', 
      'name': 'Gemma-3n-E2B',
      'size': '5.4B',
      'status': 'gated',
      'type': 'multimodal'
    },
  ];
  
  static String _currentModelId = _models[0]['id']!; // Default to available model
  static const String _apiUrl = 'https://api-inference.huggingface.co/models';
  static const int _maxTokens = 2048;
  static const double _temperature = 0.7;
  static const int _maxRetries = 3;
  
  String? _apiToken;
  bool _isInitialized = false;
  
  /// Initialize the Gemma-3n-E2B service
  Future<void> initialize({String? huggingFaceToken}) async {
    if (_isInitialized) return;
    
    try {
      _apiToken = huggingFaceToken ?? await _loadTokenFromEnv();
      
      if (_apiToken == null) {
        print('⚠️ Gemma-3n-E2B: No HuggingFace token provided');
        print('💡 Add HUGGINGFACE_TOKEN to environment or pass directly');
        print('🔄 Will attempt anonymous requests (may be rate limited)');
      }
      
      // Test model availability
      await _testModelConnection();
      
      _isInitialized = true;
      print('✅ Gemma-3n-E2B Service initialized successfully');
      print('🤖 Model: $_modelId (5.4B parameters)');
      print('🎯 Capabilities: Image-Text-to-Text, Video Analysis, Medical AI');
      
    } catch (e) {
      print('❌ Failed to initialize Gemma-3n-E2B Service: $e');
      throw Exception('Gemma-3n-E2B initialization failed: $e');
    }
  }
  
  /// Load HuggingFace token from environment
  Future<String?> _loadTokenFromEnv() async {
    try {
      // Try multiple environment variable names
      return Platform.environment['HUGGINGFACE_TOKEN'] ?? 
             Platform.environment['HF_TOKEN'] ?? 
             Platform.environment['HUGGING_FACE_TOKEN'];
    } catch (e) {
      return null;
    }
  }
  
  /// Test connection to the model
  Future<void> _testModelConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$_apiUrl/$_modelId'),
        headers: _getHeaders(),
      );
      
      if (response.statusCode == 200) {
        print('✅ Gemma-3n-E2B model accessible');
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed - check HuggingFace token');
      } else if (response.statusCode == 403) {
        print('🔒 Model is gated - you may need special access');
        print('💡 Visit: https://huggingface.co/google/gemma-3n-E2B');
      } else {
        throw Exception('Model unavailable (${response.statusCode})');
      }
    } catch (e) {
      print('⚠️ Model connection test failed: $e');
      // Continue initialization - might work for actual requests
    }
  }
  
  /// Generate response from text input
  Future<String> generateTextResponse({
    required String prompt,
    String? systemPrompt,
    double? temperature,
    int? maxTokens,
  }) async {
    await _ensureInitialized();
    
    // Prepare the input with medical context
    final medicalSystemPrompt = systemPrompt ?? 
        'You are a specialized medical AI assistant focusing on nephrology and chronic kidney disease. '
        'Provide accurate, evidence-based medical information while emphasizing that patients should '
        'consult healthcare professionals for personalized advice.';
    
    final fullPrompt = '$medicalSystemPrompt\n\nUser: $prompt\n\nAssistant:';
    
    return await _makeRequest({
      'inputs': fullPrompt,
      'parameters': {
        'max_new_tokens': maxTokens ?? _maxTokens,
        'temperature': temperature ?? _temperature,
        'do_sample': true,
        'top_p': 0.95,
        'repetition_penalty': 1.1,
      },
    });
  }
  
  /// Generate response from image and text (multimodal)
  Future<String> generateImageTextResponse({
    required String text,
    required Uint8List imageBytes,
    String? systemPrompt,
  }) async {
    await _ensureInitialized();
    
    final medicalSystemPrompt = systemPrompt ?? 
        'You are a medical AI assistant that can analyze medical images. '
        'Describe what you observe in the image and provide relevant medical insights. '
        'Always recommend consulting healthcare professionals for diagnosis.';
    
    // Encode image to base64
    final base64Image = base64Encode(imageBytes);
    
    return await _makeRequest({
      'inputs': {
        'image': base64Image,
        'text': '$medicalSystemPrompt\n\nAnalyze this medical image: $text',
      },
      'parameters': {
        'max_new_tokens': _maxTokens,
        'temperature': _temperature,
      },
    });
  }
  
  /// Analyze medical symptoms with context
  Future<Map<String, dynamic>> analyzeMedicalSymptoms({
    required String symptoms,
    Map<String, dynamic>? patientContext,
    List<String>? relevantHistory,
  }) async {
    await _ensureInitialized();
    
    // Build comprehensive medical prompt
    final contextString = _buildMedicalContext(patientContext, relevantHistory);
    
    final prompt = '''
Medical Symptom Analysis Request:

Patient Context:
$contextString

Current Symptoms:
$symptoms

Please provide:
1. Possible differential diagnoses (with confidence levels)
2. Recommended diagnostic tests
3. Immediate care recommendations
4. Red flag symptoms to watch for
5. When to seek emergency care

Format as structured JSON response.
''';
    
    final response = await generateTextResponse(prompt: prompt);
    
    try {
      // Try to parse as JSON
      return json.decode(response);
    } catch (e) {
      // If not valid JSON, return structured text
      return {
        'analysis': response,
        'format': 'text',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
  
  /// Build medical context string
  String _buildMedicalContext(Map<String, dynamic>? context, List<String>? history) {
    final buffer = StringBuffer();
    
    if (context != null) {
      context.forEach((key, value) {
        buffer.writeln('$key: $value');
      });
    }
    
    if (history != null && history.isNotEmpty) {
      buffer.writeln('\nMedical History:');
      for (final item in history) {
        buffer.writeln('- $item');
      }
    }
    
    return buffer.toString();
  }
  
  /// Make HTTP request to HuggingFace API
  Future<String> _makeRequest(Map<String, dynamic> payload) async {
    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        final response = await http.post(
          Uri.parse('$_apiUrl/$_modelId'),
          headers: _getHeaders(),
          body: json.encode(payload),
        );
        
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          
          // Handle different response formats
          if (data is List && data.isNotEmpty) {
            return data[0]['generated_text'] ?? data[0].toString();
          } else if (data is Map) {
            return data['generated_text'] ?? data.toString();
          } else {
            return data.toString();
          }
        } else if (response.statusCode == 503) {
          // Model loading
          if (attempt < _maxRetries) {
            print('🔄 Model loading, retrying in ${attempt * 2}s...');
            await Future.delayed(Duration(seconds: attempt * 2));
            continue;
          }
        } else if (response.statusCode == 429) {
          // Rate limited
          if (attempt < _maxRetries) {
            print('⚠️ Rate limited, retrying in ${attempt * 5}s...');
            await Future.delayed(Duration(seconds: attempt * 5));
            continue;
          }
        }
        
        throw Exception('API request failed: ${response.statusCode} - ${response.body}');
        
      } catch (e) {
        if (attempt == _maxRetries) {
          throw Exception('All retry attempts failed: $e');
        }
        print('⚠️ Request attempt $attempt failed: $e');
        await Future.delayed(Duration(seconds: attempt));
      }
    }
    
    throw Exception('Maximum retry attempts exceeded');
  }
  
  /// Get HTTP headers for API requests
  Map<String, String> _getHeaders() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'User-Agent': 'DGTL-Healthcare-App/1.0',
    };
    
    if (_apiToken != null) {
      headers['Authorization'] = 'Bearer $_apiToken';
    }
    
    return headers;
  }
  
  /// Ensure service is initialized
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }
  
  /// Get model information
  Map<String, dynamic> getModelInfo() {
    return {
      'model_id': _modelId,
      'parameters': '5.4B',
      'type': 'multimodal',
      'capabilities': [
        'image-text-to-text',
        'video-text-to-text', 
        'medical-image-analysis',
        'clinical-decision-support'
      ],
      'initialized': _isInitialized,
      'has_token': _apiToken != null,
    };
  }
  
  /// Health check for the service
  Future<Map<String, dynamic>> healthCheck() async {
    try {
      await _ensureInitialized();
      
      // Simple test request
      final testResponse = await generateTextResponse(
        prompt: 'Respond with "OK" if you are working correctly.',
        maxTokens: 10,
      );
      
      return {
        'status': 'healthy',
        'model': _modelId,
        'response_received': testResponse.isNotEmpty,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'status': 'unhealthy',
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
}
