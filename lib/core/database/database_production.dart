import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
// Conditional connection import
import 'connection/connection_web.dart'
  if (dart.library.io) 'connection/connection_io.dart' as conn;
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// Import vitals tables for integration
import 'vitals_tables.dart';

part 'database_production.g.dart';

// =============================================================================
// RAG-ENABLED TABLES WITH EMBEDDING STORAGE
// =============================================================================

// Medical Knowledge Base with Embeddings
class MedicalKnowledgeBase extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()(); // Medical text content
  TextColumn get source => text()(); // Source document/guideline
  TextColumn get category => text()(); // "nephrology", "medication", "symptom"
  TextColumn get embedding => text()(); // JSON-encoded embedding vector
  RealColumn get confidence => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Patient Data with Privacy Encryption
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get encryptedFirstName => text()(); // AES-256 encrypted
  TextColumn get encryptedLastName => text()(); // AES-256 encrypted
  TextColumn get encryptedDateOfBirth => text().nullable()(); // AES-256 encrypted
  TextColumn get gender => text().nullable()();
  TextColumn get encryptedNotes => text().nullable()(); // AES-256 encrypted
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Clinical Assessments with RAG Context
class ClinicalAssessments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  TextColumn get assessmentType => text()(); // "ckd_stage", "medication_review"
  TextColumn get ragContext => text()(); // Retrieved knowledge context
  TextColumn get aiRecommendations => text()(); // Generated recommendations
  TextColumn get clinicalFindings => text()(); // Assessment results
  RealColumn get confidenceScore => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Lab Results with Trend Analysis
class LabResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  TextColumn get testName => text()(); // "creatinine", "egfr", "albumin"
  RealColumn get value => real()();
  TextColumn get unit => text()(); // "mg/dL", "mL/min/1.73m²"
  RealColumn get referenceMin => real().nullable()();
  RealColumn get referenceMax => real().nullable()();
  TextColumn get interpretation => text().nullable()(); // "normal", "elevated"
  DateTimeColumn get testDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Symptoms with NLP Processing
class Symptoms extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  TextColumn get symptomText => text()(); // Natural language description
  TextColumn get processedSymptoms => text()(); // NLP-extracted symptoms JSON
  TextColumn get severity => text()(); // "mild", "moderate", "severe"
  TextColumn get embedding => text().nullable()(); // Symptom embedding
  DateTimeColumn get reportedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Medication Management with Safety Alerts
class Medications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  TextColumn get medicationName => text()();
  TextColumn get dosage => text()();
  TextColumn get frequency => text()();
  TextColumn get safetyAlerts => text().nullable()(); // JSON safety warnings
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// RAG Query Cache for Performance
class RagQueryCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get queryHash => text().unique()(); // SHA-256 of query
  TextColumn get query => text()();
  TextColumn get retrievedContext => text()(); // Cached RAG context
  TextColumn get generatedResponse => text()(); // Cached AI response
  RealColumn get relevanceScore => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expiresAt => dateTime()();
}

@DriftDatabase(tables: [
  // RAG-enabled medical knowledge tables
  MedicalKnowledgeBase,
  Patients,
  ClinicalAssessments,
  LabResults,
  Symptoms,
  Medications,
  RagQueryCache,
  // Vitals monitoring tables for CKD management
  Vitals,
  BPReadings,
  SyncQueue,
  AIRecommendations,
])
class DgtlDatabase extends _$DgtlDatabase {
  DgtlDatabase() : super(conn.openConnection());
  // Special constructor for command-line scripts
  DgtlDatabase.forScript() : super(NativeDatabase(File('dgtl_app.db')));

  @override
  int get schemaVersion => 1;

  // Connection is provided by conditional import; encryption is a no-op on web.

  // =============================================================================
  // RAG-SPECIFIC DATABASE OPERATIONS
  // =============================================================================
  
  Future<List<MedicalKnowledgeBaseData>> searchSimilarKnowledge(
    String queryEmbedding, 
    String category,
    {int limit = 5}
  ) async {
    return await (select(medicalKnowledgeBase)
          ..where((kb) => kb.category.equals(category))
          ..limit(limit))
        .get();
  }
  
  Future<int> insertMedicalKnowledge({
    required String content,
    required String source,
    required String category,
    required String embedding,
    double confidence = 0.0,
  }) async {
    return await into(medicalKnowledgeBase).insert(
      MedicalKnowledgeBaseCompanion.insert(
        content: content,
        source: source,
        category: category,
        embedding: embedding,
        confidence: Value(confidence),
      ),
    );
  }
  
  Future<List<RagQueryCacheData>> getCachedQuery(String queryHash) async {
    return await (select(ragQueryCache)
          ..where((cache) => cache.queryHash.equals(queryHash))
          ..where((cache) => cache.expiresAt.isBiggerThanValue(DateTime.now()))
          ..limit(1))
        .get();
  }
  
  Future<int> cacheRagQuery({
    required String queryHash,
    required String query,
    required String retrievedContext,
    required String generatedResponse,
    required double relevanceScore,
    Duration cacheDuration = const Duration(hours: 24),
  }) async {
    return await into(ragQueryCache).insert(
      RagQueryCacheCompanion.insert(
        queryHash: queryHash,
        query: query,
        retrievedContext: retrievedContext,
        generatedResponse: generatedResponse,
        relevanceScore: relevanceScore,
        expiresAt: DateTime.now().add(cacheDuration),
      ),
    );
  }
  
  // =============================================================================
  // CLINICAL ASSESSMENT OPERATIONS
  // =============================================================================
  
  Future<int> createClinicalAssessment({
    required int patientId,
    required String assessmentType,
    required String ragContext,
    required String aiRecommendations,
    required String clinicalFindings,
    required double confidenceScore,
  }) async {
    return await into(clinicalAssessments).insert(
      ClinicalAssessmentsCompanion.insert(
        patientId: patientId,
        assessmentType: assessmentType,
        ragContext: ragContext,
        aiRecommendations: aiRecommendations,
        clinicalFindings: clinicalFindings,
        confidenceScore: confidenceScore,
      ),
    );
  }
  
  Future<List<ClinicalAssessmentsData>> getPatientAssessments(int patientId) async {
    return await (select(clinicalAssessments)
          ..where((a) => a.patientId.equals(patientId))
          ..orderBy([(a) => OrderingTerm.desc(a.createdAt)]))
        .get();
  }
}
