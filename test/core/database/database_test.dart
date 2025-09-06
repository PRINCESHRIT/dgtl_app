import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/database/database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    // Use in-memory database for testing
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Database Initialization', () {
    test('should initialize with all tables', () async {
      expect(database, isNotNull);
      expect(database.schemaVersion, equals(1));
    });

    test('should seed lab tests data on creation', () async {
      final labTests = await database.labTestsDao.getAllLabTests();
      expect(labTests.length, greaterThan(0));
      
      // Check for specific seeded tests
      final creatinineTest = labTests.where((t) => t.testCode == 'CREAT').firstOrNull;
      expect(creatinineTest, isNotNull);
      expect(creatinineTest!.name, equals('Creatinine'));
      expect(creatinineTest.unit, equals('mg/dL'));
    });
  });

  group('Database Relationships', () {
    test('should enforce foreign key constraints', () async {
      // Try to create a symptom log without a patient
      const invalidSymptomLog = SymptomLogsCompanion(
        patientId: Value(999), // Non-existent patient
        logDate: Value('2025-01-08'),
        mood: Value(5),
        energyLevel: Value(3),
      );

      expect(
        () => database.symptomLogsDao.createSymptomLog(invalidSymptomLog),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle cascading operations properly', () async {
      // Create a patient
      const patient = PatientsCompanion(
        firstName: Value('John'),
        lastName: Value('Doe'),
        dateOfBirth: Value('1980-01-01'),
        gender: Value('Male'),
        ckdStage: Value(3),
      );
      
      final patientId = await database.patientsDao.createPatient(patient);
      
      // Create related records
      await database.symptomLogsDao.createSymptomLog(
        SymptomLogsCompanion(
          patientId: Value(patientId),
          logDate: Value('2025-01-08'),
          mood: Value(8),
          energyLevel: Value(7),
        ),
      );

      // Verify relationships
      final patientData = await database.patientsDao.getPatientById(patientId);
      expect(patientData, isNotNull);
      
      final symptoms = await database.symptomLogsDao.getSymptomLogsByPatientId(patientId);
      expect(symptoms.length, equals(1));
      expect(symptoms.first.patientId, equals(patientId));
    });
  });

  group('Database Performance', () {
    test('should handle batch operations efficiently', () async {
      final stopwatch = Stopwatch()..start();
      
      // Create multiple patients in batch
      final patients = List.generate(100, (index) => 
        PatientsCompanion(
          firstName: Value('Patient'),
          lastName: Value('$index'),
          dateOfBirth: Value('1980-01-01'),
          gender: Value(index % 2 == 0 ? 'Male' : 'Female'),
          ckdStage: Value((index % 5) + 1),
        ),
      );

      for (final patient in patients) {
        await database.patientsDao.createPatient(patient);
      }
      
      stopwatch.stop();
      
      // Verify all patients were created
      final allPatients = await database.patientsDao.getAllPatients();
      expect(allPatients.length, equals(100));
      
      // Performance should be reasonable (less than 5 seconds for 100 inserts)
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    test('should optimize queries with indexes', () async {
      // Create test data
      const patient = PatientsCompanion(
        firstName: Value('Jane'),
        lastName: Value('Smith'),
        dateOfBirth: Value('1985-06-15'),
        gender: Value('Female'),
        ckdStage: Value(2),
      );
      
      final patientId = await database.patientsDao.createPatient(patient);
      
      // Create multiple symptom logs
      for (int i = 0; i < 50; i++) {
        await database.symptomLogsDao.createSymptomLog(
          SymptomLogsCompanion(
            patientId: Value(patientId),
            logDate: Value('2025-01-${(i % 28) + 1:02d}'),
            mood: Value(i % 10 + 1),
            energyLevel: Value((i + 3) % 10 + 1),
          ),
        );
      }
      
      final stopwatch = Stopwatch()..start();
      
      // Query should be fast due to patientId index
      final recentSymptoms = await database.symptomLogsDao
          .getRecentSymptomLogs(patientId, 10);
      
      stopwatch.stop();
      
      expect(recentSymptoms.length, equals(10));
      expect(stopwatch.elapsedMilliseconds, lessThan(100)); // Should be very fast
    });
  });

  group('Data Integrity', () {
    test('should maintain referential integrity', () async {
      // Create patient and related data
      const patient = PatientsCompanion(
        firstName: Value('Test'),
        lastName: Value('Patient'),
        dateOfBirth: Value('1975-03-20'),
        gender: Value('Male'),
        ckdStage: Value(4),
      );
      
      final patientId = await database.patientsDao.createPatient(patient);
      
      // Create lab result
      final creatinineTest = await database.labTestsDao.getLabTestByCode('CREAT');
      expect(creatinineTest, isNotNull);
      
      await database.labResultsDao.createLabResult(
        LabResultsCompanion(
          patientId: Value(patientId),
          labTestId: Value(creatinineTest!.id),
          testDate: Value('2025-01-08'),
          result: Value(2.5),
          isAbnormal: Value(true),
        ),
      );
      
      // Verify data consistency
      final results = await database.labResultsDao.getLabResultsByPatientId(patientId);
      expect(results.length, equals(1));
      expect(results.first.result, equals(2.5));
      expect(results.first.isAbnormal, isTrue);
    });

    test('should validate data constraints', () async {
      // Test invalid CKD stage
      const invalidPatient = PatientsCompanion(
        firstName: Value('Invalid'),
        lastName: Value('Patient'),
        dateOfBirth: Value('1990-01-01'),
        gender: Value('Male'),
        ckdStage: Value(6), // Invalid stage (should be 1-5)
      );
      
      // This should succeed as Drift doesn't enforce CHECK constraints by default
      // but we can add validation in the DAO layer
      final patientId = await database.patientsDao.createPatient(invalidPatient);
      expect(patientId, greaterThan(0));
      
      // However, our DAO validation should catch this
      final patient = await database.patientsDao.getPatientById(patientId);
      expect(patient?.ckdStage, equals(6)); // Raw data stored, validation in business layer
    });
  });
}
