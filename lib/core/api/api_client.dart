// DGTL Healthcare - API Client
// RESTful API client using Retrofit for backend communication

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/auth_models.dart';
import '../models/health_data.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Authentication endpoints
  @POST('/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/auth/register') 
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @POST('/auth/refresh')
  Future<AuthResponse> refreshToken(@Body() RefreshTokenRequest request);

  @POST('/auth/logout')
  Future<void> logout();

  // Health data endpoints
  @POST('/health/vitals')
  Future<Map<String, dynamic>> submitVitals(@Body() Map<String, dynamic> request);

  @GET('/health/vitals/{userId}')
  Future<List<Map<String, dynamic>>> getVitals(@Path('userId') String userId);

  @POST('/health/bp-reading')
  Future<Map<String, dynamic>> submitBPReading(@Body() Map<String, dynamic> request);

  @GET('/health/bp-history/{userId}')
  Future<List<Map<String, dynamic>>> getBPHistory(@Path('userId') String userId);

  // User profile endpoints
  @GET('/user/profile/{userId}')
  Future<User> getUserProfile(@Path('userId') String userId);

  @PUT('/user/profile/{userId}')
  Future<User> updateUserProfile(@Path('userId') String userId, @Body() Map<String, dynamic> request);
}
