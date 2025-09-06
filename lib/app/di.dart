import 'package:get_it/get_it.dart';
import '../core/database/database.dart';
import '../core/security/secure_storage_service.dart';
import '../core/ai/embedding_gemma_service.dart';
import '../core/ai/gemma3n_rag_service.dart';
import '../core/ai/vector_search_service.dart';

final GetIt getIt = GetIt.instance;

/// Initialize all dependencies for the DGTL app
/// This should be called in main() before runApp()
Future<void> setupDependencies() async {
  // Database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  
  // Security Services
  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  
  // AI Services - Order matters due to dependencies
  getIt.registerLazySingleton<EmbeddingGemmaService>(() => EmbeddingGemmaService());
  getIt.registerLazySingleton<VectorSearchService>(() => VectorSearchService(
    embeddingService: getIt<EmbeddingGemmaService>(),
    database: getIt<AppDatabase>(),
  ));
  getIt.registerLazySingleton<Gemma3NRagService>(() => Gemma3NRagService(
    embeddingService: getIt<EmbeddingGemmaService>(),
    vectorSearch: getIt<VectorSearchService>(),
    database: getIt<AppDatabase>(),
  ));
  
  // Initialize services that require async setup
  await _initializeAsyncServices();
}

/// Initialize services that require async setup
Future<void> _initializeAsyncServices() async {
  try {
    // Initialize database
    final db = getIt<AppDatabase>();
    // Database will be initialized on first access
    
    // Initialize secure storage
    final secureStorage = getIt<SecureStorageService>();
    await secureStorage.initialize();
    
    // Preload AI models in background (optional for faster first inference)
    final embeddingService = getIt<EmbeddingGemmaService>();
    // Note: We don't await this to avoid blocking app startup
    embeddingService.preloadModel();
    
    print('✅ DGTL dependencies initialized successfully');
  } catch (e) {
    print('❌ Failed to initialize dependencies: $e');
    rethrow;
  }
}

/// Clean up all resources before app shutdown
Future<void> disposeDependencies() async {
  try {
    // Close database connections
    final db = getIt<AppDatabase>();
    await db.close();
    
    // Dispose AI services
    final embeddingService = getIt<EmbeddingGemmaService>();
    await embeddingService.dispose();
    
    final ragService = getIt<Gemma3NRagService>();
    await ragService.dispose();
    
    // Reset GetIt
    await getIt.reset();
    
    print('✅ DGTL dependencies disposed successfully');
  } catch (e) {
    print('❌ Failed to dispose dependencies: $e');
  }
}
