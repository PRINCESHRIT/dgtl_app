import 'dart:typed_data';
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/symptom_logs.dart';

part 'symptom_logs_dao.g.dart';

@DriftAccessor(tables: [SymptomLogs])
class SymptomLogsDao extends DatabaseAccessor<AppDatabase> with _$SymptomLogsDaoMixin {
  SymptomLogsDao(AppDatabase db) : super(db);

  // Create symptom log
  Future<int> createSymptomLog(SymptomLogsCompanion log) async {
    return await into(symptomLogs).insert(log);
  }

  // Get recent logs for a patient
  Future<List<SymptomLog>> getRecentLogs(int patientId, {int limit = 50}) async {
    return await (select(symptomLogs)
      ..where((s) => s.patientId.equals(patientId))
      ..orderBy([(s) => OrderingTerm.desc(s.recordedAt)])
      ..limit(limit)
    ).get();
  }

  // Get logs by date range
  Future<List<SymptomLog>> getLogsByDateRange(
    int patientId, 
    DateTime startDate, 
    DateTime endDate
  ) async {
    return await (select(symptomLogs)
      ..where((s) => 
        s.patientId.equals(patientId) & 
        s.recordedAt.isBetweenValues(startDate, endDate)
      )
      ..orderBy([(s) => OrderingTerm.desc(s.recordedAt)])
    ).get();
  }

  // Update embedding for a log
  Future<void> updateEmbedding(int logId, Uint8List embedding, int dimensions) async {
    await (update(symptomLogs)..where((s) => s.id.equals(logId)))
      .write(SymptomLogsCompanion(
        embedding: Value(embedding),
        embeddingDimensions: Value(dimensions),
      ));
  }

  // Get symptom averages for analytics
  Future<Map<String, double?>> getSymptomAverages(int patientId, int days) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    final logs = await (select(symptomLogs)
      ..where((s) => 
        s.patientId.equals(patientId) & 
        s.recordedAt.isBiggerOrEqualValue(startDate)
      )
    ).get();

    if (logs.isEmpty) return {};

    final validSystolic = logs.where((l) => l.systolicBP != null).map((l) => l.systolicBP!.toDouble()).toList();
    final validDiastolic = logs.where((l) => l.diastolicBP != null).map((l) => l.diastolicBP!.toDouble()).toList();
    final validWeight = logs.where((l) => l.weight != null).map((l) => l.weight!).toList();

    return {
      'systolicBP': validSystolic.isNotEmpty ? validSystolic.reduce((a, b) => a + b) / validSystolic.length : null,
      'diastolicBP': validDiastolic.isNotEmpty ? validDiastolic.reduce((a, b) => a + b) / validDiastolic.length : null,
      'weight': validWeight.isNotEmpty ? validWeight.reduce((a, b) => a + b) / validWeight.length : null,
    };
  }

  // Watch symptom logs for reactive UI
  Stream<List<SymptomLog>> watchRecentLogs(int patientId, {int limit = 10}) {
    return (select(symptomLogs)
      ..where((s) => s.patientId.equals(patientId))
      ..orderBy([(s) => OrderingTerm.desc(s.recordedAt)])
      ..limit(limit)
    ).watch();
  }

  // Delete symptom log
  Future<int> deleteSymptomLog(int logId) async {
    return await (delete(symptomLogs)..where((s) => s.id.equals(logId))).go();
  }
}
