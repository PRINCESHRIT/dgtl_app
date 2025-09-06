import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../constants/app_constants.dart';

/// Secure storage service for managing sensitive data like encryption keys
/// Provides secure key management for database encryption and user data
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: 'dgtl_secure_prefs',
    ),
    iOptions: IOSOptions(
      accountName: AppConstants.appName,
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  bool _initialized = false;
  
  /// Initialize the secure storage service
  Future<void> initialize() async {
    try {
      // Test if we can read/write to secure storage
      await _storage.write(key: 'test_key', value: 'test_value');
      final testValue = await _storage.read(key: 'test_key');
      if (testValue != 'test_value') {
        throw Exception('Secure storage test failed');
      }
      await _storage.delete(key: 'test_key');
      
      // Ensure database key exists
      await _ensureDbKeyExists();
      
      _initialized = true;
      print('✅ SecureStorageService initialized');
    } catch (e) {
      print('❌ SecureStorageService initialization failed: $e');
      rethrow;
    }
  }
  
  /// Get database encryption key (generates if doesn't exist)
  Future<String> getDbKey() async {
    _ensureInitialized();
    
    String? key = await _storage.read(key: AppConstants.dbKeyStorageKey);
    if (key == null) {
      key = await generateAndStoreDbKey();
    }
    return key;
  }
  
  /// Store database encryption key
  Future<void> storeDbKey(String key) async {
    _ensureInitialized();
    await _storage.write(key: AppConstants.dbKeyStorageKey, value: key);
  }
  
  /// Generate and store new database encryption key
  Future<String> generateAndStoreDbKey() async {
    _ensureInitialized();
    
    final key = _generateSecureKey(32);
    await storeDbKey(key);
    return key;
  }
  
  /// Get user passphrase for backup encryption
  Future<String?> getUserPassphrase() async {
    _ensureInitialized();
    return await _storage.read(key: AppConstants.userPassphraseKey);
  }
  
  /// Store user passphrase (hashed)
  Future<void> storeUserPassphrase(String passphrase) async {
    _ensureInitialized();
    
    // Hash the passphrase before storing
    final hashedPassphrase = _hashPassphrase(passphrase);
    await _storage.write(key: AppConstants.userPassphraseKey, value: hashedPassphrase);
  }
  
  /// Verify user passphrase
  Future<bool> verifyUserPassphrase(String passphrase) async {
    final storedHash = await getUserPassphrase();
    if (storedHash == null) return false;
    
    final providedHash = _hashPassphrase(passphrase);
    return storedHash == providedHash;
  }
  
  /// Clear all stored data (for app reset)
  Future<void> clearAll() async {
    _ensureInitialized();
    await _storage.deleteAll();
    _initialized = false;
  }
  
  /// Ensure database key exists
  Future<void> _ensureDbKeyExists() async {
    final key = await _storage.read(key: AppConstants.dbKeyStorageKey);
    if (key == null) {
      await generateAndStoreDbKey();
    }
  }
  
  /// Generate secure random key
  String _generateSecureKey(int length) {
    final random = <int>[];
    for (int i = 0; i < length; i++) {
      random.add(DateTime.now().millisecondsSinceEpoch % 256);
    }
    return base64Encode(Uint8List.fromList(random));
  }
  
  /// Hash passphrase using SHA-256
  String _hashPassphrase(String passphrase) {
    final bytes = utf8.encode(passphrase + AppConstants.appName); // Add salt
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Ensure service is initialized
  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError('SecureStorageService not initialized. Call initialize() first.');
    }
  }
}
