import 'package:drift/drift.dart';

@DataClass(name: 'ScheduledTest')
class ScheduledTests extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id, onDelete: KeyAction.cascade)();
  IntColumn get testId => integer().references(LabTests, #id, onDelete: KeyAction.restrict)();
  TextColumn get frequency => text()(); // 'daily', 'weekly', 'monthly', 'quarterly', 'yearly'
  DateTimeColumn get nextDueDate => dateTime()(); // When the test is next due
  DateTimeColumn get lastCompletedDate => dateTime().nullable()(); // When last completed
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get reminderDaysBefore => integer().withDefault(const Constant(3))(); // Days before to remind
  TextColumn get notes => text().nullable()(); // Special instructions
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'INDEX(patientId, nextDueDate)',
    'INDEX(isActive, nextDueDate)',
  ];
}

// Reference tables for foreign keys
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
}

class LabTests extends Table {
  IntColumn get id => integer().autoIncrement()();
}
