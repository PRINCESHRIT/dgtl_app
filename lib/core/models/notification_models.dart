import 'package:json_annotation/json_annotation.dart';

part 'notification_models.g.dart';

/// Notification Type Enum
enum NotificationType {
  medication,
  appointment,
  bloodPressure,
  labResults,
  healthTip,
  emergency,
}

/// Medication Reminder Notification
@JsonSerializable()
class MedicationNotification {
  final String id;
  final String medicationId;
  final String medicationName;
  final String dosage;
  final DateTime scheduledTime;
  final NotificationType type;
  final String title;
  final String body;
  final bool isRepeating;
  final String? cronExpression;
  final bool isActive;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? dismissedAt;

  const MedicationNotification({
    required this.id,
    required this.medicationId,
    required this.medicationName,
    required this.dosage,
    required this.scheduledTime,
    required this.type,
    required this.title,
    required this.body,
    required this.isRepeating,
    this.cronExpression,
    required this.isActive,
    this.metadata,
    required this.createdAt,
    this.dismissedAt,
  });

  factory MedicationNotification.fromJson(Map<String, dynamic> json) =>
      _$MedicationNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationNotificationToJson(this);

  MedicationNotification copyWith({
    String? id,
    String? medicationId,
    String? medicationName,
    String? dosage,
    DateTime? scheduledTime,
    NotificationType? type,
    String? title,
    String? body,
    bool? isRepeating,
    String? cronExpression,
    bool? isActive,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? dismissedAt,
  }) {
    return MedicationNotification(
      id: id ?? this.id,
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      isRepeating: isRepeating ?? this.isRepeating,
      cronExpression: cronExpression ?? this.cronExpression,
      isActive: isActive ?? this.isActive,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      dismissedAt: dismissedAt ?? this.dismissedAt,
    );
  }
}

/// Health Alert Notification
@JsonSerializable()
class HealthAlertNotification {
  final String id;
  final String alertType; // 'high_bp', 'missed_medication', 'lab_abnormal', etc.
  final String title;
  final String message;
  final String severity; // 'low', 'medium', 'high', 'critical'
  final DateTime timestamp;
  final Map<String, dynamic>? healthData;
  final List<String>? recommendedActions;
  final bool isRead;
  final bool requiresAcknowledgment;
  final DateTime? acknowledgedAt;

  const HealthAlertNotification({
    required this.id,
    required this.alertType,
    required this.title,
    required this.message,
    required this.severity,
    required this.timestamp,
    this.healthData,
    this.recommendedActions,
    required this.isRead,
    required this.requiresAcknowledgment,
    this.acknowledgedAt,
  });

  factory HealthAlertNotification.fromJson(Map<String, dynamic> json) =>
      _$HealthAlertNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$HealthAlertNotificationToJson(this);

  HealthAlertNotification copyWith({
    String? id,
    String? alertType,
    String? title,
    String? message,
    String? severity,
    DateTime? timestamp,
    Map<String, dynamic>? healthData,
    List<String>? recommendedActions,
    bool? isRead,
    bool? requiresAcknowledgment,
    DateTime? acknowledgedAt,
  }) {
    return HealthAlertNotification(
      id: id ?? this.id,
      alertType: alertType ?? this.alertType,
      title: title ?? this.title,
      message: message ?? this.message,
      severity: severity ?? this.severity,
      timestamp: timestamp ?? this.timestamp,
      healthData: healthData ?? this.healthData,
      recommendedActions: recommendedActions ?? this.recommendedActions,
      isRead: isRead ?? this.isRead,
      requiresAcknowledgment: requiresAcknowledgment ?? this.requiresAcknowledgment,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
    );
  }
}

/// Notification Preferences
@JsonSerializable()
class NotificationPreferences {
  final String userId;
  final bool medicationReminders;
  final bool healthAlerts;
  final bool labResultAlerts;
  final bool appointmentReminders;
  final bool healthTips;
  final int medicationReminderAdvance; // minutes before
  final int appointmentReminderAdvance; // hours before
  final String preferredNotificationTime; // HH:mm format
  final bool enableSound;
  final bool enableVibration;
  final String language; // 'hindi', 'english'
  final DateTime updatedAt;

  const NotificationPreferences({
    required this.userId,
    required this.medicationReminders,
    required this.healthAlerts,
    required this.labResultAlerts,
    required this.appointmentReminders,
    required this.healthTips,
    required this.medicationReminderAdvance,
    required this.appointmentReminderAdvance,
    required this.preferredNotificationTime,
    required this.enableSound,
    required this.enableVibration,
    required this.language,
    required this.updatedAt,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPreferencesToJson(this);

  /// Default preferences for new users
  factory NotificationPreferences.defaultPreferences(String userId) {
    return NotificationPreferences(
      userId: userId,
      medicationReminders: true,
      healthAlerts: true,
      labResultAlerts: true,
      appointmentReminders: true,
      healthTips: true,
      medicationReminderAdvance: 15, // 15 minutes before
      appointmentReminderAdvance: 2, // 2 hours before
      preferredNotificationTime: '09:00',
      enableSound: true,
      enableVibration: true,
      language: 'hindi',
      updatedAt: DateTime.now(),
    );
  }
}

/// Notification Action Model
@JsonSerializable()
class NotificationAction {
  final String id;
  final String label;
  final String actionType; // 'dismiss', 'snooze', 'acknowledge', 'take_medication'
  final Map<String, dynamic>? parameters;

  const NotificationAction({
    required this.id,
    required this.label,
    required this.actionType,
    this.parameters,
  });

  factory NotificationAction.fromJson(Map<String, dynamic> json) =>
      _$NotificationActionFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationActionToJson(this);
}
