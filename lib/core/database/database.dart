// lib/core/database/database.dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

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

// =============================================================================
// DATABASE CLASS - Single User Implementation
// =============================================================================

@DriftDatabase(tables: [Patients, LabTests, LabResults, SymptomLogs])
class AppDatabase extends _$AppDatabase {
  // Production constructor - saves to device storage
  AppDatabase() : super(_openConnection());
  
  // Test constructor - uses in-memory database
  AppDatabase.memory() : super(NativeDatabase.memory());
  
  // Explicit constructor for custom connections
  AppDatabase.custom(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 1;

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

// =============================================================================
// DATABASE CONNECTION HELPER
// =============================================================================

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'health_tracker.db'));
    return NativeDatabase(file);
  });
}
