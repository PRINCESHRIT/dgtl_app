import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/ai_insights.dart';

part 'ai_insights_dao.g.dart';

@DriftAccessor(tables: [AIInsights])
class AIInsightsDao extends DatabaseAccessor<AppDatabase> with _$AIInsightsDaoMixin {
  AIInsightsDao(AppDatabase db) : super(db);

  Future<int> createInsight(AIInsightsCompanion insight) async {
    return await into(aIInsights).insert(insight);
  }

  Future<List<AIInsight>> getRecentInsights(int patientId, {int limit = 20}) async {
    return await (select(aIInsights)
      ..where((i) => i.patientId.equals(patientId))
      ..orderBy([(i) => OrderingTerm.desc(i.generatedAt)])
      ..limit(limit)
    ).get();
  }

  Future<List<AIInsight>> getUnacknowledgedInsights(int patientId) async {
    return await (select(aIInsights)
      ..where((i) => 
        i.patientId.equals(patientId) & 
        i.acknowledged.equals(false)
      )
      ..orderBy([(i) => OrderingTerm.desc(i.generatedAt)])
    ).get();
  }

  Future<List<AIInsight>> getInsightsBySeverity(int patientId, String severity) async {
    return await (select(aIInsights)
      ..where((i) => 
        i.patientId.equals(patientId) & 
        i.severity.equals(severity)
      )
      ..orderBy([(i) => OrderingTerm.desc(i.generatedAt)])
    ).get();
  }

  Future<void> acknowledgeInsight(int insightId) async {
    await (update(aIInsights)..where((i) => i.id.equals(insightId)))
      .write(const AIInsightsCompanion(acknowledged: Value(true)));
  }

  Stream<List<AIInsight>> watchUnacknowledgedInsights(int patientId) {
    return (select(aIInsights)
      ..where((i) => 
        i.patientId.equals(patientId) & 
        i.acknowledged.equals(false)
      )
      ..orderBy([(i) => OrderingTerm.desc(i.generatedAt)])
    ).watch();
  }

  Future<int> getInsightCount(int patientId, {String? severity}) async {
    if (severity != null) {
      return await (selectOnly(aIInsights)
        ..addColumns([aIInsights.id.count()])
        ..where(aIInsights.patientId.equals(patientId) & aIInsights.severity.equals(severity))
      ).getSingle().then((row) => row.read(aIInsights.id.count()) ?? 0);
    } else {
      return await (selectOnly(aIInsights)
        ..addColumns([aIInsights.id.count()])
        ..where(aIInsights.patientId.equals(patientId))
      ).getSingle().then((row) => row.read(aIInsights.id.count()) ?? 0);
    }
  }
}
