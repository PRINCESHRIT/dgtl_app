import 'package:json_annotation/json_annotation.dart';

part 'lab_models.g.dart';

/// CKD Big 7 Lab Parameters
enum LabParameterType {
  bloodPressure,
  proteinuria,
  eGFR,
  diabetes,
  smokingStatus,
  cardiovascularDisease,
  medicationAdherence,
}

/// Lab Result Model
@JsonSerializable()
class LabResult {
  final String id;
  final String userId;
  final String testName;
  final LabParameterType? parameterType;
  final double value;
  final String unit;
  final String? normalRange;
  final String status; // 'normal', 'abnormal', 'borderline', 'critical'
  final DateTime testDate;
  final DateTime? reportDate;
  final String? labName;
  final String? doctorName;
  final String? notes;
  final Map<String, dynamic>? metadata;
  final String? reportUrl; // PDF report URL
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LabResult({
    required this.id,
    required this.userId,
    required this.testName,
    this.parameterType,
    required this.value,
    required this.unit,
    this.normalRange,
    required this.status,
    required this.testDate,
    this.reportDate,
    this.labName,
    this.doctorName,
    this.notes,
    this.metadata,
    this.reportUrl,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LabResult.fromJson(Map<String, dynamic> json) =>
      _$LabResultFromJson(json);

  Map<String, dynamic> toJson() => _$LabResultToJson(this);

  /// Get status in Hindi
  String get statusInHindi {
    switch (status.toLowerCase()) {
      case 'normal':
        return 'सामान्य';
      case 'abnormal':
        return 'असामान्य';
      case 'borderline':
        return 'सीमारेखा';
      case 'critical':
        return 'गंभीर';
      default:
        return 'अज्ञात';
    }
  }

  /// Get parameter type in Hindi
  String get parameterTypeInHindi {
    if (parameterType == null) return testName;
    
    switch (parameterType!) {
      case LabParameterType.bloodPressure:
        return 'रक्तचाप';
      case LabParameterType.proteinuria:
        return 'मूत्र में प्रोटीन';
      case LabParameterType.eGFR:
        return 'गुर्दा कार्यप्रणाली';
      case LabParameterType.diabetes:
        return 'मधुमेह';
      case LabParameterType.smokingStatus:
        return 'धूम्रपान स्थिति';
      case LabParameterType.cardiovascularDisease:
        return 'हृदय रोग';
      case LabParameterType.medicationAdherence:
        return 'दवा अनुपालन';
    }
  }
}

/// CKD Big 7 Assessment
@JsonSerializable()
class CKDBig7Assessment {
  final String id;
  final String userId;
  final DateTime assessmentDate;
  
  // Big 7 Parameters
  final double? bloodPressureSystolic;
  final double? bloodPressureDiastolic;
  final double? proteinuria; // mg/g creatinine
  final double? eGFR; // mL/min/1.73m²
  final double? hba1c; // % (if diabetic)
  final bool? smokingStatus;
  final bool? cardiovascularDisease;
  final double? medicationAdherence; // percentage
  
  // Calculated Scores
  final int overallScore; // 0-7
  final String riskLevel; // 'low', 'medium', 'high', 'very_high'
  final List<String> recommendations;
  final DateTime nextAssessmentDate;
  final Map<String, dynamic>? metadata;

  const CKDBig7Assessment({
    required this.id,
    required this.userId,
    required this.assessmentDate,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.proteinuria,
    this.eGFR,
    this.hba1c,
    this.smokingStatus,
    this.cardiovascularDisease,
    this.medicationAdherence,
    required this.overallScore,
    required this.riskLevel,
    required this.recommendations,
    required this.nextAssessmentDate,
    this.metadata,
  });

  factory CKDBig7Assessment.fromJson(Map<String, dynamic> json) =>
      _$CKDBig7AssessmentFromJson(json);

  Map<String, dynamic> toJson() => _$CKDBig7AssessmentToJson(this);

  /// Get risk level in Hindi
  String get riskLevelInHindi {
    switch (riskLevel) {
      case 'low':
        return 'कम जोखिम';
      case 'medium':
        return 'मध्यम जोखिम';
      case 'high':
        return 'उच्च जोखिम';
      case 'very_high':
        return 'अत्यधिक जोखिम';
      default:
        return 'अज्ञात जोखिम';
    }
  }

  /// Get completion percentage
  double get completionPercentage {
    int completed = 0;
    int total = 7;
    
    if (bloodPressureSystolic != null && bloodPressureDiastolic != null) completed++;
    if (proteinuria != null) completed++;
    if (eGFR != null) completed++;
    if (hba1c != null) completed++;
    if (smokingStatus != null) completed++;
    if (cardiovascularDisease != null) completed++;
    if (medicationAdherence != null) completed++;
    
    return (completed / total) * 100;
  }
}

/// Lab Report Upload
@JsonSerializable()
class LabReportUpload {
  final String id;
  final String userId;
  final String fileName;
  final String fileUrl;
  final String fileType; // 'pdf', 'image'
  final DateTime uploadDate;
  final String status; // 'processing', 'analyzed', 'error'
  final List<LabResult>? extractedResults;
  final String? processingError;
  final Map<String, dynamic>? ocrData;
  final bool isProcessed;
  final DateTime? processedAt;

  const LabReportUpload({
    required this.id,
    required this.userId,
    required this.fileName,
    required this.fileUrl,
    required this.fileType,
    required this.uploadDate,
    required this.status,
    this.extractedResults,
    this.processingError,
    this.ocrData,
    required this.isProcessed,
    this.processedAt,
  });

  factory LabReportUpload.fromJson(Map<String, dynamic> json) =>
      _$LabReportUploadFromJson(json);

  Map<String, dynamic> toJson() => _$LabReportUploadToJson(this);
}

/// Lab Trend Analysis
@JsonSerializable()
class LabTrendAnalysis {
  final String id;
  final String userId;
  final String parameterName;
  final LabParameterType parameterType;
  final List<LabResult> historicalResults;
  final String trendDirection; // 'improving', 'stable', 'declining'
  final double? trendSlope;
  final String? trendAnalysis;
  final List<String>? recommendations;
  final DateTime analyzedAt;
  final DateTime nextReviewDate;

  const LabTrendAnalysis({
    required this.id,
    required this.userId,
    required this.parameterName,
    required this.parameterType,
    required this.historicalResults,
    required this.trendDirection,
    this.trendSlope,
    this.trendAnalysis,
    this.recommendations,
    required this.analyzedAt,
    required this.nextReviewDate,
  });

  factory LabTrendAnalysis.fromJson(Map<String, dynamic> json) =>
      _$LabTrendAnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$LabTrendAnalysisToJson(this);

  /// Get trend direction in Hindi
  String get trendDirectionInHindi {
    switch (trendDirection) {
      case 'improving':
        return 'सुधार हो रहा है';
      case 'stable':
        return 'स्थिर';
      case 'declining':
        return 'बिगड़ रहा है';
      default:
        return 'अज्ञात';
    }
  }
}
