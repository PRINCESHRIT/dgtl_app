/// Model Constants for AI Services
/// Phase 1.4 EmbeddingGemma Integration
/// 
/// Contains configuration constants for AI models, embedding dimensions,
/// and model-specific parameters used throughout the AI services.

class ModelConstants {
  // EmbeddingGemma Model Configuration
  static const String embeddingGemmaModelPath = 'assets/models/embedding_gemma_308m.tflite';
  static const String embeddingGemmaVocabPath = 'assets/vocab/gemma_vocab.txt';
  static const int embeddingGemmaDimensions = 768;
  static const int embeddingGemmaMaxSequenceLength = 512;
  static const String embeddingGemmaVersion = '308M';
  
  // Model File Names
  static const String embeddingModelFileName = 'embedding_gemma_308m.tflite';
  static const String vocabularyFileName = 'gemma_vocab.txt';
  
  // Special Tokens
  static const String unknownToken = '[UNK]';
  static const String padToken = '[PAD]';
  static const String classificationToken = '[CLS]';
  static const String separatorToken = '[SEP]';
  static const String maskToken = '[MASK]';
  
  // Embedding Configuration
  static const double embeddingNormalizationThreshold = 1e-8;
  static const double similarityThreshold = 0.7;
  static const int maxEmbeddingCacheSize = 1000;
  
  // Medical Domain Configuration
  static const List<String> medicalDomains = [
    'vital_signs',
    'lab_results', 
    'symptoms',
    'chronic_conditions',
    'medications',
    'procedures'
  ];
  
  // Model Performance Settings
  static const int inferenceThreads = 2;
  static const bool useGPUDelegate = false; // Set to true when GPU support is available
  static const bool useNNAPIDelegate = false; // Set to true for Android NNAPI
  
  // Cache and Performance
  static const Duration modelLoadTimeout = Duration(seconds: 30);
  static const Duration inferenceTimeout = Duration(seconds: 5);
  static const int maxBatchSize = 32;
  
  // Logging and Debug
  static const bool enableModelLogging = true;
  static const bool enablePerformanceMetrics = true;
  static const String logTag = 'ModelConstants';
}

/// Medical vocabulary constants for enhanced embedding quality
class MedicalVocabulary {
  static const List<String> vitalSigns = [
    'blood pressure', 'heart rate', 'temperature', 'respiratory rate',
    'oxygen saturation', 'pulse', 'systolic', 'diastolic', 'bpm', 'mmhg'
  ];
  
  static const List<String> labTests = [
    'glucose', 'hemoglobin', 'creatinine', 'cholesterol', 'triglycerides',
    'ldl', 'hdl', 'egfr', 'bun', 'sodium', 'potassium', 'chloride'
  ];
  
  static const List<String> symptoms = [
    'pain', 'fatigue', 'nausea', 'dizziness', 'headache', 'fever',
    'cough', 'shortness of breath', 'swelling', 'itching', 'rash'
  ];
  
  static const List<String> conditions = [
    'diabetes', 'hypertension', 'hyperlipidemia', 'kidney disease',
    'heart disease', 'obesity', 'depression', 'anxiety', 'arthritis'
  ];
  
  static const List<String> medications = [
    'metformin', 'lisinopril', 'atorvastatin', 'amlodipine', 'omeprazole',
    'levothyroxine', 'sertraline', 'gabapentin', 'losartan', 'simvastatin'
  ];
  
  static const List<String> units = [
    'mg/dl', 'mmol/l', 'mg', 'ml', 'g', 'kg', 'lb', 'cm', 'inch',
    'mmhg', 'celsius', 'fahrenheit', 'bpm', 'mg/l', 'iu/l'
  ];
}
