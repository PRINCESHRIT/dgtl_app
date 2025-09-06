import 'package:drift/drift.dart';

@DataClass(name: 'SymptomLog')
class SymptomLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id, onDelete: KeyAction.cascade)();
  TextColumn get symptoms => text()(); // Free text description
  IntColumn get severity => integer().nullable().check(severity.isBetweenValues(1, 10))();
  IntColumn get systolicBP => integer().nullable()(); // Blood pressure systolic
  IntColumn get diastolicBP => integer().nullable()(); // Blood pressure diastolic
  RealColumn get weight => real().nullable()(); // Daily weight in kg
  RealColumn get temperature => real().nullable()(); // Body temperature in Celsius
  IntColumn get heartRate => integer().nullable()(); // Heart rate in BPM
  TextColumn get notes => text().nullable()(); // Additional notes
  BlobColumn get embedding => blob().nullable()(); // Vector embedding for AI
  IntColumn get embeddingDimensions => integer().nullable()();
  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Reference to Patients table for foreign key
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  // ... other columns defined in patients.dart
}
