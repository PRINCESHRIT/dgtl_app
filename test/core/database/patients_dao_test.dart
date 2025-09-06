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

  group('PatientsDao', () {
    test('should create and retrieve patient', () async {
      const patient = PatientsCompanion(
        firstName: Value('John'),
        lastName: Value('Doe'),
        dateOfBirth: Value('1980-05-15'),
        gender: Value('Male'),
        ckdStage: Value(3),
        email: Value('john.doe@email.com'),
        phone: Value('+1-555-0123'),
      );

      final patientId = await database.patientsDao.createPatient(patient);
      expect(patientId, greaterThan(0));

      final retrievedPatient = await database.patientsDao.getPatientById(patientId);
      expect(retrievedPatient, isNotNull);
      expect(retrievedPatient!.firstName, equals('John'));
      expect(retrievedPatient.lastName, equals('Doe'));
      expect(retrievedPatient.ckdStage, equals(3));
    });

    test('should update patient information', () async {
      // Create patient
      const patient = PatientsCompanion(
        firstName: Value('Jane'),
        lastName: Value('Smith'),
        dateOfBirth: Value('1985-08-20'),
        gender: Value('Female'),
        ckdStage: Value(2),
      );

      final patientId = await database.patientsDao.createPatient(patient);

      // Update patient
      const updatedPatient = PatientsCompanion(
        id: Value.absent(),
        ckdStage: Value(3),
        phone: Value('+1-555-9876'),
      );

      await database.patientsDao.updatePatient(patientId, updatedPatient);

      // Verify update
      final retrievedPatient = await database.patientsDao.getPatientById(patientId);
      expect(retrievedPatient!.ckdStage, equals(3));
      expect(retrievedPatient.phone, equals('+1-555-9876'));
      expect(retrievedPatient.firstName, equals('Jane')); // Should remain unchanged
    });

    test('should delete patient', () async {
      const patient = PatientsCompanion(
        firstName: Value('Delete'),
        lastName: Value('Me'),
        dateOfBirth: Value('1990-01-01'),
        gender: Value('Male'),
        ckdStage: Value(1),
      );

      final patientId = await database.patientsDao.createPatient(patient);
      
      // Verify patient exists
      var retrievedPatient = await database.patientsDao.getPatientById(patientId);
      expect(retrievedPatient, isNotNull);

      // Delete patient
      await database.patientsDao.deletePatient(patientId);

      // Verify patient is deleted
      retrievedPatient = await database.patientsDao.getPatientById(patientId);
      expect(retrievedPatient, isNull);
    });

    test('should get all patients', () async {
      final patients = [
        const PatientsCompanion(
          firstName: Value('Patient'),
          lastName: Value('One'),
          dateOfBirth: Value('1980-01-01'),
          gender: Value('Male'),
          ckdStage: Value(1),
        ),
        const PatientsCompanion(
          firstName: Value('Patient'),
          lastName: Value('Two'),
          dateOfBirth: Value('1985-02-02'),
          gender: Value('Female'),
          ckdStage: Value(2),
        ),
        const PatientsCompanion(
          firstName: Value('Patient'),
          lastName: Value('Three'),
          dateOfBirth: Value('1990-03-03'),
          gender: Value('Male'),
          ckdStage: Value(3),
        ),
      ];

      // Create patients
      for (final patient in patients) {
        await database.patientsDao.createPatient(patient);
      }

      // Get all patients
      final allPatients = await database.patientsDao.getAllPatients();
      expect(allPatients.length, equals(3));
      
      final lastNames = allPatients.map((p) => p.lastName).toList();
      expect(lastNames, containsAll(['One', 'Two', 'Three']));
    });

    test('should get patients by CKD stage', () async {
      final patients = [
        const PatientsCompanion(
          firstName: Value('Stage3'),
          lastName: Value('Patient1'),
          dateOfBirth: Value('1980-01-01'),
          gender: Value('Male'),
          ckdStage: Value(3),
        ),
        const PatientsCompanion(
          firstName: Value('Stage3'),
          lastName: Value('Patient2'),
          dateOfBirth: Value('1985-02-02'),
          gender: Value('Female'),
          ckdStage: Value(3),
        ),
        const PatientsCompanion(
          firstName: Value('Stage4'),
          lastName: Value('Patient'),
          dateOfBirth: Value('1990-03-03'),
          gender: Value('Male'),
          ckdStage: Value(4),
        ),
      ];

      // Create patients
      for (final patient in patients) {
        await database.patientsDao.createPatient(patient);
      }

      // Get stage 3 patients
      final stage3Patients = await database.patientsDao.getPatientsByCkdStage(3);
      expect(stage3Patients.length, equals(2));
      
      for (final patient in stage3Patients) {
        expect(patient.ckdStage, equals(3));
      }

      // Get stage 4 patients
      final stage4Patients = await database.patientsDao.getPatientsByCkdStage(4);
      expect(stage4Patients.length, equals(1));
      expect(stage4Patients.first.lastName, equals('Patient'));
    });

    test('should search patients by name', () async {
      final patients = [
        const PatientsCompanion(
          firstName: Value('John'),
          lastName: Value('Doe'),
          dateOfBirth: Value('1980-01-01'),
          gender: Value('Male'),
          ckdStage: Value(1),
        ),
        const PatientsCompanion(
          firstName: Value('Jane'),
          lastName: Value('Doe'),
          dateOfBirth: Value('1985-02-02'),
          gender: Value('Female'),
          ckdStage: Value(2),
        ),
        const PatientsCompanion(
          firstName: Value('Bob'),
          lastName: Value('Smith'),
          dateOfBirth: Value('1990-03-03'),
          gender: Value('Male'),
          ckdStage: Value(3),
        ),
      ];

      // Create patients
      for (final patient in patients) {
        await database.patientsDao.createPatient(patient);
      }

      // Search by first name
      final johnResults = await database.patientsDao.searchPatients('John');
      expect(johnResults.length, equals(1));
      expect(johnResults.first.firstName, equals('John'));

      // Search by last name
      final doeResults = await database.patientsDao.searchPatients('Doe');
      expect(doeResults.length, equals(2));

      // Search partial match
      final smithResults = await database.patientsDao.searchPatients('Smi');
      expect(smithResults.length, equals(1));
      expect(smithResults.first.lastName, equals('Smith'));
    });

    test('should watch patient changes', () async {
      const patient = PatientsCompanion(
        firstName: Value('Watch'),
        lastName: Value('Me'),
        dateOfBirth: Value('1990-01-01'),
        gender: Value('Female'),
        ckdStage: Value(2),
      );

      final patientId = await database.patientsDao.createPatient(patient);
      
      // Set up stream listener
      final patientStream = database.patientsDao.watchPatient(patientId);
      final streamValues = <Patient?>[];
      
      final subscription = patientStream.listen((patient) {
        streamValues.add(patient);
      });

      // Wait for initial value
      await Future.delayed(const Duration(milliseconds: 10));
      
      // Update patient
      await database.patientsDao.updatePatient(
        patientId,
        const PatientsCompanion(ckdStage: Value(3)),
      );

      // Wait for stream update
      await Future.delayed(const Duration(milliseconds: 10));
      
      // Clean up
      await subscription.cancel();

      // Verify stream received updates
      expect(streamValues.length, greaterThanOrEqualTo(2));
      expect(streamValues.first?.ckdStage, equals(2));
      expect(streamValues.last?.ckdStage, equals(3));
    });
  });
}
