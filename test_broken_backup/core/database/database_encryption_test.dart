import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import '../../../lib/core/database/database.dart';

void main() {
  group('Database Encryption Tests', () {
    test('should create encrypted database file', () async {
      final tempDir = Directory.systemTemp.createTempSync('dgtl_test_');
      final dbFile = File(p.join(tempDir.path, 'test.db'));
      
      // Create encrypted database
      final database = NativeDatabase.createInBackground(
        dbFile,
        setup: (db) {
          db.execute('PRAGMA key = "test_key_123"');
          db.execute('PRAGMA cipher_compatibility = 4');
        },
      );
      
      final appDb = AppDatabase.forTesting(database);
      
      // Insert test data
      const patient = PatientsCompanion(
        firstName: Value('Encrypted'),
        lastName: Value('Test'),
        dateOfBirth: Value('1990-01-01'),
        gender: Value('Male'),
        ckdStage: Value(2),
      );
      
      final patientId = await appDb.patientsDao.createPatient(patient);
      expect(patientId, greaterThan(0));
      
      await appDb.close();
      
      // Verify file exists and is not readable without key
      expect(dbFile.existsSync(), true);
      expect(dbFile.lengthSync(), greaterThan(0));
      
      // Try to read without encryption - should fail
      try {
        final unencryptedDb = NativeDatabase.createInBackground(dbFile);
        final testAppDb = AppDatabase.forTesting(unencryptedDb);
        await testAppDb.patientsDao.getAllPatients();
        await testAppDb.close();
        fail('Should not be able to read encrypted database without key');
      } catch (e) {
        // Expected - encrypted database cannot be read without key
        expect(e, isNotNull);
      }
      
      // Clean up
      tempDir.deleteSync(recursive: true);
    });

    test('should handle encryption key validation', () async {
      final tempDir = Directory.systemTemp.createTempSync('dgtl_test_');
      final dbFile = File(p.join(tempDir.path, 'test_key.db'));
      
      const correctKey = 'correct_key_123';
      const wrongKey = 'wrong_key_456';
      
      // Create database with correct key
      var database = NativeDatabase.createInBackground(
        dbFile,
        setup: (db) {
          db.execute('PRAGMA key = "$correctKey"');
          db.execute('PRAGMA cipher_compatibility = 4');
        },
      );
      
      var appDb = AppDatabase.forTesting(database);
      
      // Insert data
      const patient = PatientsCompanion(
        firstName: Value('Key'),
        lastName: Value('Test'),
        dateOfBirth: Value('1985-01-01'),
        gender: Value('Female'),
        ckdStage: Value(3),
      );
      
      await appDb.patientsDao.createPatient(patient);
      await appDb.close();
      
      // Try to open with wrong key - should fail
      try {
        database = NativeDatabase.createInBackground(
          dbFile,
          setup: (db) {
            db.execute('PRAGMA key = "$wrongKey"');
            db.execute('PRAGMA cipher_compatibility = 4');
          },
        );
        
        appDb = AppDatabase.forTesting(database);
        await appDb.patientsDao.getAllPatients();
        await appDb.close();
        fail('Should not be able to access database with wrong key');
      } catch (e) {
        // Expected failure
        expect(e, isNotNull);
      }
      
      // Open with correct key - should work
      database = NativeDatabase.createInBackground(
        dbFile,
        setup: (db) {
          db.execute('PRAGMA key = "$correctKey"');
          db.execute('PRAGMA cipher_compatibility = 4');
        },
      );
      
      appDb = AppDatabase.forTesting(database);
      final patients = await appDb.patientsDao.getAllPatients();
      expect(patients.length, equals(1));
      expect(patients.first.firstName, equals('Key'));
      
      await appDb.close();
      
      // Clean up
      tempDir.deleteSync(recursive: true);
    });

    test('should maintain data integrity with encryption', () async {
      final tempDir = Directory.systemTemp.createTempSync('dgtl_test_');
      final dbFile = File(p.join(tempDir.path, 'integrity.db'));
      
      final database = NativeDatabase.createInBackground(
        dbFile,
        setup: (db) {
          db.execute('PRAGMA key = "integrity_key_789"');
          db.execute('PRAGMA cipher_compatibility = 4');
          db.execute('PRAGMA foreign_keys = ON');
        },
      );
      
      final appDb = AppDatabase.forTesting(database);
      
      // Create test data with relationships
      const patient = PatientsCompanion(
        firstName: Value('Integrity'),
        lastName: Value('Test'),
        dateOfBirth: Value('1980-01-01'),
        gender: Value('Male'),
        ckdStage: Value(4),
      );
      
      final patientId = await appDb.patientsDao.createPatient(patient);
      
      // Add related data
      const symptomLog = SymptomLogsCompanion(
        patientId: Value.absent(), // Will be set to patientId
        logDate: Value('2025-01-08'),
        mood: Value(7),
        energyLevel: Value(6),
        systolicBP: Value(140),
        diastolicBP: Value(90),
      );
      
      final logWithPatientId = symptomLog.copyWith(patientId: Value(patientId));
      await appDb.symptomLogsDao.createSymptomLog(logWithPatientId);
      
      // Verify data integrity
      final retrievedPatient = await appDb.patientsDao.getPatientById(patientId);
      final patientLogs = await appDb.symptomLogsDao.getSymptomLogsByPatientId(patientId);
      
      expect(retrievedPatient, isNotNull);
      expect(retrievedPatient!.firstName, equals('Integrity'));
      expect(patientLogs.length, equals(1));
      expect(patientLogs.first.mood, equals(7));
      
      await appDb.close();
      
      // Clean up
      tempDir.deleteSync(recursive: true);
    });
  });
}
