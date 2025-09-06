class ModelConstants {
  // EmbeddingGemma Configuration
  static const String embeddingModelPath = 'assets/models/embedding_gemma_308m.tflite';
  static const int embeddingDimensions = 768;
  static const List<int> matryoshkaDimensions = [128, 256, 512, 768];
  static const int maxEmbeddingInputLength = 512;
  static const double embeddingInferenceTimeoutMs = 15.0;
  
  // Gemma 3N Configuration
  static const String gemma3nE2BPath = 'assets/models/gemma3n_e2b.tflite';
  static const String gemma3nE4BPath = 'assets/models/gemma3n_e4b.tflite';
  static const int maxContextLength = 2048;
  static const int maxGenerationTokens = 512;
  static const double generationTimeoutSeconds = 3.0;
  
  // Model Performance Targets
  static const int maxMemoryUsageMB = 3000; // 3GB total
  static const int embeddingMemoryUsageMB = 200;
  static const int gemmaE2BMemoryUsageMB = 2000;
  static const int gemmaE4BMemoryUsageMB = 3000;
  
  // EdgeTPU Optimization
  static const bool useEdgeTPUByDefault = true;
  static const bool useGPUAcceleration = true;
  static const bool useCPUFallback = true;
  
  // Vector Search Configuration
  static const int defaultTopK = 10;
  static const double defaultSimilarityThreshold = 0.7;
  static const int maxVectorCacheSize = 1000;
  
  // RAG Pipeline Configuration
  static const int defaultContextRetrievalLimit = 5;
  static const int ragEmbeddingDimensions = 256; // Matryoshka optimized
  static const double ragSimilarityThreshold = 0.75;
}
