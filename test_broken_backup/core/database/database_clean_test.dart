import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../../../lib/core/database/database.dart';
import '../../test_utils.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  late AppDatabase database;

  setUp(() async {
    database = TestUtils.createTestDatabase();
  });

  tearDown(() async {
    await database.close();
  });

  group('Database Tests', () {
    test('should create all tables', () {
      expect(database, matcher.isNotNull);
      expect(database.allTables.length, equals(7));
    });

    test('should create and retrieve patient', () async {
      final patient = TestUtils.createTestPatient(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
      );

      final patientId = await database.patientsDao.createPatient(patient);
      expect(patientId, isA<int>());

      final retrievedPatient = await database.patientsDao.getPatientById(patientId);
      expect(retrievedPatient, matcher.isNotNull);
      expect(retrievedPatient!.firstName, equals('John'));
      expect(retrievedPatient.lastName, equals('Doe'));
    });

    test('should create and retrieve symptom log', () async {
      // Create patient first
      final patient = TestUtils.createTestPatient();
      final patientId = await database.patientsDao.createPatient(patient);

      // Create symptom log
      final symptomLog = TestUtils.createTestSymptomLog(patientId);
      final logId = await database.symptomLogsDao.createSymptomLog(symptomLog);
      expect(logId, isA<int>());

      // Retrieve symptom logs
      final logs = await database.symptomLogsDao.getRecentLogs(patientId);
      expect(logs.length, equals(1));
      expect(logs.first.patientId, equals(patientId));
    });

    test('should create and retrieve lab test', () async {
      final labTest = TestUtils.createTestLabTest(
        testName: 'Creatinine',
        category: 'Kidney Function',
      );

      final testId = await database.labTestsDao.createLabTest(labTest);
      expect(testId, isA<int>());

      final retrievedTest = await (await database.labTestsDao.getAllLabTests()).where((t) => t.id == testId).firstOrNull;
      expect(retrievedTest, matcher.isNotNull);
      expect(retrievedTest!.testName, equals('Creatinine'));
    });

    test('should create and retrieve lab result', () async {
      // Create patient and lab test first
      final patient = TestUtils.createTestPatient();
      final patientId = await database.patientsDao.createPatient(patient);
      
      final labTest = TestUtils.createTestLabTest();
      final testId = await database.labTestsDao.createLabTest(labTest);

      // Create lab result
      final labResult = TestUtils.createTestLabResult(patientId, testId, result: 1.5);
      final resultId = await database.labResultsDao.createLabResult(labResult);
      expect(resultId, isA<int>());

      // Retrieve lab results
      final results = await database.labResultsDao.getRecentResults(patientId);
      expect(results.length, equals(1));
      expect(results.first.result, equals(1.5));
    });
  });
}
