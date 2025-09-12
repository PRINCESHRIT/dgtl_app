// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicationNotification _$MedicationNotificationFromJson(
        Map<String, dynamic> json) =>
    MedicationNotification(
      id: json['id'] as String,
      medicationId: json['medication_id'] as String,
      medicationName: json['medication_name'] as String,
      dosage: json['dosage'] as String,
      scheduledTime: DateTime.parse(json['scheduled_time'] as String),
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      body: json['body'] as String,
      isRepeating: json['is_repeating'] as bool,
      cronExpression: json['cron_expression'] as String?,
      isActive: json['is_active'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      dismissedAt: json['dismissed_at'] == null
          ? null
          : DateTime.parse(json['dismissed_at'] as String),
    );

Map<String, dynamic> _$MedicationNotificationToJson(
    MedicationNotification instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'medication_id': instance.medicationId,
    'medication_name': instance.medicationName,
    'dosage': instance.dosage,
    'scheduled_time': instance.scheduledTime.toIso8601String(),
    'type': _$NotificationTypeEnumMap[instance.type]!,
    'title': instance.title,
    'body': instance.body,
    'is_repeating': instance.isRepeating,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cron_expression', instance.cronExpression);
  val['is_active'] = instance.isActive;
  writeNotNull('metadata', instance.metadata);
  val['created_at'] = instance.createdAt.toIso8601String();
  writeNotNull('dismissed_at', instance.dismissedAt?.toIso8601String());
  return val;
}

const _$NotificationTypeEnumMap = {
  NotificationType.medication: 'medication',
  NotificationType.appointment: 'appointment',
  NotificationType.bloodPressure: 'bloodPressure',
  NotificationType.labResults: 'labResults',
  NotificationType.healthTip: 'healthTip',
  NotificationType.emergency: 'emergency',
};

HealthAlertNotification _$HealthAlertNotificationFromJson(
        Map<String, dynamic> json) =>
    HealthAlertNotification(
      id: json['id'] as String,
      alertType: json['alert_type'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      healthData: json['health_data'] as Map<String, dynamic>?,
      recommendedActions: (json['recommended_actions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isRead: json['is_read'] as bool,
      requiresAcknowledgment: json['requires_acknowledgment'] as bool,
      acknowledgedAt: json['acknowledged_at'] == null
          ? null
          : DateTime.parse(json['acknowledged_at'] as String),
    );

Map<String, dynamic> _$HealthAlertNotificationToJson(
    HealthAlertNotification instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'alert_type': instance.alertType,
    'title': instance.title,
    'message': instance.message,
    'severity': instance.severity,
    'timestamp': instance.timestamp.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('health_data', instance.healthData);
  writeNotNull('recommended_actions', instance.recommendedActions);
  val['is_read'] = instance.isRead;
  val['requires_acknowledgment'] = instance.requiresAcknowledgment;
  writeNotNull('acknowledged_at', instance.acknowledgedAt?.toIso8601String());
  return val;
}

NotificationPreferences _$NotificationPreferencesFromJson(
        Map<String, dynamic> json) =>
    NotificationPreferences(
      userId: json['user_id'] as String,
      medicationReminders: json['medication_reminders'] as bool,
      healthAlerts: json['health_alerts'] as bool,
      labResultAlerts: json['lab_result_alerts'] as bool,
      appointmentReminders: json['appointment_reminders'] as bool,
      healthTips: json['health_tips'] as bool,
      medicationReminderAdvance:
          (json['medication_reminder_advance'] as num).toInt(),
      appointmentReminderAdvance:
          (json['appointment_reminder_advance'] as num).toInt(),
      preferredNotificationTime: json['preferred_notification_time'] as String,
      enableSound: json['enable_sound'] as bool,
      enableVibration: json['enable_vibration'] as bool,
      language: json['language'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$NotificationPreferencesToJson(
        NotificationPreferences instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'medication_reminders': instance.medicationReminders,
      'health_alerts': instance.healthAlerts,
      'lab_result_alerts': instance.labResultAlerts,
      'appointment_reminders': instance.appointmentReminders,
      'health_tips': instance.healthTips,
      'medication_reminder_advance': instance.medicationReminderAdvance,
      'appointment_reminder_advance': instance.appointmentReminderAdvance,
      'preferred_notification_time': instance.preferredNotificationTime,
      'enable_sound': instance.enableSound,
      'enable_vibration': instance.enableVibration,
      'language': instance.language,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

NotificationAction _$NotificationActionFromJson(Map<String, dynamic> json) =>
    NotificationAction(
      id: json['id'] as String,
      label: json['label'] as String,
      actionType: json['action_type'] as String,
      parameters: json['parameters'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$NotificationActionToJson(NotificationAction instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'label': instance.label,
    'action_type': instance.actionType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('parameters', instance.parameters);
  return val;
}
