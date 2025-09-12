// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BPReading _$BPReadingFromJson(Map<String, dynamic> json) => BPReading(
      id: json['id'] as String,
      systolic: (json['systolic'] as num).toInt(),
      diastolic: (json['diastolic'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
      userId: json['user_id'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$BPReadingToJson(BPReading instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'systolic': instance.systolic,
    'diastolic': instance.diastolic,
    'timestamp': instance.timestamp.toIso8601String(),
    'status': instance.status,
    'user_id': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  return val;
}

BPReadingRequest _$BPReadingRequestFromJson(Map<String, dynamic> json) =>
    BPReadingRequest(
      systolic: (json['systolic'] as num).toInt(),
      diastolic: (json['diastolic'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['user_id'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$BPReadingRequestToJson(BPReadingRequest instance) {
  final val = <String, dynamic>{
    'systolic': instance.systolic,
    'diastolic': instance.diastolic,
    'timestamp': instance.timestamp.toIso8601String(),
    'user_id': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  return val;
}

HealthSymptoms _$HealthSymptomsFromJson(Map<String, dynamic> json) =>
    HealthSymptoms(
      id: json['id'] as String,
      fatigueLevel: (json['fatigue_level'] as num).toInt(),
      painLevel: (json['pain_level'] as num).toInt(),
      fluidIntake: (json['fluid_intake'] as num).toDouble(),
      toiletVisits: (json['toilet_visits'] as num).toInt(),
      loggedAt: DateTime.parse(json['logged_at'] as String),
      userId: json['user_id'] as String,
      additionalNotes: json['additional_notes'] as String?,
    );

Map<String, dynamic> _$HealthSymptomsToJson(HealthSymptoms instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'fatigue_level': instance.fatigueLevel,
    'pain_level': instance.painLevel,
    'fluid_intake': instance.fluidIntake,
    'toilet_visits': instance.toiletVisits,
    'logged_at': instance.loggedAt.toIso8601String(),
    'user_id': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('additional_notes', instance.additionalNotes);
  return val;
}

SymptomsRequest _$SymptomsRequestFromJson(Map<String, dynamic> json) =>
    SymptomsRequest(
      fatigueLevel: (json['fatigue_level'] as num).toInt(),
      painLevel: (json['pain_level'] as num).toInt(),
      fluidIntake: (json['fluid_intake'] as num).toDouble(),
      toiletVisits: (json['toilet_visits'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['user_id'] as String,
      additionalNotes: json['additional_notes'] as String?,
    );

Map<String, dynamic> _$SymptomsRequestToJson(SymptomsRequest instance) {
  final val = <String, dynamic>{
    'fatigue_level': instance.fatigueLevel,
    'pain_level': instance.painLevel,
    'fluid_intake': instance.fluidIntake,
    'toilet_visits': instance.toiletVisits,
    'timestamp': instance.timestamp.toIso8601String(),
    'user_id': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('additional_notes', instance.additionalNotes);
  return val;
}

VitalsData _$VitalsDataFromJson(Map<String, dynamic> json) => VitalsData(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      recordedAt: DateTime.parse(json['recorded_at'] as String),
      creatinine: (json['creatinine'] as num?)?.toDouble(),
      bun: (json['bun'] as num?)?.toDouble(),
      gfr: (json['gfr'] as num?)?.toDouble(),
      albumin: (json['albumin'] as num?)?.toDouble(),
      hemoglobin: (json['hemoglobin'] as num?)?.toDouble(),
      phosphorus: (json['phosphorus'] as num?)?.toDouble(),
      calcium: (json['calcium'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      heartRate: (json['heart_rate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VitalsDataToJson(VitalsData instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user_id': instance.userId,
    'recorded_at': instance.recordedAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('creatinine', instance.creatinine);
  writeNotNull('bun', instance.bun);
  writeNotNull('gfr', instance.gfr);
  writeNotNull('albumin', instance.albumin);
  writeNotNull('hemoglobin', instance.hemoglobin);
  writeNotNull('phosphorus', instance.phosphorus);
  writeNotNull('calcium', instance.calcium);
  writeNotNull('weight', instance.weight);
  writeNotNull('height', instance.height);
  writeNotNull('heart_rate', instance.heartRate);
  return val;
}

HealthDataRequest _$HealthDataRequestFromJson(Map<String, dynamic> json) =>
    HealthDataRequest(
      userId: json['user_id'] as String,
      bpReading: json['bp_reading'] == null
          ? null
          : BPReadingRequest.fromJson(
              json['bp_reading'] as Map<String, dynamic>),
      symptoms: json['symptoms'] == null
          ? null
          : SymptomsRequest.fromJson(json['symptoms'] as Map<String, dynamic>),
      vitals: json['vitals'] == null
          ? null
          : VitalsData.fromJson(json['vitals'] as Map<String, dynamic>),
      requestTimestamp: DateTime.parse(json['request_timestamp'] as String),
      specificQuestion: json['specific_question'] as String?,
    );

Map<String, dynamic> _$HealthDataRequestToJson(HealthDataRequest instance) {
  final val = <String, dynamic>{
    'user_id': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bp_reading', instance.bpReading?.toJson());
  writeNotNull('symptoms', instance.symptoms?.toJson());
  writeNotNull('vitals', instance.vitals?.toJson());
  val['request_timestamp'] = instance.requestTimestamp.toIso8601String();
  writeNotNull('specific_question', instance.specificQuestion);
  return val;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      medicalConditions: (json['medical_conditions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      medications: (json['medications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      preferredLanguage: json['preferred_language'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'age': instance.age,
    'gender': instance.gender,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('height', instance.height);
  writeNotNull('weight', instance.weight);
  val['medical_conditions'] = instance.medicalConditions;
  val['medications'] = instance.medications;
  val['preferred_language'] = instance.preferredLanguage;
  val['created_at'] = instance.createdAt.toIso8601String();
  val['updated_at'] = instance.updatedAt.toIso8601String();
  return val;
}

UserProfileUpdateRequest _$UserProfileUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    UserProfileUpdateRequest(
      name: json['name'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      medicalConditions: (json['medical_conditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      medications: (json['medications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferredLanguage: json['preferred_language'] as String?,
    );

Map<String, dynamic> _$UserProfileUpdateRequestToJson(
    UserProfileUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('age', instance.age);
  writeNotNull('gender', instance.gender);
  writeNotNull('height', instance.height);
  writeNotNull('weight', instance.weight);
  writeNotNull('medical_conditions', instance.medicalConditions);
  writeNotNull('medications', instance.medications);
  writeNotNull('preferred_language', instance.preferredLanguage);
  return val;
}
