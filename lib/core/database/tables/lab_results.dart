import 'package:drift/drift.dart';

@DataClass(name: 'LabResult')
class LabResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id, onDelete: KeyAction.cascade)();
  IntColumn get testId => integer().references(LabTests, #id, onDelete: KeyAction.restrict)();
  RealColumn get value => real()(); // Test result value
  TextColumn get status => text().nullable()(); // 'Normal', 'High', 'Low', 'Critical'
  TextColumn get interpretation => text().nullable()(); // Clinical interpretation
  TextColumn get notes => text().nullable()(); // Lab notes or comments
  BlobColumn get embedding => blob().nullable()(); // Vector embedding for AI analysis
  IntColumn get embeddingDimensions => integer().nullable()();
  DateTimeColumn get testDate => dateTime()(); // When the test was performed
  DateTimeColumn get reportDate => dateTime().nullable()(); // When results were reported
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'INDEX(patientId, testDate)',
    'INDEX(testId, testDate)',
  ];
}

// Reference tables for foreign keys
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
}

class LabTests extends Table {
  IntColumn get id => integer().autoIncrement()();
}
