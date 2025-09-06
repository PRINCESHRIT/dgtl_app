import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

// Table imports
import 'tables/patients.dart';
import 'tables/symptom_logs.dart';
import 'tables/lab_tests.dart';
import 'tables/lab_results.dart';
import 'tables/scheduled_tests.dart';
import 'tables/ai_insights.dart';
import 'tables/embedding_cache.dart';

// DAO imports
import 'daos/patients_dao.dart';
import 'daos/symptom_logs_dao.dart';
import 'daos/lab_tests_dao.dart';
import 'daos/lab_results_dao.dart';
import 'daos/scheduled_tests_dao.dart';
import 'daos/ai_insights_dao.dart';
import 'daos/embedding_cache_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Patients,
    SymptomLogs,
    LabTests,
    LabResults,
    ScheduledTests,
    AIInsights,
    EmbeddingCache,
  ],
  daos: [
    PatientsDao,
    SymptomLogsDao,
    LabTestsDao,
    LabResultsDao,
    ScheduledTestsDao,
    AIInsightsDao,
    EmbeddingCacheDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  // Constructor for testing with custom database
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      
      // Seed initial lab tests data
      await _seedLabTests();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Handle database upgrades here
    },
  );

  /// Seed initial lab tests data
  Future<void> _seedLabTests() async {
    final labTestsData = [
      const LabTestsCompanion(
        testCode: Value('CREAT'),
        name: Value('Creatinine'),
        description: Value('Serum creatinine level'),
        unit: Value('mg/dL'),
        normalRangeMin: Value(0.6),
        normalRangeMax: Value(1.2),
        category: Value('Kidney Function'),
      ),
      const LabTestsCompanion(
        testCode: Value('EGFR'),
        name: Value('eGFR'),
        description: Value('Estimated Glomerular Filtration Rate'),
        unit: Value('mL/min/1.73m²'),
        normalRangeMin: Value(90.0),
        normalRangeMax: Value(120.0),
        category: Value('Kidney Function'),
      ),
      const LabTestsCompanion(
        testCode: Value('BUN'),
        name: Value('Blood Urea Nitrogen'),
        description: Value('Blood urea nitrogen test'),
        unit: Value('mg/dL'),
        normalRangeMin: Value(7.0),
        normalRangeMax: Value(20.0),
        category: Value('Kidney Function'),
      ),
      const LabTestsCompanion(
        testCode: Value('ALB'),
        name: Value('Albumin'),
        description: Value('Serum albumin level'),
        unit: Value('g/dL'),
        normalRangeMin: Value(3.4),
        normalRangeMax: Value(5.4),
        category: Value('Protein'),
      ),
      const LabTestsCompanion(
        testCode: Value('HGB'),
        name: Value('Hemoglobin'),
        description: Value('Hemoglobin level'),
        unit: Value('g/dL'),
        normalRangeMin: Value(12.0),
        normalRangeMax: Value(17.5),
        category: Value('Blood Count'),
      ),
      const LabTestsCompanion(
        testCode: Value('PHOS'),
        name: Value('Phosphorus'),
        description: Value('Serum phosphorus level'),
        unit: Value('mg/dL'),
        normalRangeMin: Value(2.5),
        normalRangeMax: Value(4.5),
        category: Value('Minerals'),
      ),
      const LabTestsCompanion(
        testCode: Value('CA'),
        name: Value('Calcium'),
        description: Value('Serum calcium level'),
        unit: Value('mg/dL'),
        normalRangeMin: Value(8.5),
        normalRangeMax: Value(10.2),
        category: Value('Minerals'),
      ),
      const LabTestsCompanion(
        testCode: Value('PTH'),
        name: Value('Parathyroid Hormone'),
        description: Value('Intact PTH level'),
        unit: Value('pg/mL'),
        normalRangeMin: Value(15.0),
        normalRangeMax: Value(65.0),
        category: Value('Hormones'),
      ),
      const LabTestsCompanion(
        testCode: Value('K'),
        name: Value('Potassium'),
        description: Value('Serum potassium level'),
        unit: Value('mEq/L'),
        normalRangeMin: Value(3.5),
        normalRangeMax: Value(5.0),
        category: Value('Electrolytes'),
      ),
      const LabTestsCompanion(
        testCode: Value('UACR'),
        name: Value('Urine Albumin-to-Creatinine Ratio'),
        description: Value('Albumin-to-creatinine ratio in urine'),
        unit: Value('mg/g'),
        normalRangeMin: Value(0.0),
        normalRangeMax: Value(30.0),
        category: Value('Urine Tests'),
      ),
    ];

    for (final testData in labTestsData) {
      await labTestsDao.createLabTest(testData);
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dgtl_app.db'));
    
    // Apply SQLCipher encryption for security
    final database = NativeDatabase.createInBackground(
      file,
      setup: (database) {
        // Enable SQLCipher encryption with AES-256
        database.execute('PRAGMA cipher_compatibility = 4');
        database.execute('PRAGMA key = "dgtl_secure_key_2025"'); // In production, use secure key management
        
        // Performance optimizations
        database.execute('PRAGMA journal_mode = WAL');
        database.execute('PRAGMA synchronous = NORMAL');
        database.execute('PRAGMA cache_size = 10000');
        database.execute('PRAGMA temp_store = MEMORY');
        database.execute('PRAGMA mmap_size = 268435456'); // 256MB
      },
    );
    
    return database;
  });
}
