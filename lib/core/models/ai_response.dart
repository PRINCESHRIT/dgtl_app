import 'package:json_annotation/json_annotation.dart';

part 'ai_response.g.dart';

/// AI Response Model for recommendations and analysis
@JsonSerializable()
class AIResponse {
  final String id;
  final String response;
  final double confidence;
  final List<String> followUpQuestions;
  final List<String> resources;
  final String language;
  final DateTime timestamp;

  const AIResponse({
    required this.id,
    required this.response,
    required this.confidence,
    required this.followUpQuestions,
    required this.resources,
    required this.language,
    required this.timestamp,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) =>
      _$AIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AIResponseToJson(this);
}

/// AI Recommendation Model
@JsonSerializable()
class AIRecommendation {
  final String id;
  final String title;
  final String description;
  final String category; // 'lifestyle', 'medication', 'monitoring', 'exercise'
  final String priority; // 'high', 'medium', 'low'
  final DateTime timestamp;
  final bool isCompleted;
  final String? actionUrl;
  final Map<String, dynamic>? metadata;

  const AIRecommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.timestamp,
    required this.isCompleted,
    this.actionUrl,
    this.metadata,
  });

  factory AIRecommendation.fromJson(Map<String, dynamic> json) =>
      _$AIRecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$AIRecommendationToJson(this);

  AIRecommendation copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? priority,
    DateTime? timestamp,
    bool? isCompleted,
    String? actionUrl,
    Map<String, dynamic>? metadata,
  }) {
    return AIRecommendation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      timestamp: timestamp ?? this.timestamp,
      isCompleted: isCompleted ?? this.isCompleted,
      actionUrl: actionUrl ?? this.actionUrl,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// AI Chat Request Model
@JsonSerializable()
class AIChatRequest {
  final String userId;
  final String question;
  final bool includeHealthContext;
  final String language;
  final List<String>? context;

  const AIChatRequest({
    required this.userId,
    required this.question,
    required this.includeHealthContext,
    required this.language,
    this.context,
  });

  factory AIChatRequest.fromJson(Map<String, dynamic> json) =>
      _$AIChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AIChatRequestToJson(this);
}

/// AI Recommendation Request Model
@JsonSerializable()
class AIRecommendationRequest {
  final String userId;
  final bool includeHealthHistory;
  final List<String> recommendationTypes;
  final int? maxRecommendations;

  const AIRecommendationRequest({
    required this.userId,
    required this.includeHealthHistory,
    required this.recommendationTypes,
    this.maxRecommendations,
  });

  factory AIRecommendationRequest.fromJson(Map<String, dynamic> json) =>
      _$AIRecommendationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AIRecommendationRequestToJson(this);
}

/// API Response wrapper for AI services
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final String? errorCode;

  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.errorCode,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}

/// AI Chat Message Model
@JsonSerializable()
class AIChatMessage {
  final String id;
  final String content;
  final String role; // 'user' or 'assistant'
  final DateTime timestamp;
  final String? metadata;

  const AIChatMessage({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
    this.metadata,
  });

  factory AIChatMessage.fromJson(Map<String, dynamic> json) =>
      _$AIChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$AIChatMessageToJson(this);

  bool get isFromUser => role == 'user';
  bool get isFromAI => role == 'assistant';
}

/// AI Chat Request Model
@JsonSerializable()
class AIChatRequest {
  final String userId;
  final String message;
  final List<AIChatMessage>? conversationHistory;
  final Map<String, dynamic>? context; // Health data context
  final DateTime timestamp;

  const AIChatRequest({
    required this.userId,
    required this.message,
    this.conversationHistory,
    this.context,
    required this.timestamp,
  });

  factory AIChatRequest.fromJson(Map<String, dynamic> json) =>
      _$AIChatRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AIChatRequestToJson(this);
}

/// AI Chat Response Model
@JsonSerializable()
class AIChatResponse {
  final bool success;
  final AIChatMessage response;
  final List<AIRecommendation>? suggestedActions;
  final String? conversationId;
  final DateTime respondedAt;

  const AIChatResponse({
    required this.success,
    required this.response,
    this.suggestedActions,
    this.conversationId,
    required this.respondedAt,
  });

  factory AIChatResponse.fromJson(Map<String, dynamic> json) =>
      _$AIChatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AIChatResponseToJson(this);
}

/// Medication Model
@JsonSerializable()
class Medication {
  final String id;
  final String name;
  final String dosage;
  final String frequency;
  final String? instructions;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;

  const Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    this.instructions,
    this.startDate,
    this.endDate,
    required this.isActive,
  });

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);
  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}

/// Medication Request Model
@JsonSerializable()
class MedicationRequest {
  final String userId;
  final List<Medication> currentMedications;
  final String? newMedicationQuery;
  final String? symptomsDescription;
  final DateTime timestamp;

  const MedicationRequest({
    required this.userId,
    required this.currentMedications,
    this.newMedicationQuery,
    this.symptomsDescription,
    required this.timestamp,
  });

  factory MedicationRequest.fromJson(Map<String, dynamic> json) =>
      _$MedicationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MedicationRequestToJson(this);
}

/// Medication Advice Response
@JsonSerializable()
class MedicationAdviceResponse {
  final bool success;
  final String advice;
  final List<String> warnings;
  final List<String> interactions;
  final List<AIRecommendation> recommendations;
  final bool requiresDoctorConsultation;
  final DateTime generatedAt;

  const MedicationAdviceResponse({
    required this.success,
    required this.advice,
    required this.warnings,
    required this.interactions,
    required this.recommendations,
    required this.requiresDoctorConsultation,
    required this.generatedAt,
  });

  factory MedicationAdviceResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicationAdviceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MedicationAdviceResponseToJson(this);
}
