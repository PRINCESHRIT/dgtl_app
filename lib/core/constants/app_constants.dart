class AppConstants {
  static const String appName = 'DGTL';
  static const String appVersion = '1.0.0';
  static const String dbName = 'dgtl.db';
  static const int dbVersion = 1;
  
  // App Configuration
  static const bool isDevelopmentMode = bool.fromEnvironment('DEVELOPMENT', defaultValue: false);
  static const bool isDebugMode = bool.fromEnvironment('DEBUG', defaultValue: false);
  
  // Security Constants
  static const String secureStorageKeyPrefix = 'dgtl_';
  static const String dbKeyStorageKey = '${secureStorageKeyPrefix}db_key';
  static const String userPassphraseKey = '${secureStorageKeyPrefix}user_passphrase';
  
  // Performance Constants
  static const int maxCacheSize = 1000;
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const int defaultBatchSize = 10;
}
