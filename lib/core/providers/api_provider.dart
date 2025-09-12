import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../api/api_client.dart';
import '../api/api_interceptors.dart';
import '../api/api_constants.dart';

part 'api_provider.g.dart';

/// Dio HTTP Client Provider
@riverpod
Dio dio(DioRef ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
    sendTimeout: ApiConstants.sendTimeout,
    headers: ApiConstants.headers,
  ));

  // Add interceptors
  dio.interceptors.addAll([
    LoggingInterceptor(),
    AuthInterceptor(),
    ErrorInterceptor(),
  ]);

  return dio;
}

/// API Client Provider
@riverpod
ApiClient apiClient(ApiClientRef ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
}

/// Auth Token Provider
@riverpod
class AuthToken extends _$AuthToken {
  @override
  String? build() {
    return null; // Initially no token
  }

  void setToken(String token) {
    state = token;
    // Update the auth interceptor
    final dio = ref.read(dioProvider);
    final authInterceptor = dio.interceptors
        .whereType<AuthInterceptor>()
        .first;
    authInterceptor.setAuthToken(token);
  }

  void clearToken() {
    state = null;
    // Clear the auth interceptor
    final dio = ref.read(dioProvider);
    final authInterceptor = dio.interceptors
        .whereType<AuthInterceptor>()
        .first;
    authInterceptor.clearAuthToken();
  }
}

/// Current User ID Provider (temporary hardcoded for development)
@riverpod
String currentUserId(CurrentUserIdRef ref) {
  // TODO: Replace with actual user authentication
  return 'dev_user_001';
}
