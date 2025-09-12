// lib/core/database/database.dart
import 'package:drift/drift.dart';
// Conditional connection import provides openConnection()
import 'connection/connection_web.dart'
  if (dart.library.io) 'connection/connection_io.dart';

part 'database.g.dart';

// =============================================================================
// TABLE DEFINITIONS - Simple Single-User Schema
// =============================================================================

// Patients Table - Core patient information
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Lab Tests Table - Available test types
class LabTests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get testName => text()(); // e.g., "Creatinine", "eGFR"
  TextColumn get category => text()(); // e.g., "Kidney", "Liver", "Blood"
  TextColumn get unit => text().nullable()(); // e.g., "mg/dL", "mL/min"
  TextColumn get normalRange => text().nullable()(); // e.g., "0.6-1.2"
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Lab Results Table - Actual test results for patients
class LabResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  IntColumn get labTestId => integer().references(LabTests, #id)();
  RealColumn get value => real()(); // The numeric result
  TextColumn get status => text().nullable()(); // "Normal", "High", "Low", "Critical"
  DateTimeColumn get testDate => dateTime()(); // When the test was performed
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Symptom Logs Table - Patient-reported symptoms
class SymptomLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  TextColumn get symptom => text()(); // e.g., "Fatigue", "Nausea", "Pain"
  IntColumn get severity => integer()(); // 1-10 scale
  TextColumn get description => text().nullable()();
  DateTimeColumn get logDate => dateTime()(); // When symptom was experienced
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Daily Health Logs - Structured daily vitals and well-being
class DailyHealthLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  DateTimeColumn get loggedAt => dateTime()();
  IntColumn get systolic => integer().nullable()();
  IntColumn get diastolic => integer().nullable()();
  IntColumn get energyMood => integer().nullable()(); // 1-3
  IntColumn get fatigue => integer().nullable()();     // 1-3
  IntColumn get pain => integer().nullable()();        // 1-3
  IntColumn get sleepQuality => integer().nullable()(); // 1-3
  IntColumn get fluidIntake => integer().nullable()(); // ml
  IntColumn get fluidOutput => integer().nullable()(); // ml
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// =============================================================================
// DATABASE CLASS - Single User Implementation
// =============================================================================

@DriftDatabase(tables: [Patients, LabTests, LabResults, SymptomLogs, DailyHealthLogs])
class AppDatabase extends _$AppDatabase {
  // Production constructor - uses platform-specific connection
  AppDatabase() : super(openConnection());
  
  // Test constructor - uses same connection (web-safe)
  AppDatabase.memory() : super(openConnection());
  
  // Explicit constructor for custom connections
  AppDatabase.custom(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(dailyHealthLogs);
          }
        },
      );

  // =============================================================================
  // SIMPLE QUERY METHODS - No complex DAOs needed for single user
  // =============================================================================

  // Patient methods
  Future<List<Patient>> getAllPatients() => select(patients).get();
  
  Future<Patient?> getPatientById(int id) => 
    (select(patients)..where((p) => p.id.equals(id))).getSingleOrNull();
  
  Future<List<Patient>> searchPatients(String searchTerm) {
    final query = select(patients)..where((p) => 
      p.firstName.contains(searchTerm) | p.lastName.contains(searchTerm));
    return query.get();
  }

  Future<int> insertPatient(PatientsCompanion patient) => 
    into(patients).insert(patient);

  Future<bool> updatePatient(PatientsCompanion patient) => 
    update(patients).replace(patient);

  Future<int> deletePatient(int id) => 
    (delete(patients)..where((p) => p.id.equals(id))).go();

  // Lab Test methods
  Future<List<LabTest>> getAllLabTests() => select(labTests).get();
  
  Future<List<LabTest>> getLabTestsByCategory(String category) {
    final query = select(labTests)..where((t) => t.category.equals(category));
    return query.get();
  }

  Future<int> insertLabTest(LabTestsCompanion labTest) => 
    into(labTests).insert(labTest);

  // Lab Result methods
  Future<List<LabResult>> getLabResultsForPatient(int patientId) {
    final query = select(labResults)..where((r) => r.patientId.equals(patientId));
    return query.get();
  }

  Future<List<LabResult>> getRecentLabResults(int patientId, {int days = 30}) {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final query = select(labResults)..where((r) => 
      r.patientId.equals(patientId) & r.testDate.isBiggerOrEqualValue(cutoffDate));
    return query.get();
  }

  Future<int> insertLabResult(LabResultsCompanion result) => 
    into(labResults).insert(result);

  // Symptom methods
  Future<List<SymptomLog>> getSymptomsForPatient(int patientId) {
    final query = select(symptomLogs)..where((s) => s.patientId.equals(patientId));
    return query.get();
  }

  Future<List<SymptomLog>> getRecentSymptoms(int patientId, {int days = 7}) {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final query = select(symptomLogs)..where((s) => 
      s.patientId.equals(patientId) & s.logDate.isBiggerOrEqualValue(cutoffDate));
    return query.get();
  }

  Future<int> insertSymptomLog(SymptomLogsCompanion symptom) => 
    into(symptomLogs).insert(symptom);

  // Daily Health Log methods
  Future<int> insertDailyHealthLog(DailyHealthLogsCompanion log) =>
      into(dailyHealthLogs).insert(log);

  Future<List<DailyHealthLog>> getDailyLogsForRange(
      int patientId, DateTime from, DateTime to) {
    final q = select(dailyHealthLogs)
      ..where((t) =>
          t.patientId.equals(patientId) &
          t.loggedAt.isBiggerOrEqualValue(from) &
          t.loggedAt.isSmallerOrEqualValue(to))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]);
    return q.get();
  }

  Future<List<DailyHealthLog>> getRecentDailyLogs(int patientId,
      {int days = 7}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final q = select(dailyHealthLogs)
      ..where((t) =>
          t.patientId.equals(patientId) &
          t.loggedAt.isBiggerOrEqualValue(cutoff))
      ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]);
    return q.get();
  }

  // =============================================================================
  // JOINED QUERIES - Get related data in one go
  // =============================================================================

  // Get lab results with test details
  Future<List<LabResultWithTest>> getLabResultsWithTests(int patientId) {
    final query = select(labResults).join([
      leftOuterJoin(labTests, labTests.id.equalsExp(labResults.labTestId)),
    ])..where(labResults.patientId.equals(patientId));

    return query.map((row) {
      return LabResultWithTest(
        result: row.readTable(labResults),
        test: row.readTable(labTests),
      );
    }).get();
  }
}

// =============================================================================
// HELPER CLASSES
// =============================================================================

class LabResultWithTest {
  final LabResult result;
  final LabTest? test;
  
  LabResultWithTest({required this.result, this.test});
}

// Connection creation handled in connection/*.dart via conditional imports
