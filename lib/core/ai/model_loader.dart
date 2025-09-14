import 'dart:io';
import 'dart:convert';

/// DGTL Healthcare Model Loader
/// Handles loading and validation of TensorFlow Lite models
/// with automatic fallback detection
class DgtlModelLoader {
  static const int _minEmbeddingModelSize = 50 * 1024 * 1024; // 50MB
  static const int _minGenerationModelSize = 500 * 1024 * 1024; // 500MB
  
  /// Check if we have full TensorFlow Lite models or fallback mode
  static Future<Map<String, dynamic>> getModelStatus() async {
    final embeddingFile = File('assets/models/embedding-gemma-308m-e2b.tflite');
    final generationFile = File('assets/models/gemma-2b-it.tflite');
    final configFile = File('assets/models/embedding_config.json');
    
    final embeddingExists = await embeddingFile.exists();
    final generationExists = await generationFile.exists();
    final configExists = await configFile.exists();
    
    int embeddingSize = 0;
    int generationSize = 0;
    Map<String, dynamic> config = {};
    
    if (embeddingExists) embeddingSize = await embeddingFile.length();
    if (generationExists) generationSize = await generationFile.length();
    if (configExists) {
      final configContent = await configFile.readAsString();
      config = jsonDecode(configContent);
    }
    
    return {
      'embedding_model': {
        'exists': embeddingExists,
        'size_mb': (embeddingSize / (1024 * 1024)).toStringAsFixed(1),
        'is_full_model': embeddingSize > _minEmbeddingModelSize,
        'mode': embeddingSize > _minEmbeddingModelSize ? 'full_tflite' : 'fallback',
        'status': embeddingSize > _minEmbeddingModelSize ? '🤖 Full Model' : '🔄 Fallback Mode'
      },
      'generation_model': {
        'exists': generationExists,
        'size_mb': (generationSize / (1024 * 1024)).toStringAsFixed(1),
        'is_full_model': generationSize > _minGenerationModelSize,
        'mode': generationSize > _minGenerationModelSize ? 'full_tflite' : 'fallback',
        'status': generationSize > _minGenerationModelSize ? '🤖 Full Model' : '🔄 Fallback Mode'
      },
      'configuration': config,
      'overall_mode': (embeddingSize > _minEmbeddingModelSize && generationSize > _minGenerationModelSize) 
        ? 'production' : 'development',
      'upgrade_needed': embeddingSize < _minEmbeddingModelSize || generationSize < _minGenerationModelSize
    };
  }
  
  /// Validate model files and suggest actions
  static Future<void> validateAndReport() async {
    print('🔍 DGTL Model Status Check');
    print('==========================');
    
    final status = await getModelStatus();
    
    print('📊 Embedding Model (Gemma 308M):');
    print('   Status: ${status['embedding_model']['status']}');
    print('   Size: ${status['embedding_model']['size_mb']} MB');
    print('   Mode: ${status['embedding_model']['mode']}');
    
    print('\n📊 Generation Model (Gemma 2B):');
    print('   Status: ${status['generation_model']['status']}');
    print('   Size: ${status['generation_model']['size_mb']} MB');
    print('   Mode: ${status['generation_model']['mode']}');
    
    print('\n🎯 Overall Status: ${status['overall_mode'].toString().toUpperCase()}');
    
    if (status['upgrade_needed'] == true) {
      print('\n💡 Upgrade Available:');
      print('   Run: bash scripts/upgrade_gemma_models.sh');
      print('   This will upgrade to full TensorFlow Lite models');
    } else {
      print('\n✅ All models are production-ready!');
    }
  }
}
