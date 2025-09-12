import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/health_data.dart';
import '../models/ai_response.dart';
import 'api_constants.dart';

part 'api_client.g.dart';

/// Retrofit API Client for DgtlClinicalService Backend
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Health Data Endpoints
  @POST(ApiConstants.submitBPReading)
  Future<ApiResponse<String>> submitBPReading(
    @Body() BPReadingRequest request,
  );

  @GET('${ApiConstants.getBPHistory}/{userId}')
  Future<ApiResponse<List<BPReading>>> getBPHistory(
    @Path('userId') String userId,
    @Query('days') int? days,
  );

  @POST(ApiConstants.submitSymptoms)
  Future<ApiResponse<String>> submitSymptoms(
    @Body() SymptomsRequest request,
  );

  @GET('${ApiConstants.getVitals}/{userId}')
  Future<ApiResponse<VitalsData>> getVitals(
    @Path('userId') String userId,
  );

  // AI Endpoints
  @POST(ApiConstants.getHealthRecommendations)
  Future<AIRecommendationsResponse> getHealthRecommendations(
    @Body() HealthDataRequest request,
  );

  @POST(ApiConstants.chatWithAI)
  Future<AIChatResponse> chatWithAI(
    @Body() AIChatRequest request,
  );

  @POST(ApiConstants.getMedicationAdvice)
  Future<MedicationAdviceResponse> getMedicationAdvice(
    @Body() MedicationRequest request,
  );

  // User Profile Endpoints
  @GET('${ApiConstants.userProfile}/{userId}')
  Future<ApiResponse<UserProfile>> getUserProfile(
    @Path('userId') String userId,
  );

  @PUT('${ApiConstants.userProfile}/{userId}')
  Future<ApiResponse<String>> updateUserProfile(
    @Path('userId') String userId,
    @Body() UserProfileUpdateRequest request,
  );
}

/// Generic API Response wrapper
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;
  final int? errorCode;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
    this.errorCode,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      error: json['error'],
      errorCode: json['errorCode'],
    );
  }
}
