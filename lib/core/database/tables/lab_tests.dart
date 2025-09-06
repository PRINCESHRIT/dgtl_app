import 'package:drift/drift.dart';

@DataClass(name: 'LabTest')
class LabTests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get testCode => text().withLength(min: 2, max: 10)(); // e.g., 'CREAT', 'EGFR'
  TextColumn get name => text().withLength(min: 1, max: 100)(); // e.g., 'Creatinine'
  TextColumn get description => text().nullable()();
  TextColumn get unit => text().withLength(min: 1, max: 20)(); // e.g., 'mg/dL', 'mL/min/1.73m²'
  RealColumn get normalRangeMin => real().nullable()(); // Normal range minimum
  RealColumn get normalRangeMax => real().nullable()(); // Normal range maximum
  TextColumn get category => text().withLength(min: 1, max: 50)(); // e.g., 'Kidney Function'
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
  
  @override
  List<String> get customConstraints => [
    'UNIQUE(testCode)',
  ];
}
