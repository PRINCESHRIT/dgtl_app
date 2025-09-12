// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medication _$MedicationFromJson(Map<String, dynamic> json) => Medication(
      id: json['id'] as String,
      name: json['name'] as String,
      genericName: json['generic_name'] as String,
      dosage: json['dosage'] as String,
      unit: json['unit'] as String,
      frequency: $enumDecode(_$MedicationFrequencyEnumMap, json['frequency']),
      customFrequency: json['custom_frequency'] as String?,
      timesPerDay: (json['times_per_day'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      prescribedBy: json['prescribed_by'] as String?,
      purpose: json['purpose'] as String?,
      sideEffects: (json['side_effects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      interactions: (json['interactions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      instructions: json['instructions'] as String?,
      isActive: json['is_active'] as bool,
      refillReminder: (json['refill_reminder'] as num?)?.toInt(),
      pharmacy: json['pharmacy'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MedicationToJson(Medication instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'generic_name': instance.genericName,
    'dosage': instance.dosage,
    'unit': instance.unit,
    'frequency': _$MedicationFrequencyEnumMap[instance.frequency]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('custom_frequency', instance.customFrequency);
  val['times_per_day'] = instance.timesPerDay;
  val['start_date'] = instance.startDate.toIso8601String();
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('prescribed_by', instance.prescribedBy);
  writeNotNull('purpose', instance.purpose);
  writeNotNull('side_effects', instance.sideEffects);
  writeNotNull('interactions', instance.interactions);
  writeNotNull('instructions', instance.instructions);
  val['is_active'] = instance.isActive;
  writeNotNull('refill_reminder', instance.refillReminder);
  writeNotNull('pharmacy', instance.pharmacy);
  writeNotNull('metadata', instance.metadata);
  val['created_at'] = instance.createdAt.toIso8601String();
  val['updated_at'] = instance.updatedAt.toIso8601String();
  return val;
}

const _$MedicationFrequencyEnumMap = {
  MedicationFrequency.daily: 'daily',
  MedicationFrequency.twiceDaily: 'twiceDaily',
  MedicationFrequency.thriceDaily: 'thriceDaily',
  MedicationFrequency.weekly: 'weekly',
  MedicationFrequency.monthly: 'monthly',
  MedicationFrequency.asNeeded: 'asNeeded',
  MedicationFrequency.custom: 'custom',
};

MedicationAdherence _$MedicationAdherenceFromJson(Map<String, dynamic> json) =>
    MedicationAdherence(
      id: json['id'] as String,
      medicationId: json['medication_id'] as String,
      userId: json['user_id'] as String,
      scheduledTime: DateTime.parse(json['scheduled_time'] as String),
      actualTime: json['actual_time'] == null
          ? null
          : DateTime.parse(json['actual_time'] as String),
      taken: json['taken'] as bool,
      reason: json['reason'] as String?,
      notes: json['notes'] as String?,
      adherenceScore: (json['adherence_score'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MedicationAdherenceToJson(MedicationAdherence instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'medication_id': instance.medicationId,
    'user_id': instance.userId,
    'scheduled_time': instance.scheduledTime.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('actual_time', instance.actualTime?.toIso8601String());
  val['taken'] = instance.taken;
  writeNotNull('reason', instance.reason);
  writeNotNull('notes', instance.notes);
  writeNotNull('adherence_score', instance.adherenceScore);
  writeNotNull('metadata', instance.metadata);
  return val;
}

SideEffectReport _$SideEffectReportFromJson(Map<String, dynamic> json) =>
    SideEffectReport(
      id: json['id'] as String,
      medicationId: json['medication_id'] as String,
      userId: json['user_id'] as String,
      sideEffect: json['side_effect'] as String,
      severity: json['severity'] as String,
      reportedAt: DateTime.parse(json['reported_at'] as String),
      description: json['description'] as String?,
      reportedToDoctor: json['reported_to_doctor'] as bool,
      reportedToDoctorAt: json['reported_to_doctor_at'] == null
          ? null
          : DateTime.parse(json['reported_to_doctor_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SideEffectReportToJson(SideEffectReport instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'medication_id': instance.medicationId,
    'user_id': instance.userId,
    'side_effect': instance.sideEffect,
    'severity': instance.severity,
    'reported_at': instance.reportedAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['reported_to_doctor'] = instance.reportedToDoctor;
  writeNotNull(
      'reported_to_doctor_at', instance.reportedToDoctorAt?.toIso8601String());
  writeNotNull('metadata', instance.metadata);
  return val;
}

MedicationRefill _$MedicationRefillFromJson(Map<String, dynamic> json) =>
    MedicationRefill(
      id: json['id'] as String,
      medicationId: json['medication_id'] as String,
      userId: json['user_id'] as String,
      pharmacy: json['pharmacy'] as String,
      requestedAt: DateTime.parse(json['requested_at'] as String),
      expectedDate: json['expected_date'] == null
          ? null
          : DateTime.parse(json['expected_date'] as String),
      status: json['status'] as String,
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MedicationRefillToJson(MedicationRefill instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'medication_id': instance.medicationId,
    'user_id': instance.userId,
    'pharmacy': instance.pharmacy,
    'requested_at': instance.requestedAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expected_date', instance.expectedDate?.toIso8601String());
  val['status'] = instance.status;
  writeNotNull('notes', instance.notes);
  writeNotNull('metadata', instance.metadata);
  return val;
}
