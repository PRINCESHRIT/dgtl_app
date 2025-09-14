// DGTL Healthcare - Production Drift Tables
// Medical-grade local database schema with sync capabilities

import 'package:drift/drift.dart';

// Core vitals table for CKD "Big 7" biomarkers
class Vitals extends Table {
  // Primary identifiers
  TextColumn get id => text()(); // server UUID or client-generated
  TextColumn get clientId => text()(); // idempotency key
  TextColumn get patientId => text()();
  
  // Medical data
  TextColumn get type => text()(); // "creatinine", "egfr", "potassium", etc.
  RealColumn get value => real()(); // numeric value
  TextColumn get unit => text()(); // "mg/dL", "mL/min", "mEq/L"
  TextColumn get status => text().nullable()(); // "normal", "high", "low", "critical"
  TextColumn get notes => text().nullable()(); // clinical notes
  
  // Temporal tracking
  DateTimeColumn get recordedAt => dateTime()(); // when measurement taken
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  // Sync & versioning
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  TextColumn get deviceId => text().nullable()(); // tracking device source
  
  @override
  List<String> get customConstraints => [
    'UNIQUE(clientId)', // prevent duplicate operations
  ];
}

// Blood pressure readings (separate from general vitals)
class BPReadings extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text()();
  TextColumn get patientId => text()();
  
  // BP-specific data
  IntColumn get systolic => integer()();
  IntColumn get diastolic => integer()();
  IntColumn get heartRate => integer().nullable()();
  TextColumn get status => text()(); // "normal", "elevated", "high_stage1", "high_stage2", "crisis"
  
  // Contextual data
  TextColumn get position => text().nullable()(); // "sitting", "standing", "lying"
  TextColumn get arm => text().nullable()(); // "left", "right"
  RealColumn get fatigueLevel => real().nullable()(); // 1.0-5.0 scale
  TextColumn get symptoms => text().nullable()(); // JSON array of symptoms
  
  // Temporal & sync
  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
}

// Sync operation queue for offline support
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Operation metadata
  TextColumn get opType => text()(); // "create_vital", "update_bp", "delete_record"
  TextColumn get entityType => text()(); // "vital", "bp_reading", "patient"
  TextColumn get entityId => text()(); // ID of the record being synced
  TextColumn get clientId => text()(); // idempotency key
  
  // Payload & sync state
  TextColumn get payload => text()(); // JSON serialized data
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextAttemptAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))(); // "pending", "in_progress", "completed", "failed"
  
  // Timestamps
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// AI recommendations cache (for offline access)
class AIRecommendations extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  
  // AI content
  TextColumn get type => text()(); // "daily_tips", "expert_opinion", "meal_plan", "medication_alert"
  TextColumn get title => text()(); // Hindi title
  TextColumn get content => text()(); // Hindi content
  TextColumn get priority => text()(); // "low", "medium", "high", "critical"
  RealColumn get confidence => real()(); // AI confidence score 0.0-1.0
  
  // Context & triggers
  TextColumn get triggers => text().nullable()(); // JSON array of what triggered this recommendation
  TextColumn get relatedVitals => text().nullable()(); // JSON array of vital IDs
  DateTimeColumn get validUntil => dateTime().nullable()(); // recommendation expiry
  
  // Temporal & sync
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  BoolColumn get acknowledged => boolean().withDefault(const Constant(false))(); // user has seen it
  
  @override
  Set<Column> get primaryKey => {id};
}

// Patient medical profile (basic info for offline access)
class Patients extends Table {
  TextColumn get id => text()();
  
  // Basic demographics (PII - will be encrypted)
  TextColumn get name => text()();
  TextColumn get dateOfBirth => text()(); // encrypted
  TextColumn get gender => text().nullable()();
  
  // Medical profile
  TextColumn get ckdStage => text().nullable()(); // "1", "2", "3a", "3b", "4", "5"
  TextColumn get conditions => text().nullable()(); // JSON array of conditions
  TextColumn get medications => text().nullable()(); // JSON array of medications
  TextColumn get allergies => text().nullable()(); // JSON array
  
  // Care team
  TextColumn get primaryDoctor => text().nullable()();
  TextColumn get careTeam => text().nullable()(); // JSON array
  
  // Preferences
  TextColumn get language => text().withDefault(const Constant('hi'))(); // "hi", "en"
  TextColumn get timezone => text().withDefault(const Constant('Asia/Kolkata'))();
  
  // Sync & security
  DateTimeColumn get lastSync => dateTime().nullable()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get encryptionKey => text().nullable()(); // for PII fields
  
  // Temporal
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

// Clinical assessments (for CKD staging and progression tracking)
class ClinicalAssessments extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  
  // Assessment details
  TextColumn get assessmentType => text()(); // "ckd_staging", "medication_review", "risk_assessment"
  TextColumn get performedBy => text()(); // clinician or system ID
  DateTimeColumn get assessmentDate => dateTime()();
  
  // Results
  TextColumn get results => text()(); // JSON with assessment results
  TextColumn get recommendations => text()(); // JSON array of clinical recommendations
  TextColumn get severity => text()(); // "low", "medium", "high", "critical"
  RealColumn get confidenceScore => real().nullable()(); // AI confidence if applicable
  
  // Follow-up
  DateTimeColumn get nextReviewDate => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))(); // "active", "completed", "superseded"
  
  // Sync
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}
