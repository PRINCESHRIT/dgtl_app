// DGTL Healthcare - App Integration Layer
// Connects all production components with existing Flutter app

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/database/vitals_tables.dart';
import 'core/repositories/vitals_repository.dart';
import 'core/providers/app_providers.dart';
import 'core/services/sync_service.dart';
import 'core/services/websocket_service.dart';
import 'healthcare_dashboard_main.dart';

class DgtlHealthcareApp extends ConsumerStatefulWidget {
  const DgtlHealthcareApp({super.key});

  @override
  ConsumerState<DgtlHealthcareApp> createState() => _DgtlHealthcareAppState();
}

class _DgtlHealthcareAppState extends ConsumerState<DgtlHealthcareApp>
    with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  Future<void> _initializeApp() async {
    // Initialize database
    final database = ref.read(databaseProvider);
    await database.customSelect('SELECT 1').get(); // Ensure database is ready
    
    // Initialize connectivity monitoring
    final connectivityNotifier = ref.read(connectivityProvider.notifier);
    connectivityNotifier.startMonitoring();
    
    // Setup sync service listeners
    _setupSyncListeners();
    
    // Initialize WebSocket if authenticated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeWebSocketIfNeeded();
    });
  }
  
  void _setupSyncListeners() {
    // Listen to connectivity changes
    ref.listen<ConnectivityState>(connectivityProvider, (previous, next) {
      if (previous?.isOnline == false && next.isOnline) {
        // Connectivity restored - trigger sync
        final syncService = ref.read(syncServiceProvider);
        syncService.onConnectivityChanged(true);
      }
    });
    
    // Listen to auth state changes
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (!previous?.isAuthenticated != next.isAuthenticated) {
        if (next.isAuthenticated) {
          _initializeWebSocketIfNeeded();
        } else {
          final wsService = ref.read(webSocketServiceProvider.notifier);
          wsService.disconnect();
        }
      }
    });
  }
  
  void _initializeWebSocketIfNeeded() {
    final authState = ref.read(authStateProvider);
    if (authState.isAuthenticated) {
      final wsService = ref.read(webSocketServiceProvider.notifier);
      wsService.ensureConnected();
    }
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    switch (state) {
      case AppLifecycleState.resumed:
        // App resumed - ensure connections are active
        _initializeWebSocketIfNeeded();
        
        final syncService = ref.read(syncServiceProvider);
        syncService.forceSyncNow();
        break;
        
      case AppLifecycleState.paused:
        // App paused - can keep WebSocket for background updates
        break;
        
      case AppLifecycleState.detached:
        // App being terminated - cleanup
        final wsService = ref.read(webSocketServiceProvider.notifier);
        wsService.disconnect();
        break;
        
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        // Transient states - no action needed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DGTL Healthcare',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const AppShell(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final connectivityState = ref.watch(connectivityProvider);
    final syncStatus = ref.watch(syncStatusProvider);
    final wsState = ref.watch(webSocketServiceProvider);
    
    return Scaffold(
      body: Column(
        children: [
          // Connection status bar
          _buildStatusBar(
            context,
            connectivityState: connectivityState,
            syncStatus: syncStatus,
            wsState: wsState,
          ),
          
          // Main content
          Expanded(
            child: authState.isAuthenticated
                ? SimpleHealthDashboard()
                : const AuthenticationScreen(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatusBar(
    BuildContext context, {
    required ConnectivityState connectivityState,
    required SyncStatus syncStatus,
    required WebSocketState wsState,
  }) {
    final theme = Theme.of(context);
    
    // Determine overall status
    Color statusColor;
    IconData statusIcon;
    String statusText;
    
    if (!connectivityState.isOnline) {
      statusColor = theme.colorScheme.error;
      statusIcon = Icons.cloud_off;
      statusText = 'ऑफ़लाइन मोड'; // Offline mode
    } else if (syncStatus.isSyncing) {
      statusColor = theme.colorScheme.secondary;
      statusIcon = Icons.sync;
      statusText = 'सिंक हो रहा है...'; // Syncing...
    } else if (syncStatus.hasErrors) {
      statusColor = theme.colorScheme.error;
      statusIcon = Icons.sync_problem;
      statusText = 'सिंक समस्या'; // Sync problem
    } else if (wsState.isConnected) {
      statusColor = theme.colorScheme.primary;
      statusIcon = Icons.cloud_done;
      statusText = 'लाइव कनेक्शन'; // Live connection
    } else {
      statusColor = theme.colorScheme.outline;
      statusIcon = Icons.cloud_queue;
      statusText = 'कनेक्ट हो रहा है...'; // Connecting...
    }
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: statusColor.withOpacity(0.1),
      child: Row(
        children: [
          Icon(
            statusIcon,
            size: 16,
            color: statusColor,
          ),
          const SizedBox(width: 8),
          Text(
            statusText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          if (syncStatus.pendingOperations > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${syncStatus.pendingOperations}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      final authNotifier = ref.read(authStateProvider.notifier);
      await authNotifier.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('लॉगिन त्रुटि: $e'), // Login error
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.health_and_safety,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'DGTL Healthcare',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'डिजिटल स्वास्थ्य समाधान', // Digital health solution
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 48),
                
                // Email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'ईमेल', // Email
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'कृपया ईमेल दर्ज करें'; // Please enter email
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'वैध ईमेल दर्ज करें'; // Enter valid email
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'पासवर्ड', // Password
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'कृपया पासवर्ड दर्ज करें'; // Please enter password
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                
                // Sign in button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('साइन इन करें'), // Sign in
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Enhanced app initialization with error handling
class AppInitializer {
  static Future<void> initialize() async {
    try {
      // Initialize database
      await DatabaseService.initialize();
      
      // Initialize connectivity monitoring
      await Connectivity().checkConnectivity();
      
      // Pre-cache critical data
      await _precacheEssentialData();
      
    } catch (e) {
      // Log error but don't crash the app
      debugPrint('App initialization error: $e');
    }
  }
  
  static Future<void> _precacheEssentialData() async {
    // Pre-load essential reference data that might be needed offline
    // This could include medical reference ranges, medication lists, etc.
  }
}

// Global error handler for the app
class GlobalErrorHandler {
  static void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      _logError(details.exception, details.stack, 'Flutter Error');
    };
  }
  
  static void _logError(dynamic error, StackTrace? stackTrace, String context) {
    // In production, this would send to crash analytics
    debugPrint('$context: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }
  
  static void handleAsyncError(dynamic error, StackTrace stackTrace) {
    _logError(error, stackTrace, 'Async Error');
  }
}
