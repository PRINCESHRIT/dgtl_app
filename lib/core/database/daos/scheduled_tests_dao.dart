import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/scheduled_tests.dart';

part 'scheduled_tests_dao.g.dart';

@DriftAccessor(tables: [ScheduledTests])
class ScheduledTestsDao extends DatabaseAccessor<AppDatabase> with _$ScheduledTestsDaoMixin {
  ScheduledTestsDao(AppDatabase db) : super(db);

  Future<int> createScheduledTest(ScheduledTestsCompanion test) async {
    return await into(scheduledTests).insert(test);
  }

  Future<List<ScheduledTest>> getUpcomingTests(int patientId) async {
    final now = DateTime.now();
    return await (select(scheduledTests)
      ..where((t) => 
        t.patientId.equals(patientId) & 
        t.isActive.equals(true) &
        t.nextDueDate.isBiggerOrEqualValue(now)
      )
      ..orderBy([(t) => OrderingTerm.asc(t.nextDueDate)])
    ).get();
  }

  Future<List<ScheduledTest>> getOverdueTests(int patientId) async {
    final now = DateTime.now();
    return await (select(scheduledTests)
      ..where((t) => 
        t.patientId.equals(patientId) & 
        t.isActive.equals(true) &
        t.nextDueDate.isSmallerThanValue(now)
      )
      ..orderBy([(t) => OrderingTerm.asc(t.nextDueDate)])
    ).get();
  }

  Future<void> markTestCompleted(int testId, DateTime completedDate) async {
    final test = await (select(scheduledTests)..where((t) => t.id.equals(testId))).getSingleOrNull();
    if (test == null) return;

    DateTime nextDue;
    switch (test.frequency) {
      case 'daily':
        nextDue = completedDate.add(const Duration(days: 1));
        break;
      case 'weekly':
        nextDue = completedDate.add(const Duration(days: 7));
        break;
      case 'monthly':
        nextDue = DateTime(completedDate.year, completedDate.month + 1, completedDate.day);
        break;
      case 'quarterly':
        nextDue = DateTime(completedDate.year, completedDate.month + 3, completedDate.day);
        break;
      case 'yearly':
        nextDue = DateTime(completedDate.year + 1, completedDate.month, completedDate.day);
        break;
      default:
        nextDue = completedDate.add(const Duration(days: 30));
    }

    await (update(scheduledTests)..where((t) => t.id.equals(testId)))
      .write(ScheduledTestsCompanion(
        lastCompletedDate: Value(completedDate),
        nextDueDate: Value(nextDue),
      ));
  }

  Stream<List<ScheduledTest>> watchUpcomingTests(int patientId) {
    final now = DateTime.now();
    return (select(scheduledTests)
      ..where((t) => 
        t.patientId.equals(patientId) & 
        t.isActive.equals(true) &
        t.nextDueDate.isBiggerOrEqualValue(now)
      )
      ..orderBy([(t) => OrderingTerm.asc(t.nextDueDate)])
    ).watch();
  }
}
