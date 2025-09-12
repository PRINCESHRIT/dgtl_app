/// API Constants for DgtlClinicalService Backend Integration
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'http://localhost:8000/api/v1';
  static const String healthEndpoint = '/health';
  static const String aiEndpoint = '/ai';
  static const String userEndpoint = '/users';
  
  // Health Endpoints
  static const String submitBPReading = '$healthEndpoint/bp-reading';
  static const String getBPHistory = '$healthEndpoint/bp-history';
  static const String submitSymptoms = '$healthEndpoint/symptoms';
  static const String getVitals = '$healthEndpoint/vitals';
  
  // AI Endpoints
  static const String getHealthRecommendations = '$aiEndpoint/recommendations';
  static const String chatWithAI = '$aiEndpoint/chat';
  static const String getMedicationAdvice = '$aiEndpoint/medication-advice';
  
  // User Endpoints
  static const String userProfile = '$userEndpoint/profile';
  static const String userPreferences = '$userEndpoint/preferences';
  
  // Request Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-App-Version': '1.0.0',
    'X-Platform': 'flutter-web',
  };
  
  // Timeout Configuration
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}
