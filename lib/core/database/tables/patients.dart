import 'package:drift/drift.dart';

@DataClass(name: 'Patient')
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get dateOfBirth => text()(); // YYYY-MM-DD format
  TextColumn get gender => text().withLength(min: 1, max: 20)();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get emergencyContact => text().nullable()();
  IntColumn get ckdStage => integer().nullable().check(ckdStage.isBetweenValues(1, 5))();
  TextColumn get medications => text().nullable()(); // JSON array as string
  TextColumn get allergies => text().nullable()(); // Comma-separated
  RealColumn get weight => real().nullable()(); // in kg
  RealColumn get height => real().nullable()(); // in cm
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}