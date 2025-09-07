import 'dart:io';
import 'package:dgtl_app/core/database/database.dart';
import 'package:dgtl_app/core/database/daos/patients_dao.dart';
import 'package:dgtl_app/core/database/daos/symptom_logs_dao.dart';
import 'package:dgtl_app/core/database/daos/lab_results_dao.dart';
import 'package:dgtl_app/core/database/daos/ai_insights_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:drift/drift.dart';

// Helper to open the sqlite3 library for tests
DynamicLibrary _openOnMacOS() {
  final script = File(Platform.script.toFilePath());
  final libraryNextToScript = File('${script.parent.path}/sqlite3.dylib');
  return DynamicLibrary.open(libraryNextToScript.existsSync()
      ? libraryNextToScript.path
      : 'sqlite3.dylib');
}

void main() {
  late AppDatabase database;

  setUpAll(() {
    if (Platform.isMacOS) {
      driftRuntimeOptions.overrideFor(
        sqlite3: Sqlite3.open(
          _openOnMacOS(),
        ),
      );
    }
  });

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.inMemory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Database Tests', () {
    test('Database initializes and DAOs are available', () {
      expect(database, isA<AppDatabase>());
      expect(database.patientsDao, isA<PatientsDao>());
      expect(database.symptomLogsDao, isA<SymptomLogsDao>());
      expect(database.labResultsDao, isA<LabResultsDao>());
      expect(database.aiInsightsDao, isA<AIInsightsDao>());
    });

    test('LabTests data is seeded on creation', () async {
      final labTests = await database.labTestsDao.getAllLabTests();
      expect(labTests.length, 10);
      final egfrTest = labTests.firstWhere((t) => t.testCode == 'EGFR');
      expect(egfrTest.testName, 'eGFR');
    });

    test('PatientsDao: Create and Read Patient', () async {
      final patientId = await database.patientsDao.createPatient(
        const PatientsCompanion(
          name: Value('Test Patient'),
          dateOfBirth: Value('1980-01-01'),
          gender: Value('Female'),
          ckdStage: Value(3),
        ),
      );
      final patient = await database.patientsDao.getPatientById(patientId);
      expect(patient, isNotNull);
      expect(patient!.name, 'Test Patient');
      expect(patient.ckdStage, 3);
    });

    test('SymptomLogsDao: Create and Read Symptom Log', () async {
      final patientId = await database.patientsDao.createPatient(
        const PatientsCompanion(
          name: Value('Symptom Patient'),
          dateOfBirth: Value('1990-01-01'),
          gender: Value('Male'),
        ),
      );

      final logId = await database.symptomLogsDao.createSymptomLog(
        SymptomLogsCompanion(
          patientId: Value(patientId),
          symptoms: const Value('Headache, fatigue'),
          severity: const Value(4),
          recordedAt: Value(DateTime.now()),
        ),
      );

      final logs = await database.symptomLogsDao.getRecentLogs(patientId);
      expect(logs.length, 1);
      expect(logs.first.id, logId);
      expect(logs.first.symptoms, 'Headache, fatigue');
    });

     test('SymptomLogsDao: Calculate Averages', () async {
      final patientId = await database.patientsDao.createPatient(
        const PatientsCompanion(
          name: Value('Avg Patient'),
          dateOfBirth: Value('1995-01-01'),
          gender: Value('Other'),
        ),
      );

      await database.symptomLogsDao.createSymptomLog(SymptomLogsCompanion(
        patientId: Value(patientId),
        recordedAt: Value(DateTime.now()),
        symptoms: const Value('Log 1'),
        systolicBP: const Value(120),
        diastolicBP: const Value(80),
        weight: const Value(70.0),
      ));
       await database.symptomLogsDao.createSymptomLog(SymptomLogsCompanion(
        patientId: Value(patientId),
        recordedAt: Value(DateTime.now()),
        symptoms: const Value('Log 2'),
        systolicBP: const Value(130),
        diastolicBP: const Value(90),
        weight: const Value(71.0),
      ));
       await database.symptomLogsDao.createSymptomLog(SymptomLogsCompanion(
        patientId: Value(patientId),
        recordedAt: Value(DateTime.now()),
        symptoms: const Value('Log 3'),
        systolicBP: const Value(125),
        diastolicBP: null, // test null handling
        weight: const Value(70.5),
      ));

      final averages = await database.symptomLogsDao.getSymptomAverages(patientId, 3);
      expect(averages['systolicBP'], 125.0);
      expect(averages['diastolicBP'], 85.0);
      expect(averages['weight'], closeTo(70.5, 0.01));
    });
  });
}
