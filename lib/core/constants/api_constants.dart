// DGTL Healthcare - API Constants
// Production API endpoints and configuration

class ApiConstants {
  // Base URLs - Environment specific
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.dgtlhealth.com/v1',
  );
  
  static const String webSocketBaseUrl = String.fromEnvironment(
    'WS_BASE_URL',
    defaultValue: 'wss://api.dgtlhealth.com',
  );
  
  // Staging URLs for development
  static const String stagingBaseUrl = 'https://staging-api.dgtlhealth.com/v1';
  static const String stagingWebSocketUrl = 'wss://staging-api.dgtlhealth.com';
  
  // Local development URLs
  static const String localBaseUrl = 'http://localhost:3000/v1';
  static const String localWebSocketUrl = 'ws://localhost:3000';
  
  // Authentication endpoints
  static const String authEndpoint = '/auth';
  static const String tokenEndpoint = '/auth/token';
  static const String refreshEndpoint = '/auth/refresh';
  static const String logoutEndpoint = '/auth/logout';
  
  // Medical data endpoints
  static const String vitalsEndpoint = '/vitals';
  static const String bpReadingsEndpoint = '/bp-readings';
  static const String patientsEndpoint = '/patients';
  static const String clinicalAssessmentsEndpoint = '/clinical-assessments';
  
  // AI & Recommendations
  static const String aiRecommendationsEndpoint = '/ai-recommendations';
  static const String medicalAnalysisEndpoint = '/medical-analysis';
  
  // Sync & Batch operations
  static const String syncEndpoint = '/sync';
  static const String batchEndpoint = '/batch';
  static const String conflictResolutionEndpoint = '/sync/conflicts';
  
  // Real-time WebSocket channels
  static const String vitalsChannel = 'vitals';
  static const String bpReadingsChannel = 'bp_readings';
  static const String aiRecommendationsChannel = 'ai_recommendations';
  static const String syncNotificationsChannel = 'sync_notifications';
  
  // Request timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration uploadTimeout = Duration(minutes: 2);
  static const Duration downloadTimeout = Duration(minutes: 5);
  
  // Pagination defaults
  static const int defaultPageSize = 50;
  static const int maxPageSize = 100;
  
  // Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);
  
  // Headers
  static const String contentTypeHeader = 'Content-Type';
  static const String authorizationHeader = 'Authorization';
  static const String apiVersionHeader = 'X-API-Version';
  static const String clientIdHeader = 'X-Client-ID';
  static const String deviceIdHeader = 'X-Device-ID';
  static const String localeHeader = 'Accept-Language';
  
  // Content types
  static const String jsonContentType = 'application/json';
  static const String formContentType = 'application/x-www-form-urlencoded';
  
  // API version
  static const String apiVersion = '1.0';
  
  // Environment detection
  static bool get isProduction => 
      baseUrl.contains('api.dgtlhealth.com') && !baseUrl.contains('staging');
  
  static bool get isStaging => baseUrl.contains('staging');
  
  static bool get isDevelopment => 
      baseUrl.contains('localhost') || baseUrl.contains('127.0.0.1');
  
  // Medical data validation constants
  static const double minSystolicBP = 50.0;
  static const double maxSystolicBP = 300.0;
  static const double minDiastolicBP = 30.0;
  static const double maxDiastolicBP = 200.0;
  
  static const double minHeartRate = 30.0;
  static const double maxHeartRate = 250.0;
  
  // CKD biomarker ranges (for validation)
  static const double minCreatinine = 0.1;
  static const double maxCreatinine = 20.0;
  
  static const double minEGFR = 0.0;
  static const double maxEGFR = 150.0;
  
  static const double minHbA1c = 3.0;
  static const double maxHbA1c = 20.0;
  
  // Error codes
  static const String unauthorizedError = 'UNAUTHORIZED';
  static const String forbiddenError = 'FORBIDDEN';
  static const String notFoundError = 'NOT_FOUND';
  static const String validationError = 'VALIDATION_ERROR';
  static const String serverError = 'INTERNAL_SERVER_ERROR';
  static const String networkError = 'NETWORK_ERROR';
  static const String timeoutError = 'TIMEOUT_ERROR';
  static const String conflictError = 'CONFLICT';
  
  // Cache keys
  static const String userProfileCacheKey = 'user_profile';
  static const String vitalsMetadataCacheKey = 'vitals_metadata';
  static const String medicationsListCacheKey = 'medications_list';
  static const String referenceDataCacheKey = 'reference_data';
  
  // Feature flags (for gradual rollout)
  static const bool enableRealTimeSync = true;
  static const bool enableWebSocketUpdates = true;
  static const bool enableOfflineMode = true;
  static const bool enableAIRecommendations = true;
  static const bool enableBatchOperations = true;
  
  // Localization
  static const String defaultLocale = 'hi-IN'; // Hindi (India)
  static const String fallbackLocale = 'en-US';
  
  // Medical reference data
  static const Map<String, String> medicalUnits = {
    'blood_pressure': 'mmHg',
    'heart_rate': 'bpm',
    'weight': 'kg',
    'height': 'cm',
    'temperature': '°C',
    'glucose': 'mg/dL',
    'creatinine': 'mg/dL',
    'egfr': 'mL/min/1.73m²',
    'hba1c': '%',
    'albumin': 'g/dL',
    'hemoglobin': 'g/dL',
  };
  
  // Hindi medical terminology mapping
  static const Map<String, String> medicalTermsHindi = {
    'blood_pressure': 'रक्तचाप',
    'systolic': 'सिस्टोलिक',
    'diastolic': 'डायास्टोलिक',
    'heart_rate': 'हृदय गति',
    'weight': 'वजन',
    'height': 'ऊंचाई',
    'temperature': 'तापमान',
    'glucose': 'रक्त शर्करा',
    'creatinine': 'क्रिएटिनिन',
    'egfr': 'ई-जी-एफ-आर',
    'hba1c': 'एचबीए1सी',
    'normal': 'सामान्य',
    'high': 'उच्च',
    'low': 'कम',
    'critical': 'गंभीर',
  };
}

// HTTP Status codes for reference
class HttpStatusCodes {
  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int noContent = 204;
  
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int tooManyRequests = 429;
  
  static const int internalServerError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
}

// WebSocket status codes
class WebSocketStatusCodes {
  static const int normalClosure = 1000;
  static const int goingAway = 1001;
  static const int protocolError = 1002;
  static const int unsupportedData = 1003;
  static const int policyViolation = 1008;
  static const int messageTooBig = 1009;
  static const int internalError = 1011;
}
