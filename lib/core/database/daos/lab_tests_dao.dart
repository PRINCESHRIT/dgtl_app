import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/lab_tests.dart';

part 'lab_tests_dao.g.dart';

@DriftAccessor(tables: [LabTests])
class LabTestsDao extends DatabaseAccessor<AppDatabase> with _$LabTestsDaoMixin {
  LabTestsDao(AppDatabase db) : super(db);

  // Create lab test
  Future<int> createLabTest(LabTestsCompanion test) async {
    return await into(labTests).insert(test);
  }

  // Get all lab tests
  Future<List<LabTest>> getAllLabTests() async {
    return await select(labTests).get();
  }

  // Get active lab tests
  Future<List<LabTest>> getActiveLabTests() async {
    return await (select(labTests)
      ..where((t) => t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.name)])
    ).get();
  }

  // Get lab test by code
  Future<LabTest?> getLabTestByCode(String testCode) async {
    return await (select(labTests)..where((t) => t.testCode.equals(testCode))).getSingleOrNull();
  }

  // Get lab tests by category
  Future<List<LabTest>> getLabTestsByCategory(String category) async {
    return await (select(labTests)
      ..where((t) => t.category.equals(category) & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.name)])
    ).get();
  }

  // Update lab test
  Future<bool> updateLabTest(LabTest test) async {
    return await update(labTests).replace(test);
  }

  // Deactivate lab test (soft delete)
  Future<void> deactivateLabTest(int testId) async {
    await (update(labTests)..where((t) => t.id.equals(testId)))
      .write(const LabTestsCompanion(isActive: Value(false)));
  }

  // Search lab tests by name
  Future<List<LabTest>> searchLabTestsByName(String name) async {
    return await (select(labTests)
      ..where((t) => t.name.like('%$name%') & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.name)])
    ).get();
  }
}
