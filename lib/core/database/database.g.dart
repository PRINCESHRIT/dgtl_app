// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final PatientsDao patientsDao = PatientsDao(this as AppDatabase);
  late final SymptomLogsDao symptomLogsDao =
      SymptomLogsDao(this as AppDatabase);
  late final LabTestsDao labTestsDao = LabTestsDao(this as AppDatabase);
  late final LabResultsDao labResultsDao = LabResultsDao(this as AppDatabase);
  late final ScheduledTestsDao scheduledTestsDao =
      ScheduledTestsDao(this as AppDatabase);
  late final AIInsightsDao aIInsightsDao = AIInsightsDao(this as AppDatabase);
  late final EmbeddingCacheDao embeddingCacheDao =
      EmbeddingCacheDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [];
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
}
