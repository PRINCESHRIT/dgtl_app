import 'dart:typed_data';
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/lab_results.dart';
import '../tables/lab_tests.dart';

part 'lab_results_dao.g.dart';

@DriftAccessor(tables: [LabResults, LabTests])
class LabResultsDao extends DatabaseAccessor<AppDatabase> with _$LabResultsDaoMixin {
  LabResultsDao(AppDatabase db) : super(db);

  Future<int> createLabResult(LabResultsCompanion result) async {
    return await into(labResults).insert(result);
  }

  Future<List<LabResult>> getRecentResults(int patientId, {int limit = 50}) async {
    return await (select(labResults)
      ..where((r) => r.patientId.equals(patientId))
      ..orderBy([(r) => OrderingTerm.desc(r.testDate)])
      ..limit(limit)
    ).get();
  }

  Future<List<LabResult>> getResultsByTest(int patientId, int testId) async {
    return await (select(labResults)
      ..where((r) => r.patientId.equals(patientId) & r.testId.equals(testId))
      ..orderBy([(r) => OrderingTerm.desc(r.testDate)])
    ).get();
  }

  Future<void> updateEmbedding(int resultId, Uint8List embedding, int dimensions) async {
    await (update(labResults)..where((r) => r.id.equals(resultId)))
      .write(LabResultsCompanion(
        embedding: Value(embedding),
        embeddingDimensions: Value(dimensions),
      ));
  }

  Stream<List<LabResult>> watchRecentResults(int patientId, {int limit = 10}) {
    return (select(labResults)
      ..where((r) => r.patientId.equals(patientId))
      ..orderBy([(r) => OrderingTerm.desc(r.testDate)])
      ..limit(limit)
    ).watch();
  }
}
