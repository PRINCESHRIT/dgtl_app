import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cron/cron.dart';
import 'dart:io';

import '../models/notification_models.dart';
import '../models/medication_models.dart';

part 'notification_service.g.dart';

/// Notification Service for managing local notifications
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();
  
  static final Cron _cron = Cron();
  static bool _initialized = false;

  /// Initialize notification service
  static Future<void> initialize() async {
    if (_initialized) return;
    
    // Initialize timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata')); // Indian timezone
    
    // Initialize notification settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    
    _initialized = true;
  }

  /// Handle notification taps
  static void _onNotificationTapped(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) {
      // Handle notification tap based on payload
      // This would typically navigate to specific screens
      print('Notification tapped with payload: $payload');
    }
  }

  /// Request notification permissions
  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      return await _notifications
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission() ?? false;
    } else if (Platform.isIOS) {
      return await _notifications
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              ) ?? false;
    }
    return true;
  }

  /// Schedule medication reminder
  static Future<void> scheduleMedicationReminder({
    required MedicationNotification notification,
  }) async {
    await initialize();
    
    const androidDetails = AndroidNotificationDetails(
      'medication_channel',
      'दवा रिमाइंडर',
      channelDescription: 'दवा लेने के लिए रिमाइंडर',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@drawable/medication_icon',
      color: Color(0xFF4CAF50),
      playSound: true,
      enableVibration: true,
      actions: [
        AndroidNotificationAction(
          'mark_taken',
          'लिया गया',
          showsUserInterface: true,
        ),
        AndroidNotificationAction(
          'snooze',
          '10 मिनट बाद',
        ),
      ],
    );
    
    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'medication_category',
      interruptionLevel: InterruptionLevel.active,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    if (notification.isRepeating && notification.cronExpression != null) {
      // Schedule recurring notification using cron
      _cron.schedule(Schedule.parse(notification.cronExpression!), () async {
        await _notifications.show(
          notification.id.hashCode,
          notification.title,
          notification.body,
          details,
          payload: notification.id,
        );
      });
    } else {
      // Schedule one-time notification
      await _notifications.zonedSchedule(
        notification.id.hashCode,
        notification.title,
        notification.body,
        tz.TZDateTime.from(notification.scheduledTime, tz.local),
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: notification.id,
      );
    }
  }

  /// Schedule health alert
  static Future<void> scheduleHealthAlert({
    required HealthAlertNotification alert,
  }) async {
    await initialize();
    
    Color alertColor;
    AndroidNotificationDetails androidDetails;
    
    switch (alert.severity) {
      case 'critical':
        alertColor = const Color(0xFFD32F2F);
        androidDetails = AndroidNotificationDetails(
          'health_alerts_critical',
          'आपातकालीन स्वास्थ्य चेतावनी',
          channelDescription: 'गंभीर स्वास्थ्य चेतावनियां',
          importance: Importance.max,
          priority: Priority.max,
          color: alertColor,
          playSound: true,
          enableVibration: true,
          fullScreenIntent: true,
        );
        break;
      case 'high':
        alertColor = const Color(0xFFFF5722);
        androidDetails = AndroidNotificationDetails(
          'health_alerts_high',
          'उच्च स्वास्थ्य चेतावनी',
          channelDescription: 'महत्वपूर्ण स्वास्थ्य चेतावनियां',
          importance: Importance.high,
          priority: Priority.high,
          color: alertColor,
          playSound: true,
          enableVibration: true,
        );
        break;
      default:
        alertColor = const Color(0xFFFF9800);
        androidDetails = AndroidNotificationDetails(
          'health_alerts_medium',
          'स्वास्थ्य चेतावनी',
          channelDescription: 'सामान्य स्वास्थ्य चेतावनियां',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          color: alertColor,
          playSound: true,
        );
    }
    
    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'health_alert_category',
      interruptionLevel: InterruptionLevel.timeSensitive,
    );
    
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.show(
      alert.id.hashCode,
      alert.title,
      alert.message,
      details,
      payload: alert.id,
    );
  }

  /// Schedule daily health tip
  static Future<void> scheduleDailyHealthTip({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    await initialize();
    
    const androidDetails = AndroidNotificationDetails(
      'health_tips',
      'दैनिक स्वास्थ्य टिप्स',
      channelDescription: 'दैनिक स्वास्थ्य सुझाव और टिप्स',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: '@drawable/health_tip_icon',
      color: Color(0xFF2196F3),
      playSound: false,
      enableVibration: false,
    );
    
    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'health_tip_category',
      interruptionLevel: InterruptionLevel.passive,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.zonedSchedule(
      title.hashCode,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Cancel specific notification
  static Future<void> cancelNotification(String notificationId) async {
    await _notifications.cancel(notificationId.hashCode);
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// Get pending notifications
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  /// Show immediate notification
  static Future<void> showImmediateNotification({
    required String id,
    required String title,
    required String body,
    String channelId = 'immediate_notifications',
    String channelName = 'तत्काल अधिसूचना',
  }) async {
    await initialize();
    
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );
    
    const iosDetails = DarwinNotificationDetails(
      interruptionLevel: InterruptionLevel.active,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.show(
      id.hashCode,
      title,
      body,
      details,
      payload: id,
    );
  }
}

/// Notification Service Provider
@riverpod
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService();
}
