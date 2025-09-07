import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../lib/core/database/database.dart';
import 'package:matcher/matcher.dart' as matcher;

/// Test utilities for database testing
class TestUtils {
  /// Create an in-memory test database
  static AppDatabase createTestDatabase() {
    return AppDatabase();
  }

  /// Create a test patient
  static PatientsCompanion createTestPatient({
    String firstName = 'Test',
    String lastName = 'Patient',
    String email = 'test@example.com',
    String? dateOfBirth,
    int ckdStage = 3,
  }) {
    return PatientsCompanion(
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      dateOfBirth: Value(dateOfBirth ?? '1990-01-01'),
      ckdStage: Value(ckdStage),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Create a test symptom log
  static SymptomLogsCompanion createTestSymptomLog(int patientId) {
    return SymptomLogsCompanion(
      patientId: Value(patientId),
      mood: Value(7),
      energyLevel: Value(6),
      appetiteLevel: Value(5),
      nausea: Value(3),
      swellingLevel: Value(2),
      breathlessness: Value(4),
      itching: Value(1),
      sleepQuality: Value(8),
      logDate: Value(DateTime.now()),
      createdAt: Value(DateTime.now()),
    );
  }

  /// Create a test lab test
  static LabTestsCompanion createTestLabTest({
    String testName = 'Creatinine',
    String category = 'Kidney Function',
    String unit = 'mg/dL',
  }) {
    return LabTestsCompanion(
      testName: Value(testName),
      category: Value(category),
      unit: Value(unit),
      normalRangeMin: Value(0.6),
      normalRangeMax: Value(1.3),
      createdAt: Value(DateTime.now()),
    );
  }

  /// Create a test lab result
  static LabResultsCompanion createTestLabResult(int patientId, int labTestId, {
    double result = 1.2,
  }) {
    return LabResultsCompanion(
      patientId: Value(patientId),
      labTestId: Value(labTestId),
      result: Value(result),
      testDate: Value(DateTime.now()),
      createdAt: Value(DateTime.now()),
    );
  }

  /// Create a test scheduled test
  static ScheduledTestsCompanion createTestScheduledTest(int patientId, int labTestId) {
    return ScheduledTestsCompanion(
      patientId: Value(patientId),
      labTestId: Value(labTestId),
      frequency: Value('Monthly'),
      nextDueDate: Value(DateTime.now().add(Duration(days: 30))),
      isActive: Value(true),
      reminderDaysBefore: Value(3),
      priority: Value('Medium'),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }
}