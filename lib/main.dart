import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/di.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'core/constants/app_constants.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure system UI
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize dependencies
  try {
    await setupDependencies();
    print('✅ DGTL app initialized successfully');
  } catch (e) {
    print('❌ Failed to initialize DGTL app: $e');
    // You might want to show an error screen here in production
  }
  
  runApp(const DGTLApp());
}

class DGTLApp extends StatelessWidget {
  const DGTLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.dashboard,
      builder: (context, child) {
        return Scaffold(
          body: child,
          // Optional: Add a global error boundary here
        );
      },
    );
  }
}
