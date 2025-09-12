// lib/polish_demo_di.dart
import 'package:get_it/get_it.dart';
import 'core/database/database.dart';

final GetIt getIt = GetIt.instance;

/// Initialize lightweight dependencies for the polish_demo UI viewer.
/// This avoids pulling in the full native-only backend (AI, encrypted DB).
Future<void> setupDemoDependencies() async {
  // Unregister if already registered from a previous hot restart with a different setup
  if (getIt.isRegistered<AppDatabase>()) {
    await getIt.reset(dispose: false);
  }
  
  // Register only the web-safe AppDatabase
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  
  // The database will be initialized on first access.
  print('✅ DGTL Polish Demo dependencies initialized successfully');
}
