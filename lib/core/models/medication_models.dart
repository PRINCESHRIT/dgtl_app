import 'package:json_annotation/json_annotation.dart';

part 'medication_models.g.dart';

/// Medication Frequency Enum
enum MedicationFrequency {
  daily,
  twiceDaily,
  thriceDaily,
  weekly,
  monthly,
  asNeeded,
  custom,
}

/// Medication Model
@JsonSerializable()
class Medication {
  final String id;
  final String name;
  final String genericName;
  final String dosage;
  final String unit; // 'mg', 'ml', 'tablet', etc.
  final MedicationFrequency frequency;
  final String? customFrequency; // For custom frequencies
  final List<String> timesPerDay; // ['08:00', '14:00', '20:00']
  final DateTime startDate;
  final DateTime? endDate;
  final String? prescribedBy; // Doctor's name
  final String? purpose; // What it's for
  final List<String>? sideEffects;
  final List<String>? interactions;
  final String? instructions; // Special instructions
  final bool isActive;
  final int? refillReminder; // Days before running out
  final String? pharmacy;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Medication({
    required this.id,
    required this.name,
    required this.genericName,
    required this.dosage,
    required this.unit,
    required this.frequency,
    this.customFrequency,
    required this.timesPerDay,
    required this.startDate,
    this.endDate,
    this.prescribedBy,
    this.purpose,
    this.sideEffects,
    this.interactions,
    this.instructions,
    required this.isActive,
    this.refillReminder,
    this.pharmacy,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationToJson(this);

  Medication copyWith({
    String? id,
    String? name,
    String? genericName,
    String? dosage,
    String? unit,
    MedicationFrequency? frequency,
    String? customFrequency,
    List<String>? timesPerDay,
    DateTime? startDate,
    DateTime? endDate,
    String? prescribedBy,
    String? purpose,
    List<String>? sideEffects,
    List<String>? interactions,
    String? instructions,
    bool? isActive,
    int? refillReminder,
    String? pharmacy,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      genericName: genericName ?? this.genericName,
      dosage: dosage ?? this.dosage,
      unit: unit ?? this.unit,
      frequency: frequency ?? this.frequency,
      customFrequency: customFrequency ?? this.customFrequency,
      timesPerDay: timesPerDay ?? this.timesPerDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      prescribedBy: prescribedBy ?? this.prescribedBy,
      purpose: purpose ?? this.purpose,
      sideEffects: sideEffects ?? this.sideEffects,
      interactions: interactions ?? this.interactions,
      instructions: instructions ?? this.instructions,
      isActive: isActive ?? this.isActive,
      refillReminder: refillReminder ?? this.refillReminder,
      pharmacy: pharmacy ?? this.pharmacy,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get frequency in Hindi
  String get frequencyInHindi {
    switch (frequency) {
      case MedicationFrequency.daily:
        return 'दैनिक';
      case MedicationFrequency.twiceDaily:
        return 'दिन में दो बार';
      case MedicationFrequency.thriceDaily:
        return 'दिन में तीन बार';
      case MedicationFrequency.weekly:
        return 'साप्ताहिक';
      case MedicationFrequency.monthly:
        return 'मासिक';
      case MedicationFrequency.asNeeded:
        return 'आवश्यकतानुसार';
      case MedicationFrequency.custom:
        return customFrequency ?? 'विशेष';
    }
  }
}

/// Medication Adherence Log
@JsonSerializable()
class MedicationAdherence {
  final String id;
  final String medicationId;
  final String userId;
  final DateTime scheduledTime;
  final DateTime? actualTime;
  final bool taken;
  final String? reason; // If not taken, why?
  final String? notes;
  final double? adherenceScore; // 0.0 to 1.0
  final Map<String, dynamic>? metadata;

  const MedicationAdherence({
    required this.id,
    required this.medicationId,
    required this.userId,
    required this.scheduledTime,
    this.actualTime,
    required this.taken,
    this.reason,
    this.notes,
    this.adherenceScore,
    this.metadata,
  });

  factory MedicationAdherence.fromJson(Map<String, dynamic> json) =>
      _$MedicationAdherenceFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationAdherenceToJson(this);
}

/// Medication Side Effect Report
@JsonSerializable()
class SideEffectReport {
  final String id;
  final String medicationId;
  final String userId;
  final String sideEffect;
  final String severity; // 'mild', 'moderate', 'severe'
  final DateTime reportedAt;
  final String? description;
  final bool reportedToDoctor;
  final DateTime? reportedToDoctorAt;
  final Map<String, dynamic>? metadata;

  const SideEffectReport({
    required this.id,
    required this.medicationId,
    required this.userId,
    required this.sideEffect,
    required this.severity,
    required this.reportedAt,
    this.description,
    required this.reportedToDoctor,
    this.reportedToDoctorAt,
    this.metadata,
  });

  factory SideEffectReport.fromJson(Map<String, dynamic> json) =>
      _$SideEffectReportFromJson(json);

  Map<String, dynamic> toJson() => _$SideEffectReportToJson(this);
}

/// Medication Refill Request
@JsonSerializable()
class MedicationRefill {
  final String id;
  final String medicationId;
  final String userId;
  final String pharmacy;
  final DateTime requestedAt;
  final DateTime? expectedDate;
  final String status; // 'requested', 'processing', 'ready', 'collected'
  final String? notes;
  final Map<String, dynamic>? metadata;

  const MedicationRefill({
    required this.id,
    required this.medicationId,
    required this.userId,
    required this.pharmacy,
    required this.requestedAt,
    this.expectedDate,
    required this.status,
    this.notes,
    this.metadata,
  });

  factory MedicationRefill.fromJson(Map<String, dynamic> json) =>
      _$MedicationRefillFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationRefillToJson(this);
}
