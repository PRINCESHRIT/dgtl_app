import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/database/database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Database Performance Tests', () {
    test('should handle batch patient insertions efficiently', () async {
      final stopwatch = Stopwatch()..start();
      
      // Insert 1000 patients in batch
      final patients = List.generate(1000, (index) => 
        PatientsCompanion(
          firstName: Value('Patient'),
          lastName: Value('$index'),
          dateOfBirth: Value('198${(index % 10)}-0${(index % 12) + 1:02d}-${(index % 28) + 1:02d}'),
          gender: Value(index % 2 == 0 ? 'Male' : 'Female'),
          ckdStage: Value((index % 5) + 1),
          email: Value('patient$index@test.com'),
        ),
      );

      final patientIds = <int>[];
      for (final patient in patients) {
        final id = await database.patientsDao.createPatient(patient);
        patientIds.add(id);
      }
      
      stopwatch.stop();
      
      expect(patientIds.length, equals(1000));
      expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // Should complete in under 5 seconds
      
      print('Batch insert of 1000 patients: ${stopwatch.elapsedMilliseconds}ms');
    });

    test('should perform fast patient queries with indexes', () async {
      // Create test data first
      final patients = List.generate(100, (index) => 
        PatientsCompanion(
          firstName: Value('Test'),
          lastName: Value('Patient$index'),
          dateOfBirth: Value('1990-01-01'),
          gender: Value(index % 2 == 0 ? 'Male' : 'Female'),
          ckdStage: Value((index % 5) + 1),
        ),
      );

      for (final patient in patients) {
        await database.patientsDao.createPatient(patient);
      }

      final stopwatch = Stopwatch()..start();
      
      // Test indexed queries
      final stage3Patients = await database.patientsDao.getPatientsByCkdStage(3);
      final namedPatients = await database.patientsDao.searchPatients('Test');
      
      stopwatch.stop();
      
      expect(stage3Patients.isNotEmpty, true);
      expect(namedPatients.length, equals(100));
      expect(stopwatch.elapsedMilliseconds, lessThan(100)); // Should be very fast with indexes
      
      print('Indexed patient queries: ${stopwatch.elapsedMilliseconds}ms');
    });

    test('should validate database integrity constraints', () async {
      // Test foreign key constraints
      const invalidSymptomLog = SymptomLogsCompanion(
        patientId: Value(99999), // Non-existent patient
        logDate: Value('2025-01-08'),
        mood: Value(5),
        energyLevel: Value(3),
      );

      expect(
        () => database.symptomLogsDao.createSymptomLog(invalidSymptomLog),
        throwsA(isA<Exception>()),
      );
    });
  });
}
