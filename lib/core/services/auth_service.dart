// DGTL Healthcare - Authentication Service
// Secure token management with automatic refresh and biometric support

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class AuthenticationService {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  // Storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userProfileKey = 'user_profile';
  static const String _tokenExpiryKey = 'token_expiry';
  
  Timer? _tokenRefreshTimer;
  
  // Authentication state
  bool _isAuthenticated = false;
  String? _currentUserId;
  Map<String, dynamic>? _userProfile;
  
  bool get isAuthenticated => _isAuthenticated;
  String? get currentUserId => _currentUserId;
  Map<String, dynamic>? get userProfile => _userProfile;
  
  Future<void> initialize() async {
    await _loadStoredAuth();
    if (_isAuthenticated) {
      _scheduleTokenRefresh();
    }
  }
  
  Future<AuthResult> signIn({
    required String email,
    required String password,
    String? deviceId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.authEndpoint}/signin'),
        headers: {
          ApiConstants.contentTypeHeader: ApiConstants.jsonContentType,
          ApiConstants.apiVersionHeader: ApiConstants.apiVersion,
          if (deviceId != null) ApiConstants.deviceIdHeader: deviceId,
          ApiConstants.localeHeader: ApiConstants.defaultLocale,
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_info': {
            'platform': 'flutter',
            'app_version': '1.0.0',
          },
        }),
      ).timeout(ApiConstants.defaultTimeout);
      
      if (response.statusCode == HttpStatusCodes.ok) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        await _storeAuthData(data);
        return AuthResult.success(data['user']);
      } else {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        return AuthResult.failure(
          errorData['message'] ?? 'Authentication failed',
          errorData['code'] ?? ApiConstants.unauthorizedError,
        );
      }
    } catch (e) {
      return AuthResult.failure(
        'Network error: $e',
        ApiConstants.networkError,
      );
    }
  }
  
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    Map<String, dynamic>? medicalProfile,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.authEndpoint}/signup'),
        headers: {
          ApiConstants.contentTypeHeader: ApiConstants.jsonContentType,
          ApiConstants.apiVersionHeader: ApiConstants.apiVersion,
          ApiConstants.localeHeader: ApiConstants.defaultLocale,
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'medicalProfile': medicalProfile,
          'preferences': {
            'language': 'hi-IN',
            'notifications': true,
          },
        }),
      ).timeout(ApiConstants.defaultTimeout);
      
      if (response.statusCode == HttpStatusCodes.created) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        await _storeAuthData(data);
        return AuthResult.success(data['user']);
      } else {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        return AuthResult.failure(
          errorData['message'] ?? 'Sign up failed',
          errorData['code'] ?? ApiConstants.validationError,
        );
      }
    } catch (e) {
      return AuthResult.failure(
        'Network error: $e',
        ApiConstants.networkError,
      );
    }
  }
  
  Future<String?> getValidAccessToken() async {
    final token = await _secureStorage.read(key: _accessTokenKey);
    if (token == null) return null;
    
    // Check if token is expired
    if (await _isTokenExpired()) {
      final refreshResult = await _refreshToken();
      if (refreshResult.isSuccess) {
        return await _secureStorage.read(key: _accessTokenKey);
      } else {
        // Refresh failed - user needs to sign in again
        await signOut();
        return null;
      }
    }
    
    return token;
  }
  
  Future<AuthResult> _refreshToken() async {
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    if (refreshToken == null) {
      return AuthResult.failure('No refresh token', ApiConstants.unauthorizedError);
    }
    
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.refreshEndpoint}'),
        headers: {
          ApiConstants.contentTypeHeader: ApiConstants.jsonContentType,
          ApiConstants.apiVersionHeader: ApiConstants.apiVersion,
          ApiConstants.authorizationHeader: 'Bearer $refreshToken',
        },
      ).timeout(ApiConstants.defaultTimeout);
      
      if (response.statusCode == HttpStatusCodes.ok) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        await _storeAuthData(data);
        return AuthResult.success(data['user']);
      } else {
        return AuthResult.failure(
          'Token refresh failed',
          ApiConstants.unauthorizedError,
        );
      }
    } catch (e) {
      return AuthResult.failure(
        'Token refresh error: $e',
        ApiConstants.networkError,
      );
    }
  }
  
  Future<void> signOut() async {
    try {
      final token = await _secureStorage.read(key: _accessTokenKey);
      if (token != null) {
        // Notify server of logout
        http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.logoutEndpoint}'),
          headers: {
            ApiConstants.authorizationHeader: 'Bearer $token',
            ApiConstants.apiVersionHeader: ApiConstants.apiVersion,
          },
        ).timeout(ApiConstants.defaultTimeout);
      }
    } catch (e) {
      // Ignore errors during logout - we'll clear local data anyway
    }
    
    await _clearAuthData();
  }
  
  Future<void> _storeAuthData(Map<String, dynamic> authData) async {
    final accessToken = authData['access_token'] as String;
    final refreshToken = authData['refresh_token'] as String;
    final user = authData['user'] as Map<String, dynamic>;
    final expiresIn = authData['expires_in'] as int; // seconds
    
    final expiryTime = DateTime.now()
        .add(Duration(seconds: expiresIn))
        .millisecondsSinceEpoch;
    
    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: accessToken),
      _secureStorage.write(key: _refreshTokenKey, value: refreshToken),
      _secureStorage.write(key: _userIdKey, value: user['id']),
      _secureStorage.write(key: _userProfileKey, value: jsonEncode(user)),
      _secureStorage.write(key: _tokenExpiryKey, value: expiryTime.toString()),
    ]);
    
    _isAuthenticated = true;
    _currentUserId = user['id'];
    _userProfile = user;
    
    _scheduleTokenRefresh();
  }
  
  Future<void> _loadStoredAuth() async {
    try {
      final results = await Future.wait([
        _secureStorage.read(key: _accessTokenKey),
        _secureStorage.read(key: _userIdKey),
        _secureStorage.read(key: _userProfileKey),
      ]);
      
      final accessToken = results[0];
      final userId = results[1];
      final userProfileJson = results[2];
      
      if (accessToken != null && userId != null && userProfileJson != null) {
        _isAuthenticated = true;
        _currentUserId = userId;
        _userProfile = jsonDecode(userProfileJson);
      }
    } catch (e) {
      // Clear corrupted data
      await _clearAuthData();
    }
  }
  
  Future<void> _clearAuthData() async {
    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
      _secureStorage.delete(key: _userIdKey),
      _secureStorage.delete(key: _userProfileKey),
      _secureStorage.delete(key: _tokenExpiryKey),
    ]);
    
    _tokenRefreshTimer?.cancel();
    _tokenRefreshTimer = null;
    
    _isAuthenticated = false;
    _currentUserId = null;
    _userProfile = null;
  }
  
  Future<bool> _isTokenExpired() async {
    final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryString == null) return true;
    
    final expiryTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(expiryString),
    );
    
    // Consider token expired if it expires within 5 minutes
    return DateTime.now().add(const Duration(minutes: 5)).isAfter(expiryTime);
  }
  
  void _scheduleTokenRefresh() {
    _tokenRefreshTimer?.cancel();
    
    _secureStorage.read(key: _tokenExpiryKey).then((expiryString) {
      if (expiryString == null) return;
      
      final expiryTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(expiryString),
      );
      
      // Schedule refresh 10 minutes before expiry
      final refreshTime = expiryTime.subtract(const Duration(minutes: 10));
      final delay = refreshTime.difference(DateTime.now());
      
      if (delay.isNegative) {
        // Token is already close to expiry, refresh now
        _refreshToken();
      } else {
        _tokenRefreshTimer = Timer(delay, () {
          _refreshToken();
        });
      }
    });
  }
  
  // Biometric authentication support
  Future<bool> isBiometricAvailable() async {
    try {
      return await _secureStorage.containsKey(key: 'biometric_enabled') &&
          await _secureStorage.read(key: 'biometric_enabled') == 'true';
    } catch (e) {
      return false;
    }
  }
  
  Future<void> enableBiometric() async {
    await _secureStorage.write(key: 'biometric_enabled', value: 'true');
  }
  
  Future<void> disableBiometric() async {
    await _secureStorage.delete(key: 'biometric_enabled');
  }
  
  Future<AuthResult> authenticateWithBiometric() async {
    if (!await isBiometricAvailable()) {
      return AuthResult.failure(
        'Biometric not available',
        'BIOMETRIC_NOT_AVAILABLE',
      );
    }
    
    // This would integrate with local_auth package for actual biometric
    // For now, just validate existing stored credentials
    if (_isAuthenticated) {
      return AuthResult.success(_userProfile!);
    } else {
      return AuthResult.failure(
        'Not authenticated',
        ApiConstants.unauthorizedError,
      );
    }
  }
  
  void dispose() {
    _tokenRefreshTimer?.cancel();
  }
}

class AuthResult {
  final bool isSuccess;
  final String? errorMessage;
  final String? errorCode;
  final Map<String, dynamic>? userData;
  
  AuthResult._({
    required this.isSuccess,
    this.errorMessage,
    this.errorCode,
    this.userData,
  });
  
  factory AuthResult.success(Map<String, dynamic> userData) => AuthResult._(
        isSuccess: true,
        userData: userData,
      );
  
  factory AuthResult.failure(String message, String code) => AuthResult._(
        isSuccess: false,
        errorMessage: message,
        errorCode: code,
      );
}

// Auth state for providers
class AuthState {
  final bool isAuthenticated;
  final String? userId;
  final Map<String, dynamic>? userProfile;
  final String? token;
  final DateTime? lastRefresh;
  
  const AuthState({
    required this.isAuthenticated,
    this.userId,
    this.userProfile,
    this.token,
    this.lastRefresh,
  });
  
  factory AuthState.unauthenticated() => const AuthState(
        isAuthenticated: false,
      );
  
  factory AuthState.authenticated({
    required String userId,
    required Map<String, dynamic> userProfile,
    required String token,
    DateTime? lastRefresh,
  }) =>
      AuthState(
        isAuthenticated: true,
        userId: userId,
        userProfile: userProfile,
        token: token,
        lastRefresh: lastRefresh ?? DateTime.now(),
      );
  
  AuthState copyWith({
    bool? isAuthenticated,
    String? userId,
    Map<String, dynamic>? userProfile,
    String? token,
    DateTime? lastRefresh,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userId: userId ?? this.userId,
      userProfile: userProfile ?? this.userProfile,
      token: token ?? this.token,
      lastRefresh: lastRefresh ?? this.lastRefresh,
    );
  }
  
  String? get displayName {
    if (userProfile == null) return null;
    final firstName = userProfile!['firstName'] as String?;
    final lastName = userProfile!['lastName'] as String?;
    
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return firstName ?? lastName ?? userProfile!['email'];
  }
  
  bool get needsProfileCompletion {
    if (userProfile == null) return true;
    
    return userProfile!['firstName'] == null ||
        userProfile!['lastName'] == null ||
        userProfile!['medicalProfile'] == null;
  }
}
