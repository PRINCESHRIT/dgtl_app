// DGTL Healthcare - Dataset Uploader & Tester (Command-Line Version)
// Uploads a CSV dataset and runs preset checks without Flutter dependencies.

import 'dart:io';
import 'package:csv/csv.dart';
import '../lib/core/database/database_production.dart';
import 'package:drift/native.dart';

void main() async {
  print('🚀 DGTL Healthcare - Dataset Uploader & Tester');
  print('==============================================');
  
  late DgtlDatabase db;

  try {
    // 1. Initialize services
    print('\n1️⃣ Initializing services...');
    // Manually initialize the database for this script
    db = DgtlDatabase.forScript();
    print('✅ Services initialized');
    
    // 2. Load and parse dataset
    print('\n2️⃣ Loading and parsing dataset...');
    final records = await loadAndParseCsv('assets/data/sample_patient_data.csv');
    print('✅ Dataset loaded with ${records.length} records');
    
    // 3. Upload dataset to database
    print('\n3️⃣ Uploading dataset to database...');
    await uploadToDatabase(db, records);
    print('✅ Dataset uploaded successfully');
    
    // 4. Run preset checks
    print('\n4️⃣ Running preset checks...');
    await runPresetChecks(db);
    print('✅ All preset checks completed');
    
    print('\n🎉 Dataset upload and testing completed successfully!');
    
  } catch (e) {
    print('❌ An error occurred: $e');
    exit(1);
  } finally {
    // db.close();
  }
}

Future<List<Map<String, dynamic>>> loadAndParseCsv(String path) async {
  final file = File(path);
  if (!await file.exists()) {
    throw Exception('Dataset file not found at $path');
  }
  
  final content = await file.readAsString();
  final csvParser = CsvToListConverter();
  final listData = csvParser.convert(content);
  
  if (listData.isEmpty) {
    throw Exception('Dataset is empty');
  }
  
  final headers = listData.first.map((h) => h.toString()).toList();
  final records = <Map<String, dynamic>>[];
  
  for (int i = 1; i < listData.length; i++) {
    final row = listData[i];
    final record = <String, dynamic>{};
    for (int j = 0; j < headers.length; j++) {
      record[headers[j]] = row[j];
    }
    records.add(record);
  }
  
  return records;
}

Future<void> uploadToDatabase(DgtlDatabase db, List<Map<String, dynamic>> records) async {
  for (final record in records) {
    try {
      // Check if patient exists, if not create
      final patientId = record['patient_id'].toString();
      
      // Insert lab result
      await db.into(db.labResults).insert(
        LabResultsCompanion.insert(
          patientId: patientId,
          testName: record['test_name'].toString(),
          testValue: record['test_value'].toString(),
          unit: record['unit'].toString(),
          recordedAt: DateTime.parse(record['recorded_at'].toString()),
        )
      );
    } catch (e) {
      print('   ⚠️  Skipping duplicate or invalid record: $record. Error: $e');
    }
  }
}

Future<void> runPresetChecks(DgtlDatabase db) async {
  // Check 1: Verify data for patient dgtl-p001
  print('   - Running check for patient dgtl-p001...');
  final p001Results = await (db.select(db.labResults)
        ..where((tbl) => tbl.patientId.equals('dgtl-p001')))
      .get();
  
  if (p001Results.length >= 8) {
    print('     ✅ Found ${p001Results.length} records for patient dgtl-p001');
  } else {
    print('     ❌ Expected at least 8 records for patient dgtl-p001, found ${p001Results.length}');
  }
  
  // Check 2: Verify high creatinine values
  print('   - Running check for high creatinine values...');
  final highCreatinine = await db.customSelect(
    'SELECT * FROM lab_results WHERE test_name = \'Creatinine\' AND CAST(test_value AS REAL) > 2.0',
    readsFrom: {db.labResults},
  ).get();
      
  if (highCreatinine.length >= 2) {
    print('     ✅ Found ${highCreatinine.length} records with high creatinine');
  } else {
    print('     ❌ Expected at least 2 records with high creatinine, found ${highCreatinine.length}');
  }
  
  // Check 3: Verify eGFR progression for patient dgtl-p002
  print('   - Running check for eGFR progression for patient dgtl-p002...');
  final p002Egfr = await (db.select(db.labResults)
        ..where((tbl) => tbl.patientId.equals('dgtl-p002'))
        ..where((tbl) => tbl.testName.equals('eGFR'))
        ..orderBy([(t) => OrderingTerm(expression: t.recordedAt)]))
      .get();
      
  if (p002Egfr.length == 2) {
    final firstVal = double.parse(p002Egfr[0].testValue);
    final secondVal = double.parse(p002Egfr[1].testValue);
    
    if (secondVal < firstVal) {
      print('     ✅ eGFR progression for patient dgtl-p002 is declining as expected');
    } else {
      print('     ❌ eGFR progression for patient dgtl-p002 is not declining');
    }
  } else {
    print('     ❌ Expected 2 eGFR records for patient dgtl-p002, found ${p002Egfr.length}');
  }
}
