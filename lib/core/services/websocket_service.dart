// DGTL Healthcare - Production WebSocket Service
// Real-time updates for medical data with automatic reconnection

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constants/api_constants.dart';
import '../providers/app_providers.dart';

class WebSocketService extends StateNotifier<WebSocketState> {
  final Ref _ref;
  
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  static const Duration _baseReconnectDelay = Duration(seconds: 2);
  static const Duration _heartbeatInterval = Duration(seconds: 30);
  
  WebSocketService(this._ref) : super(WebSocketState.disconnected()) {
    _initializeConnection();
  }
  
  void _initializeConnection() {
    final authState = _ref.read(authStateProvider);
    if (authState.isAuthenticated) {
      connect();
    }
  }
  
  Future<void> connect() async {
    if (state.status == WebSocketStatus.connecting) return;
    
    state = WebSocketState.connecting();
    
    try {
      final authState = _ref.read(authStateProvider);
      if (!authState.isAuthenticated) {
        throw Exception('Not authenticated');
      }
      
      final wsUrl = '${ApiConstants.webSocketBaseUrl}/ws';
      final uri = Uri.parse(wsUrl).replace(queryParameters: {
        'token': authState.accessToken,
        'client_id': _generateClientId(),
      });
      
      _channel = WebSocketChannel.connect(uri);
      
      // Setup message listener
      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnection,
        cancelOnError: false,
      );
      
      // Send initial connection message
      _sendMessage({
        'type': 'connection',
        'timestamp': DateTime.now().toIso8601String(),
        'client_info': {
          'platform': defaultTargetPlatform.name,
          'app_version': '1.0.0', // Should come from package_info
        },
      });
      
      _startHeartbeat();
      _reconnectAttempts = 0;
      
      state = WebSocketState.connected(DateTime.now());
      
    } catch (e) {
      debugPrint('WebSocket connection failed: $e');
      state = WebSocketState.error('Connection failed: $e');
      _scheduleReconnect();
    }
  }
  
  void _handleMessage(dynamic rawMessage) {
    try {
      final message = json.decode(rawMessage.toString()) as Map<String, dynamic>;
      final messageType = message['type'] as String?;
      
      switch (messageType) {
        case 'pong':
          // Heartbeat response - connection is alive
          break;
          
        case 'vitals_update':
          _handleVitalsUpdate(message);
          break;
          
        case 'bp_reading_update':
          _handleBPUpdate(message);
          break;
          
        case 'ai_recommendation':
          _handleAIRecommendation(message);
          break;
          
        case 'sync_notification':
          _handleSyncNotification(message);
          break;
          
        case 'error':
          _handleServerError(message);
          break;
          
        case 'connection_ack':
          debugPrint('WebSocket connection acknowledged');
          break;
          
        default:
          debugPrint('Unknown WebSocket message type: $messageType');
      }
      
      state = state.copyWith(lastMessage: DateTime.now());
      
    } catch (e) {
      debugPrint('Error handling WebSocket message: $e');
    }
  }
  
  void _handleVitalsUpdate(Map<String, dynamic> message) {
    final vitalsData = message['data'] as Map<String, dynamic>?;
    if (vitalsData != null) {
      // Trigger repository to handle the update
      final repository = _ref.read(vitalsRepositoryProvider);
      repository.handleRealtimeVitalsUpdate(vitalsData);
    }
  }
  
  void _handleBPUpdate(Map<String, dynamic> message) {
    final bpData = message['data'] as Map<String, dynamic>?;
    if (bpData != null) {
      final repository = _ref.read(vitalsRepositoryProvider);
      repository.handleRealtimeBPUpdate(bpData);
    }
  }
  
  void _handleAIRecommendation(Map<String, dynamic> message) {
    final recommendation = message['data'] as Map<String, dynamic>?;
    if (recommendation != null) {
      // Add to AI recommendations stream
      final aiService = _ref.read(aiServiceProvider);
      aiService.addRealtimeRecommendation(recommendation);
    }
  }
  
  void _handleSyncNotification(Map<String, dynamic> message) {
    final syncData = message['data'] as Map<String, dynamic>?;
    if (syncData != null) {
      // Trigger sync service if needed
      final syncService = _ref.read(syncServiceProvider);
      
      if (syncData['requires_sync'] == true) {
        syncService.forceSyncNow();
      }
    }
  }
  
  void _handleServerError(Map<String, dynamic> message) {
    final error = message['error'] as String? ?? 'Unknown server error';
    debugPrint('WebSocket server error: $error');
    
    if (message['fatal'] == true) {
      disconnect();
      state = WebSocketState.error('Server error: $error');
    }
  }
  
  void _handleError(dynamic error) {
    debugPrint('WebSocket error: $error');
    state = WebSocketState.error('Connection error: $error');
    _scheduleReconnect();
  }
  
  void _handleDisconnection() {
    debugPrint('WebSocket disconnected');
    _stopHeartbeat();
    
    if (state.status != WebSocketStatus.error) {
      state = WebSocketState.disconnected();
    }
    
    _scheduleReconnect();
  }
  
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) {
      if (_channel != null && state.status == WebSocketStatus.connected) {
        _sendMessage({
          'type': 'ping',
          'timestamp': DateTime.now().toIso8601String(),
        });
      }
    });
  }
  
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }
  
  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint('Max reconnect attempts reached');
      state = WebSocketState.error('Max reconnection attempts exceeded');
      return;
    }
    
    _reconnectTimer?.cancel();
    
    final delay = Duration(
      seconds: min(
        _baseReconnectDelay.inSeconds * pow(2, _reconnectAttempts).toInt(),
        60, // Max 1 minute delay
      ),
    );
    
    _reconnectAttempts++;
    
    debugPrint('Scheduling WebSocket reconnect in ${delay.inSeconds}s (attempt $_reconnectAttempts)');
    
    _reconnectTimer = Timer(delay, () {
      if (state.status != WebSocketStatus.connected) {
        connect();
      }
    });
  }
  
  void _sendMessage(Map<String, dynamic> message) {
    if (_channel != null && state.status == WebSocketStatus.connected) {
      try {
        _channel!.sink.add(json.encode(message));
      } catch (e) {
        debugPrint('Error sending WebSocket message: $e');
      }
    }
  }
  
  // Public methods
  void ensureConnected() {
    if (state.status != WebSocketStatus.connected && 
        state.status != WebSocketStatus.connecting) {
      connect();
    }
  }
  
  void disconnect() {
    _reconnectTimer?.cancel();
    _stopHeartbeat();
    
    _channel?.sink.close();
    _channel = null;
    
    state = WebSocketState.disconnected();
  }
  
  void sendVitalsSubscription(String patientId) {
    _sendMessage({
      'type': 'subscribe',
      'channel': 'vitals',
      'patient_id': patientId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
  
  void sendBPSubscription(String patientId) {
    _sendMessage({
      'type': 'subscribe',
      'channel': 'bp_readings',
      'patient_id': patientId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
  
  void sendAISubscription(String patientId) {
    _sendMessage({
      'type': 'subscribe',
      'channel': 'ai_recommendations',
      'patient_id': patientId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
  
  void unsubscribeFromPatient(String patientId) {
    _sendMessage({
      'type': 'unsubscribe',
      'patient_id': patientId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
  
  String _generateClientId() {
    final random = Random();
    final bytes = List<int>.generate(16, (i) => random.nextInt(256));
    return base64Encode(bytes);
  }
  
  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}

// WebSocket State Management
enum WebSocketStatus {
  disconnected,
  connecting,
  connected,
  error,
}

class WebSocketState {
  final WebSocketStatus status;
  final DateTime? connectedAt;
  final DateTime? lastMessage;
  final String? error;
  
  const WebSocketState._({
    required this.status,
    this.connectedAt,
    this.lastMessage,
    this.error,
  });
  
  factory WebSocketState.disconnected() => const WebSocketState._(
        status: WebSocketStatus.disconnected,
      );
  
  factory WebSocketState.connecting() => const WebSocketState._(
        status: WebSocketStatus.connecting,
      );
  
  factory WebSocketState.connected(DateTime connectedAt) => WebSocketState._(
        status: WebSocketStatus.connected,
        connectedAt: connectedAt,
      );
  
  factory WebSocketState.error(String error) => WebSocketState._(
        status: WebSocketStatus.error,
        error: error,
      );
  
  WebSocketState copyWith({
    WebSocketStatus? status,
    DateTime? connectedAt,
    DateTime? lastMessage,
    String? error,
  }) {
    return WebSocketState._(
      status: status ?? this.status,
      connectedAt: connectedAt ?? this.connectedAt,
      lastMessage: lastMessage ?? this.lastMessage,
      error: error ?? this.error,
    );
  }
  
  bool get isConnected => status == WebSocketStatus.connected;
  bool get isConnecting => status == WebSocketStatus.connecting;
  bool get hasError => status == WebSocketStatus.error;
  
  Duration get connectionDuration {
    if (connectedAt == null) return Duration.zero;
    return DateTime.now().difference(connectedAt!);
  }
  
  Duration get timeSinceLastMessage {
    if (lastMessage == null) return Duration.zero;
    return DateTime.now().difference(lastMessage!);
  }
}

// WebSocket message types for type safety
class WebSocketMessage {
  static Map<String, dynamic> ping() => {
        'type': 'ping',
        'timestamp': DateTime.now().toIso8601String(),
      };
  
  static Map<String, dynamic> subscribe({
    required String channel,
    required String patientId,
  }) =>
      {
        'type': 'subscribe',
        'channel': channel,
        'patient_id': patientId,
        'timestamp': DateTime.now().toIso8601String(),
      };
  
  static Map<String, dynamic> unsubscribe({
    required String patientId,
  }) =>
      {
        'type': 'unsubscribe',
        'patient_id': patientId,
        'timestamp': DateTime.now().toIso8601String(),
      };
  
  static Map<String, dynamic> vitalsUpdate({
    required String patientId,
    required Map<String, dynamic> vitalsData,
  }) =>
      {
        'type': 'vitals_update',
        'patient_id': patientId,
        'data': vitalsData,
        'timestamp': DateTime.now().toIso8601String(),
      };
}

// Connection quality monitor
class ConnectionQualityMonitor {
  static const Duration _checkInterval = Duration(seconds: 15);
  static const Duration _healthyThreshold = Duration(seconds: 5);
  static const Duration _degradedThreshold = Duration(seconds: 30);
  
  Timer? _monitorTimer;
  ConnectionQuality _currentQuality = ConnectionQuality.unknown;
  
  ConnectionQuality get quality => _currentQuality;
  
  void startMonitoring(WebSocketService service) {
    _monitorTimer?.cancel();
    
    _monitorTimer = Timer.periodic(_checkInterval, (_) {
      final state = service.state;
      
      if (!state.isConnected) {
        _currentQuality = ConnectionQuality.disconnected;
      } else if (state.timeSinceLastMessage > _degradedThreshold) {
        _currentQuality = ConnectionQuality.poor;
      } else if (state.timeSinceLastMessage > _healthyThreshold) {
        _currentQuality = ConnectionQuality.fair;
      } else {
        _currentQuality = ConnectionQuality.excellent;
      }
    });
  }
  
  void stopMonitoring() {
    _monitorTimer?.cancel();
    _currentQuality = ConnectionQuality.unknown;
  }
}

enum ConnectionQuality {
  unknown,
  disconnected,
  poor,
  fair,
  excellent,
}

// Real-time update handler interface
abstract class RealtimeUpdateHandler {
  void handleVitalsUpdate(Map<String, dynamic> data);
  void handleBPUpdate(Map<String, dynamic> data);
  void handleAIRecommendation(Map<String, dynamic> data);
  void handleSyncNotification(Map<String, dynamic> data);
}

// WebSocket metrics for monitoring
class WebSocketMetrics {
  int messagesReceived = 0;
  int messagesSent = 0;
  int reconnections = 0;
  Duration totalConnectedTime = Duration.zero;
  DateTime? firstConnection;
  DateTime? lastDisconnection;
  
  void recordMessage({required bool sent}) {
    if (sent) {
      messagesSent++;
    } else {
      messagesReceived++;
    }
  }
  
  void recordReconnection() {
    reconnections++;
  }
  
  void recordConnection() {
    firstConnection ??= DateTime.now();
  }
  
  void recordDisconnection(Duration connectedDuration) {
    totalConnectedTime += connectedDuration;
    lastDisconnection = DateTime.now();
  }
  
  Map<String, dynamic> toJson() => {
        'messages_received': messagesReceived,
        'messages_sent': messagesSent,
        'reconnections': reconnections,
        'total_connected_time_ms': totalConnectedTime.inMilliseconds,
        'first_connection': firstConnection?.toIso8601String(),
        'last_disconnection': lastDisconnection?.toIso8601String(),
      };
}
