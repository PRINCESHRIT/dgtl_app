import 'package:json_annotation/json_annotation.dart';

part 'health_data.g.dart';

/// Blood Pressure Reading Model
@JsonSerializable()
class BPReading {
  final String id;
  final int systolic;
  final int diastolic;
  final DateTime timestamp;
  final String status;
  final String userId;
  final String? notes;

  const BPReading({
    required this.id,
    required this.systolic,
    required this.diastolic,
    required this.timestamp,
    required this.status,
    required this.userId,
    this.notes,
  });

  factory BPReading.fromJson(Map<String, dynamic> json) =>
      _$BPReadingFromJson(json);
  Map<String, dynamic> toJson() => _$BPReadingToJson(this);

  // Helper method to determine status
  String get statusInHindi {
    switch (status.toLowerCase()) {
      case 'normal':
        return 'सामान्य रक्तचाप';
      case 'high_normal':
        return 'उच्च सामान्य';
      case 'high':
        return 'उच्च रक्तचाप';
      case 'low':
        return 'निम्न रक्तचाप';
      default:
        return 'अज्ञात';
    }
  }

  // Helper method for chart data
  double get averageBP => (systolic + diastolic) / 2;
}

/// BP Reading Request Model
@JsonSerializable()
class BPReadingRequest {
  final int systolic;
  final int diastolic;
  final DateTime timestamp;
  final String userId;
  final String? notes;

  const BPReadingRequest({
    required this.systolic,
    required this.diastolic,
    required this.timestamp,
    required this.userId,
    this.notes,
  });

  factory BPReadingRequest.fromJson(Map<String, dynamic> json) =>
      _$BPReadingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BPReadingRequestToJson(this);
}

/// Health Symptoms Model
@JsonSerializable()
class HealthSymptoms {
  final String id;
  final int fatigueLevel; // 1-3 scale
  final int painLevel; // 1-3 scale
  final double fluidIntake; // in liters
  final int toiletVisits;
  final DateTime loggedAt;
  final String userId;
  final String? additionalNotes;

  const HealthSymptoms({
    required this.id,
    required this.fatigueLevel,
    required this.painLevel,
    required this.fluidIntake,
    required this.toiletVisits,
    required this.loggedAt,
    required this.userId,
    this.additionalNotes,
  });

  factory HealthSymptoms.fromJson(Map<String, dynamic> json) =>
      _$HealthSymptomsFromJson(json);
  Map<String, dynamic> toJson() => _$HealthSymptomsToJson(this);
}

/// Symptoms Request Model
@JsonSerializable()
class SymptomsRequest {
  final int fatigueLevel;
  final int painLevel;
  final double fluidIntake;
  final int toiletVisits;
  final DateTime timestamp;
  final String userId;
  final String? additionalNotes;

  const SymptomsRequest({
    required this.fatigueLevel,
    required this.painLevel,
    required this.fluidIntake,
    required this.toiletVisits,
    required this.timestamp,
    required this.userId,
    this.additionalNotes,
  });

  factory SymptomsRequest.fromJson(Map<String, dynamic> json) =>
      _$SymptomsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SymptomsRequestToJson(this);
}

/// Vitals Data Model (for CKD "Big 7")
@JsonSerializable()
class VitalsData {
  final String id;
  final String userId;
  final DateTime recordedAt;
  
  // CKD Big 7 Biomarkers
  final double? creatinine; // mg/dL
  final double? bun; // mg/dL
  final double? gfr; // mL/min/1.73m²
  final double? albumin; // g/dL
  final double? hemoglobin; // g/dL
  final double? phosphorus; // mg/dL
  final double? calcium; // mg/dL
  
  // Additional common vitals
  final double? weight; // kg
  final double? height; // cm
  final int? heartRate; // bpm

  const VitalsData({
    required this.id,
    required this.userId,
    required this.recordedAt,
    this.creatinine,
    this.bun,
    this.gfr,
    this.albumin,
    this.hemoglobin,
    this.phosphorus,
    this.calcium,
    this.weight,
    this.height,
    this.heartRate,
  });

  factory VitalsData.fromJson(Map<String, dynamic> json) =>
      _$VitalsDataFromJson(json);
  Map<String, dynamic> toJson() => _$VitalsDataToJson(this);
}

/// Health Data Request for AI Recommendations
@JsonSerializable()
class HealthDataRequest {
  final String userId;
  final BPReadingRequest? bpReading;
  final SymptomsRequest? symptoms;
  final VitalsData? vitals;
  final DateTime requestTimestamp;
  final String? specificQuestion;

  const HealthDataRequest({
    required this.userId,
    this.bpReading,
    this.symptoms,
    this.vitals,
    required this.requestTimestamp,
    this.specificQuestion,
  });

  factory HealthDataRequest.fromJson(Map<String, dynamic> json) =>
      _$HealthDataRequestFromJson(json);
  Map<String, dynamic> toJson() => _$HealthDataRequestToJson(this);
}

/// User Profile Model
@JsonSerializable()
class UserProfile {
  final String id;
  final String name;
  final int age;
  final String gender;
  final double? height;
  final double? weight;
  final List<String> medicalConditions;
  final List<String> medications;
  final String preferredLanguage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.height,
    this.weight,
    required this.medicalConditions,
    required this.medications,
    required this.preferredLanguage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

/// User Profile Update Request
@JsonSerializable()
class UserProfileUpdateRequest {
  final String? name;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final List<String>? medicalConditions;
  final List<String>? medications;
  final String? preferredLanguage;

  const UserProfileUpdateRequest({
    this.name,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.medicalConditions,
    this.medications,
    this.preferredLanguage,
  });

  factory UserProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserProfileUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileUpdateRequestToJson(this);
}
