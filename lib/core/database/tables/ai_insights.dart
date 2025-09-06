import 'package:drift/drift.dart';

@DataClass(name: 'AIInsight')
class AIInsights extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id, onDelete: KeyAction.cascade)();
  TextColumn get insightType => text()(); // 'trend', 'alert', 'recommendation', 'prediction'
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get content => text()(); // Main insight content
  TextColumn get severity => text()(); // 'low', 'medium', 'high', 'critical'
  RealColumn get confidence => real().nullable().check(confidence.isBetweenValues(0.0, 1.0))(); // AI confidence score
  TextColumn get sourceData => text().nullable()(); // Reference to source data (JSON)
  BoolColumn get acknowledged => boolean().withDefault(const Constant(false))();
  TextColumn get actionItems => text().nullable()(); // Suggested actions (JSON array)
  DateTimeColumn get generatedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime().nullable()(); // When insight becomes stale
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'INDEX(patientId, generatedAt)',
    'INDEX(severity, acknowledged)',
    'INDEX(insightType, patientId)',
  ];
}

// Reference table for foreign key
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
}
