import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_constants.dart';

/// API Interceptors for request/response handling, authentication, and logging
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('🚀 REQUEST[${options.method}] => PATH: ${options.path}');
      print('Headers: ${options.headers}');
      if (options.data != null) {
        print('Body: ${options.data}');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      print('Data: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      print('Error: ${err.message}');
      if (err.response?.data != null) {
        print('Error Data: ${err.response?.data}');
      }
    }
    super.onError(err, handler);
  }
}

class AuthInterceptor extends Interceptor {
  String? _authToken;
  
  void setAuthToken(String token) {
    _authToken = token;
  }
  
  void clearAuthToken() {
    _authToken = null;
  }
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_authToken != null) {
      options.headers['Authorization'] = 'Bearer $_authToken';
    }
    super.onRequest(options, handler);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle common HTTP errors
    switch (err.response?.statusCode) {
      case 400:
        err = DioException(
          requestOptions: err.requestOptions,
          message: 'गलत डेटा भेजा गया। कृपया जांच करें।',
          type: DioExceptionType.badResponse,
          response: err.response,
        );
        break;
      case 401:
        err = DioException(
          requestOptions: err.requestOptions,
          message: 'कृपया फिर से लॉगिन करें।',
          type: DioExceptionType.badResponse,
          response: err.response,
        );
        break;
      case 404:
        err = DioException(
          requestOptions: err.requestOptions,
          message: 'सेवा उपलब्ध नहीं है।',
          type: DioExceptionType.badResponse,
          response: err.response,
        );
        break;
      case 500:
        err = DioException(
          requestOptions: err.requestOptions,
          message: 'सर्वर में समस्या है। कुछ समय बाद प्रयास करें।',
          type: DioExceptionType.badResponse,
          response: err.response,
        );
        break;
      default:
        if (err.type == DioExceptionType.connectionTimeout ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.sendTimeout) {
          err = DioException(
            requestOptions: err.requestOptions,
            message: 'नेटवर्क की समस्या। कृपया अपना कनेक्शन जांचें।',
            type: err.type,
            response: err.response,
          );
        }
    }
    
    super.onError(err, handler);
  }
}
