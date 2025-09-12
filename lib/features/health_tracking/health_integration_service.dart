import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/api/api_client.dart';
import '../../core/models/health_data.dart';
import '../../core/providers/api_provider.dart';

part 'health_integration_service.g.dart';

/// Simple service to connect frontend with backend
@riverpod
class HealthIntegrationService extends _$HealthIntegrationService {
  late ApiClient _apiClient;

  @override
  Future<void> build() async {
    _apiClient = ref.read(apiClientProvider);
  }

  /// Submit BP reading to backend
  Future<bool> submitBPReading({
    required int systolic,
    required int diastolic,
    required int heartRate,
    String? notes,
  }) async {
    try {
      final request = BPReadingRequest(
        systolic: systolic,
        diastolic: diastolic,
        heartRate: heartRate,
        timestamp: DateTime.now(),
        notes: notes,
        userId: 'current_user', // TODO: Get from auth
      );

      final response = await _apiClient.submitBPReading(request);
      return response.success;
    } catch (e) {
      print('Error submitting BP reading: $e');
      return false;
    }
  }

  /// Get BP history from backend
  Future<List<BPReading>> getBPHistory({int days = 30}) async {
    try {
      final response = await _apiClient.getBPHistory('current_user', days);
      return response.success ? response.data ?? [] : [];
    } catch (e) {
      print('Error getting BP history: $e');
      return [];
    }
  }

  /// Submit symptoms to backend
  Future<bool> submitSymptoms({
    required List<String> symptoms,
    required int severityLevel,
    String? notes,
  }) async {
    try {
      final request = SymptomsRequest(
        symptoms: symptoms,
        severityLevel: severityLevel,
        timestamp: DateTime.now(),
        notes: notes,
        userId: 'current_user',
      );

      final response = await _apiClient.submitSymptoms(request);
      return response.success;
    } catch (e) {
      print('Error submitting symptoms: $e');
      return false;
    }
  }

  /// Get health recommendations
  Future<String?> getHealthRecommendations({
    int? systolic,
    int? diastolic,
    List<String>? symptoms,
  }) async {
    try {
      final request = HealthDataRequest(
        systolic: systolic,
        diastolic: diastolic,
        symptoms: symptoms ?? [],
        timestamp: DateTime.now(),
        userId: 'current_user',
      );

      final response = await _apiClient.getHealthRecommendations(request);
      return response.success ? response.recommendation : null;
    } catch (e) {
      print('Error getting recommendations: $e');
      return null;
    }
  }

  /// Chat with AI
  Future<String?> chatWithAI(String message) async {
    try {
      final request = AIChatRequest(
        message: message,
        userId: 'current_user',
        timestamp: DateTime.now(),
      );

      final response = await _apiClient.chatWithAI(request);
      return response.success ? response.reply : null;
    } catch (e) {
      print('Error chatting with AI: $e');
      return null;
    }
  }
}
