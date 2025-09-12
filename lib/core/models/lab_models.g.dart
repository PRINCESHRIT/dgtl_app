// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabResult _$LabResultFromJson(Map<String, dynamic> json) => LabResult(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      testName: json['test_name'] as String,
      parameterType: $enumDecodeNullable(
          _$LabParameterTypeEnumMap, json['parameter_type']),
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      normalRange: json['normal_range'] as String?,
      status: json['status'] as String,
      testDate: DateTime.parse(json['test_date'] as String),
      reportDate: json['report_date'] == null
          ? null
          : DateTime.parse(json['report_date'] as String),
      labName: json['lab_name'] as String?,
      doctorName: json['doctor_name'] as String?,
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      reportUrl: json['report_url'] as String?,
      isVerified: json['is_verified'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$LabResultToJson(LabResult instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user_id': instance.userId,
    'test_name': instance.testName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'parameter_type', _$LabParameterTypeEnumMap[instance.parameterType]);
  val['value'] = instance.value;
  val['unit'] = instance.unit;
  writeNotNull('normal_range', instance.normalRange);
  val['status'] = instance.status;
  val['test_date'] = instance.testDate.toIso8601String();
  writeNotNull('report_date', instance.reportDate?.toIso8601String());
  writeNotNull('lab_name', instance.labName);
  writeNotNull('doctor_name', instance.doctorName);
  writeNotNull('notes', instance.notes);
  writeNotNull('metadata', instance.metadata);
  writeNotNull('report_url', instance.reportUrl);
  val['is_verified'] = instance.isVerified;
  val['created_at'] = instance.createdAt.toIso8601String();
  val['updated_at'] = instance.updatedAt.toIso8601String();
  return val;
}

const _$LabParameterTypeEnumMap = {
  LabParameterType.bloodPressure: 'bloodPressure',
  LabParameterType.proteinuria: 'proteinuria',
  LabParameterType.eGFR: 'eGFR',
  LabParameterType.diabetes: 'diabetes',
  LabParameterType.smokingStatus: 'smokingStatus',
  LabParameterType.cardiovascularDisease: 'cardiovascularDisease',
  LabParameterType.medicationAdherence: 'medicationAdherence',
};

CKDBig7Assessment _$CKDBig7AssessmentFromJson(Map<String, dynamic> json) =>
    CKDBig7Assessment(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      assessmentDate: DateTime.parse(json['assessment_date'] as String),
      bloodPressureSystolic:
          (json['blood_pressure_systolic'] as num?)?.toDouble(),
      bloodPressureDiastolic:
          (json['blood_pressure_diastolic'] as num?)?.toDouble(),
      proteinuria: (json['proteinuria'] as num?)?.toDouble(),
      eGFR: (json['e_g_f_r'] as num?)?.toDouble(),
      hba1c: (json['hba1c'] as num?)?.toDouble(),
      smokingStatus: json['smoking_status'] as bool?,
      cardiovascularDisease: json['cardiovascular_disease'] as bool?,
      medicationAdherence: (json['medication_adherence'] as num?)?.toDouble(),
      overallScore: (json['overall_score'] as num).toInt(),
      riskLevel: json['risk_level'] as String,
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nextAssessmentDate:
          DateTime.parse(json['next_assessment_date'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CKDBig7AssessmentToJson(CKDBig7Assessment instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user_id': instance.userId,
    'assessment_date': instance.assessmentDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blood_pressure_systolic', instance.bloodPressureSystolic);
  writeNotNull('blood_pressure_diastolic', instance.bloodPressureDiastolic);
  writeNotNull('proteinuria', instance.proteinuria);
  writeNotNull('e_g_f_r', instance.eGFR);
  writeNotNull('hba1c', instance.hba1c);
  writeNotNull('smoking_status', instance.smokingStatus);
  writeNotNull('cardiovascular_disease', instance.cardiovascularDisease);
  writeNotNull('medication_adherence', instance.medicationAdherence);
  val['overall_score'] = instance.overallScore;
  val['risk_level'] = instance.riskLevel;
  val['recommendations'] = instance.recommendations;
  val['next_assessment_date'] = instance.nextAssessmentDate.toIso8601String();
  writeNotNull('metadata', instance.metadata);
  return val;
}

LabReportUpload _$LabReportUploadFromJson(Map<String, dynamic> json) =>
    LabReportUpload(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fileName: json['file_name'] as String,
      fileUrl: json['file_url'] as String,
      fileType: json['file_type'] as String,
      uploadDate: DateTime.parse(json['upload_date'] as String),
      status: json['status'] as String,
      extractedResults: (json['extracted_results'] as List<dynamic>?)
          ?.map((e) => LabResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      processingError: json['processing_error'] as String?,
      ocrData: json['ocr_data'] as Map<String, dynamic>?,
      isProcessed: json['is_processed'] as bool,
      processedAt: json['processed_at'] == null
          ? null
          : DateTime.parse(json['processed_at'] as String),
    );

Map<String, dynamic> _$LabReportUploadToJson(LabReportUpload instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user_id': instance.userId,
    'file_name': instance.fileName,
    'file_url': instance.fileUrl,
    'file_type': instance.fileType,
    'upload_date': instance.uploadDate.toIso8601String(),
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('extracted_results',
      instance.extractedResults?.map((e) => e.toJson()).toList());
  writeNotNull('processing_error', instance.processingError);
  writeNotNull('ocr_data', instance.ocrData);
  val['is_processed'] = instance.isProcessed;
  writeNotNull('processed_at', instance.processedAt?.toIso8601String());
  return val;
}

LabTrendAnalysis _$LabTrendAnalysisFromJson(Map<String, dynamic> json) =>
    LabTrendAnalysis(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      parameterName: json['parameter_name'] as String,
      parameterType:
          $enumDecode(_$LabParameterTypeEnumMap, json['parameter_type']),
      historicalResults: (json['historical_results'] as List<dynamic>)
          .map((e) => LabResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      trendDirection: json['trend_direction'] as String,
      trendSlope: (json['trend_slope'] as num?)?.toDouble(),
      trendAnalysis: json['trend_analysis'] as String?,
      recommendations: (json['recommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      analyzedAt: DateTime.parse(json['analyzed_at'] as String),
      nextReviewDate: DateTime.parse(json['next_review_date'] as String),
    );

Map<String, dynamic> _$LabTrendAnalysisToJson(LabTrendAnalysis instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user_id': instance.userId,
    'parameter_name': instance.parameterName,
    'parameter_type': _$LabParameterTypeEnumMap[instance.parameterType]!,
    'historical_results':
        instance.historicalResults.map((e) => e.toJson()).toList(),
    'trend_direction': instance.trendDirection,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('trend_slope', instance.trendSlope);
  writeNotNull('trend_analysis', instance.trendAnalysis);
  writeNotNull('recommendations', instance.recommendations);
  val['analyzed_at'] = instance.analyzedAt.toIso8601String();
  val['next_review_date'] = instance.nextReviewDate.toIso8601String();
  return val;
}
