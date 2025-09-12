// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponse _$AIResponseFromJson(Map<String, dynamic> json) => AIResponse(
      id: json['id'] as String,
      response: json['response'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      followUpQuestions: (json['follow_up_questions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      resources:
          (json['resources'] as List<dynamic>).map((e) => e as String).toList(),
      language: json['language'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$AIResponseToJson(AIResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'response': instance.response,
      'confidence': instance.confidence,
      'follow_up_questions': instance.followUpQuestions,
      'resources': instance.resources,
      'language': instance.language,
      'timestamp': instance.timestamp.toIso8601String(),
    };

AIRecommendation _$AIRecommendationFromJson(Map<String, dynamic> json) =>
    AIRecommendation(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      priority: json['priority'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isCompleted: json['is_completed'] as bool,
      actionUrl: json['action_url'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AIRecommendationToJson(AIRecommendation instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
    'description': instance.description,
    'category': instance.category,
    'priority': instance.priority,
    'timestamp': instance.timestamp.toIso8601String(),
    'is_completed': instance.isCompleted,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('action_url', instance.actionUrl);
  writeNotNull('metadata', instance.metadata);
  return val;
}

AIChatRequest _$AIChatRequestFromJson(Map<String, dynamic> json) =>
    AIChatRequest(
      userId: json['user_id'] as String,
      question: json['question'] as String,
      includeHealthContext: json['include_health_context'] as bool,
      language: json['language'] as String,
      context:
          (json['context'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AIChatRequestToJson(AIChatRequest instance) {
  final val = <String, dynamic>{
    'user_id': instance.userId,
    'question': instance.question,
    'include_health_context': instance.includeHealthContext,
    'language': instance.language,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('context', instance.context);
  return val;
}

AIRecommendationRequest _$AIRecommendationRequestFromJson(
        Map<String, dynamic> json) =>
    AIRecommendationRequest(
      userId: json['user_id'] as String,
      includeHealthHistory: json['include_health_history'] as bool,
      recommendationTypes: (json['recommendation_types'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      maxRecommendations: (json['max_recommendations'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AIRecommendationRequestToJson(
    AIRecommendationRequest instance) {
  final val = <String, dynamic>{
    'user_id': instance.userId,
    'include_health_history': instance.includeHealthHistory,
    'recommendation_types': instance.recommendationTypes,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('max_recommendations', instance.maxRecommendations);
  return val;
}

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      errorCode: json['error_code'] as String?,
    );

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{
    'success': instance.success,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('data', _$nullableGenericToJson(instance.data, toJsonT));
  writeNotNull('error_code', instance.errorCode);
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

AIChatMessage _$AIChatMessageFromJson(Map<String, dynamic> json) =>
    AIChatMessage(
      id: json['id'] as String,
      content: json['content'] as String,
      role: json['role'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as String?,
    );

Map<String, dynamic> _$AIChatMessageToJson(AIChatMessage instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'content': instance.content,
    'role': instance.role,
    'timestamp': instance.timestamp.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata);
  return val;
}

AIChatRequest _$AIChatRequestFromJson(Map<String, dynamic> json) =>
    AIChatRequest(
      userId: json['user_id'] as String,
      message: json['message'] as String,
      conversationHistory: (json['conversation_history'] as List<dynamic>?)
          ?.map((e) => AIChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      context: json['context'] as Map<String, dynamic>?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$AIChatRequestToJson(AIChatRequest instance) {
  final val = <String, dynamic>{
    'user_id': instance.userId,
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('conversation_history',
      instance.conversationHistory?.map((e) => e.toJson()).toList());
  writeNotNull('context', instance.context);
  val['timestamp'] = instance.timestamp.toIso8601String();
  return val;
}

AIChatResponse _$AIChatResponseFromJson(Map<String, dynamic> json) =>
    AIChatResponse(
      success: json['success'] as bool,
      response:
          AIChatMessage.fromJson(json['response'] as Map<String, dynamic>),
      suggestedActions: (json['suggested_actions'] as List<dynamic>?)
          ?.map((e) => AIRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      conversationId: json['conversation_id'] as String?,
      respondedAt: DateTime.parse(json['responded_at'] as String),
    );

Map<String, dynamic> _$AIChatResponseToJson(AIChatResponse instance) {
  final val = <String, dynamic>{
    'success': instance.success,
    'response': instance.response.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('suggested_actions',
      instance.suggestedActions?.map((e) => e.toJson()).toList());
  writeNotNull('conversation_id', instance.conversationId);
  val['responded_at'] = instance.respondedAt.toIso8601String();
  return val;
}

Medication _$MedicationFromJson(Map<String, dynamic> json) => Medication(
      id: json['id'] as String,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      instructions: json['instructions'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$MedicationToJson(Medication instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'dosage': instance.dosage,
    'frequency': instance.frequency,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('instructions', instance.instructions);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  val['is_active'] = instance.isActive;
  return val;
}

MedicationRequest _$MedicationRequestFromJson(Map<String, dynamic> json) =>
    MedicationRequest(
      userId: json['user_id'] as String,
      currentMedications: (json['current_medications'] as List<dynamic>)
          .map((e) => Medication.fromJson(e as Map<String, dynamic>))
          .toList(),
      newMedicationQuery: json['new_medication_query'] as String?,
      symptomsDescription: json['symptoms_description'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$MedicationRequestToJson(MedicationRequest instance) {
  final val = <String, dynamic>{
    'user_id': instance.userId,
    'current_medications':
        instance.currentMedications.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('new_medication_query', instance.newMedicationQuery);
  writeNotNull('symptoms_description', instance.symptomsDescription);
  val['timestamp'] = instance.timestamp.toIso8601String();
  return val;
}

MedicationAdviceResponse _$MedicationAdviceResponseFromJson(
        Map<String, dynamic> json) =>
    MedicationAdviceResponse(
      success: json['success'] as bool,
      advice: json['advice'] as String,
      warnings:
          (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
      interactions: (json['interactions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => AIRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      requiresDoctorConsultation: json['requires_doctor_consultation'] as bool,
      generatedAt: DateTime.parse(json['generated_at'] as String),
    );

Map<String, dynamic> _$MedicationAdviceResponseToJson(
        MedicationAdviceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'advice': instance.advice,
      'warnings': instance.warnings,
      'interactions': instance.interactions,
      'recommendations':
          instance.recommendations.map((e) => e.toJson()).toList(),
      'requires_doctor_consultation': instance.requiresDoctorConsultation,
      'generated_at': instance.generatedAt.toIso8601String(),
    };
