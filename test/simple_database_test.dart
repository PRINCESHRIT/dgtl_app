// test/simple_database_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:dgtl_app/core/database/database.dart';

void main() {
  group('Simple Single-User Database Tests', () {
    late AppDatabase database;

    setUp(() {
      database = AppDatabase.memory();
    });

    tearDown(() async {
      await database.close();
    });

    test('database initializes and all tables are accessible', () async {
      // Verify all tables can be queried
      expect(await database.patients.count().getSingle(), 0);
      expect(await database.labTests.count().getSingle(), 0);
      expect(await database.labResults.count().getSingle(), 0);
      expect(await database.symptomLogs.count().getSingle(), 0);
      
      print('✅ All 4 tables accessible and empty');
    });

    test('complete patient workflow', () async {
      // 1. Create a patient
      final patientId = await database.insertPatient(
        PatientsCompanion.insert(
          firstName: 'John',
          lastName: 'Doe',
          dateOfBirth: Value(DateTime(1980, 1, 15)),
          gender: Value('Male'),
        )
      );
      
      expect(patientId, greaterThan(0));
      
      // 2. Retrieve the patient
      final patient = await database.getPatientById(patientId);
      expect(patient, isNotNull);
      expect(patient!.firstName, 'John');
      expect(patient.lastName, 'Doe');
      
      // 3. Search for the patient
      final searchResults = await database.searchPatients('John');
      expect(searchResults.length, 1);
      expect(searchResults.first.id, patientId);
      
      print('✅ Patient CRUD operations working');
    });

    test('lab tests and results workflow', () async {
      // 1. Create a patient first
      final patientId = await database.insertPatient(
        PatientsCompanion.insert(
          firstName: 'Jane',
          lastName: 'Smith',
        )
      );

      // 2. Create a lab test
      final testId = await database.insertLabTest(
        LabTestsCompanion.insert(
          testName: 'Creatinine',
          category: 'Kidney',
          unit: Value('mg/dL'),
          normalRange: Value('0.6-1.2'),
        )
      );
      
      expect(testId, greaterThan(0));

      // 3. Record a lab result
      final resultId = await database.insertLabResult(
        LabResultsCompanion.insert(
          patientId: patientId,
          labTestId: testId,
          value: 1.1,
          testDate: DateTime.now(),
          status: Value('Normal'),
        )
      );
      
      expect(resultId, greaterThan(0));

      // 4. Query results for patient
      final results = await database.getLabResultsForPatient(patientId);
      expect(results.length, 1);
      expect(results.first.value, 1.1);
      expect(results.first.status, 'Normal');

      // 5. Test joined query
      final resultsWithTests = await database.getLabResultsWithTests(patientId);
      expect(resultsWithTests.length, 1);
      expect(resultsWithTests.first.test?.testName, 'Creatinine');
      
      print('✅ Lab tests and results workflow complete');
    });

    test('symptom logging workflow', () async {
      // 1. Create a patient
      final patientId = await database.insertPatient(
        PatientsCompanion.insert(
          firstName: 'Bob',
          lastName: 'Wilson',
        )
      );

      // 2. Log some symptoms
      await database.insertSymptomLog(
        SymptomLogsCompanion.insert(
          patientId: patientId,
          symptom: 'Fatigue',
          severity: 7,
          logDate: DateTime.now(),
          description: Value('Feeling very tired after minimal activity'),
        )
      );

      await database.insertSymptomLog(
        SymptomLogsCompanion.insert(
          patientId: patientId,
          symptom: 'Nausea',
          severity: 4,
          logDate: DateTime.now().subtract(Duration(hours: 2)),
        )
      );

      // 3. Query symptoms
      final symptoms = await database.getSymptomsForPatient(patientId);
      expect(symptoms.length, 2);
      
      final recentSymptoms = await database.getRecentSymptoms(patientId, days: 1);
      expect(recentSymptoms.length, 2);
      
      print('✅ Symptom logging workflow complete');
    });

    test('database categories and filtering', () async {
      // Create multiple lab tests in different categories
      await database.insertLabTest(
        LabTestsCompanion.insert(testName: 'Creatinine', category: 'Kidney')
      );
      
      await database.insertLabTest(
        LabTestsCompanion.insert(testName: 'ALT', category: 'Liver')
      );
      
      await database.insertLabTest(
        LabTestsCompanion.insert(testName: 'eGFR', category: 'Kidney')
      );

      // Test filtering by category
      final kidneyTests = await database.getLabTestsByCategory('Kidney');
      expect(kidneyTests.length, 2);
      expect(kidneyTests.map((t) => t.testName), contains('Creatinine'));
      expect(kidneyTests.map((t) => t.testName), contains('eGFR'));
      
      final liverTests = await database.getLabTestsByCategory('Liver');
      expect(liverTests.length, 1);
      expect(liverTests.first.testName, 'ALT');
      
      print('✅ Category filtering working');
    });
  });
}
