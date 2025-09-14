// DGTL Healthcare - Production Database Schema
// Medical-grade tables with CKD biomarkers and sync support

import 'package:drift/drift.dart';

// Medical vitals tracking with CKD "Big 7" biomarkers
class Vitals extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Patient & timestamp info
  TextColumn get patientId => text()();
  DateTimeColumn get recordedAt => dateTime()();
  TextColumn get clientId => text()(); // For idempotency
  
  // CKD "Big 7" Biomarkers
  RealColumn get creatinine => real().nullable()(); // mg/dL
  RealColumn get eGFR => real().nullable()(); // mL/min/1.73m²
  RealColumn get hbA1c => real().nullable()(); // %
  RealColumn get albumin => real().nullable()(); // g/dL
  RealColumn get hemoglobin => real().nullable()(); // g/dL
  RealColumn get phosphorus => real().nullable()(); // mg/dL
  RealColumn get parathyroidHormone => real().nullable()(); // pg/mL
  
  // Additional vital signs
  RealColumn get weight => real().nullable()(); // kg
  RealColumn get height => real().nullable()(); // cm
  RealColumn get temperature => real().nullable()(); // Celsius
  RealColumn get glucoseLevel => real().nullable()(); // mg/dL
  
  // Sync & versioning
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  TextColumn get deviceId => text().nullable()(); // tracking device source
  
  @override
  List<String> get customConstraints => [
    'UNIQUE(clientId)', // prevent duplicate operations
  ];
}

// Blood pressure readings with trend analysis
class BPReadings extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Basic BP data
  TextColumn get patientId => text()();
  RealColumn get systolic => real()();
  RealColumn get diastolic => real()();
  RealColumn get heartRate => real().nullable()();
  DateTimeColumn get recordedAt => dateTime()();
  TextColumn get clientId => text()();
  
  // Context & analysis
  TextColumn get measurementConditions => text().nullable()(); // "resting", "after_exercise", "stressed"
  TextColumn get position => text().nullable()(); // "sitting", "standing", "lying"
  TextColumn get armUsed => text().nullable()(); // "left", "right"
  
  // Medical status & advice
  TextColumn get bpCategory => text().nullable()(); // "normal", "elevated", "high_stage_1", "high_stage_2", "crisis"
  TextColumn get hindiAdvice => text().nullable()(); // Localized advice
  BoolColumn get requiresAttention => boolean().withDefault(const Constant(false))();
  
  // Metadata
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
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
  BoolColumn get requiresManualResolution => boolean().withDefault(const Constant(false))();
  
  // Audit trail
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
}

// AI-powered recommendations for medical care
class AIRecommendations extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Core recommendation data
  TextColumn get patientId => text()();
  TextColumn get recommendationType => text()(); // "medication", "lifestyle", "followup", "urgent_care"
  TextColumn get title => text()(); // Hindi title
  TextColumn get description => text()(); // Detailed Hindi description
  TextColumn get englishTitle => text().nullable()();
  TextColumn get englishDescription => text().nullable()();
  
  // Priority & status
  IntColumn get priority => integer()(); // 1=urgent, 2=high, 3=medium, 4=low
  TextColumn get status => text().withDefault(const Constant('pending'))(); // "pending", "acknowledged", "completed", "dismissed"
  RealColumn get confidence => real()(); // AI confidence score 0.0-1.0
  
  // Context & references
  TextColumn get basedOnVitalIds => text().nullable()(); // JSON array of vital record IDs
  TextColumn get basedOnBPIds => text().nullable()(); // JSON array of BP record IDs
  TextColumn get medicalReferences => text().nullable()(); // JSON array of medical sources
  
  // Medical professional review
  TextColumn get reviewedBy => text().nullable()(); // Doctor/nurse ID who reviewed
  DateTimeColumn get reviewedAt => dateTime().nullable()();
  TextColumn get reviewNotes => text().nullable()();
  
  // Timestamps
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expiresAt => dateTime().nullable()(); // recommendations can expire
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
}

// Patient profiles with medical history
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Basic patient info
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get email => text().nullable()();
  
  // Medical profile
  TextColumn get medicalHistory => text().nullable()(); // JSON array of conditions
  TextColumn get currentMedications => text().nullable()(); // JSON array of medications
  TextColumn get allergies => text().nullable()(); // JSON array of allergies
  TextColumn get emergencyContactName => text().nullable()();
  TextColumn get emergencyContactPhone => text().nullable()();
  
  // CKD specific tracking
  IntColumn get ckdStage => integer().nullable()(); // 1-5, null if no CKD
  RealColumn get baselineCreatinine => real().nullable()();
  RealColumn get baselineEGFR => real().nullable()();
  DateTimeColumn get ckdDiagnosisDate => dateTime().nullable()();
  
  // Preferences
  TextColumn get preferredLanguage => text().withDefault(const Constant('hi-IN'))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get timeZone => text().withDefault(const Constant('Asia/Kolkata'))();
  
  // Security & audit
  TextColumn get encryptionKeyId => text().nullable()(); // For HIPAA compliance
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
}

// Clinical assessments and notes
class ClinicalAssessments extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Assessment metadata
  TextColumn get patientId => text()();
  TextColumn get assessmentType => text()(); // "routine", "followup", "urgent", "annual"
  DateTimeColumn get assessmentDate => dateTime()();
  TextColumn get clinicianId => text().nullable()();
  TextColumn get clinicianName => text().nullable()();
  
  // Assessment content
  TextColumn get chiefComplaint => text().nullable()();
  TextColumn get historyOfPresentIllness => text().nullable()();
  TextColumn get physicalExamFindings => text().nullable()();
  TextColumn get assessmentAndPlan => text().nullable()();
  
  // Follow-up planning
  DateTimeColumn get nextAppointmentDate => dateTime().nullable()();
  TextColumn get followUpInstructions => text().nullable()();
  TextColumn get medicationChanges => text().nullable()(); // JSON of medication updates
  
  // Hindi translations for patient communication
  TextColumn get hindiChiefComplaint => text().nullable()();
  TextColumn get hindiAssessment => text().nullable()();
  TextColumn get hindiInstructions => text().nullable()();
  
  // Status tracking
  TextColumn get status => text().withDefault(const Constant('draft'))(); // "draft", "completed", "reviewed", "archived"
  BoolColumn get patientNotified => boolean().withDefault(const Constant(false))();
  
  // Audit trail
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
}

// Database implementation with all tables
@DriftDatabase(tables: [
  Vitals,
  BPReadings,
  SyncQueue,
  AIRecommendations,
  Patients,
  ClinicalAssessments,
])
class HealthcareDatabase extends _$HealthcareDatabase {
  HealthcareDatabase() : super(_openConnection());
  
  @override
  int get schemaVersion => 1;
  
  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'healthcare_database.sqlite'));
      
      return NativeDatabase(file, logStatements: true);
    });
  }
}
