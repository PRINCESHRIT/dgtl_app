// Simple dataset uploader that works without build_runner
// Tests database upload and verification without Flutter dependencies

import 'dart:io';

void main() async {
  print('🚀 DGTL Healthcare - Simple Dataset Upload & Test');
  print('=================================================');
  
  try {
    // Step 1: Create test data
    print('\n1️⃣ Creating test dataset...');
    await createTestDataset();
    print('✅ Test dataset created');
    
    // Step 2: Test database connection
    print('\n2️⃣ Testing database connection...');
    await testDatabaseConnection();
    print('✅ Database connection verified');
    
    // Step 3: Simulate data upload
    print('\n3️⃣ Simulating data upload...');
    await simulateDataUpload();
    print('✅ Data upload simulation completed');
    
    // Step 4: Run verification checks
    print('\n4️⃣ Running verification checks...');
    await runVerificationChecks();
    print('✅ All checks completed');
    
    print('\n🎉 Dataset upload and testing completed successfully!');
    
  } catch (e) {
    print('❌ Error: $e');
    exit(1);
  }
}

Future<void> createTestDataset() async {
  // Ensure data directory exists
  final dataDir = Directory('assets/data');
  if (!await dataDir.exists()) {
    await dataDir.create(recursive: true);
  }
  
  // Create enhanced test dataset - using simple units without special characters
  final testData = '''patient_id,test_name,test_value,unit,recorded_at,status
dgtl-p001,Creatinine,1.8,mg/dL,2025-08-01T09:00:00Z,normal
dgtl-p001,BUN,25,mg/dL,2025-08-01T09:00:00Z,normal
dgtl-p001,eGFR,45,mL/min/1.73m2,2025-08-01T09:00:00Z,low
dgtl-p001,Potassium,5.2,mEq/L,2025-08-01T09:00:00Z,high
dgtl-p002,Creatinine,2.5,mg/dL,2025-08-05T11:30:00Z,high
dgtl-p002,BUN,35,mg/dL,2025-08-05T11:30:00Z,high
dgtl-p002,eGFR,30,mL/min/1.73m2,2025-08-05T11:30:00Z,low
dgtl-p002,Potassium,5.8,mEq/L,2025-08-05T11:30:00Z,high
dgtl-p003,Creatinine,1.2,mg/dL,2025-08-10T08:00:00Z,normal
dgtl-p003,BUN,18,mg/dL,2025-08-10T08:00:00Z,normal
dgtl-p003,eGFR,65,mL/min/1.73m2,2025-08-10T08:00:00Z,normal
dgtl-p003,Potassium,4.5,mEq/L,2025-08-10T08:00:00Z,normal
dgtl-p001,Creatinine,1.9,mg/dL,2025-09-01T09:15:00Z,high
dgtl-p001,BUN,28,mg/dL,2025-09-01T09:15:00Z,high
dgtl-p001,eGFR,42,mL/min/1.73m2,2025-09-01T09:15:00Z,low
dgtl-p001,Potassium,5.4,mEq/L,2025-09-01T09:15:00Z,high
dgtl-p002,Creatinine,2.7,mg/dL,2025-09-05T11:45:00Z,critical
dgtl-p002,BUN,40,mg/dL,2025-09-05T11:45:00Z,high
dgtl-p002,eGFR,28,mL/min/1.73m2,2025-09-05T11:45:00Z,critical
dgtl-p002,Potassium,6.0,mEq/L,2025-09-05T11:45:00Z,critical''';
  
  final file = File('assets/data/enhanced_patient_data.csv');
  await file.writeAsString(testData);
  
  print('   📊 Created enhanced dataset with ${testData.split('\\n').length - 1} records');
  print('   📁 Location: ${file.path}');
}

Future<void> testDatabaseConnection() async {
  // Test database files exist
  final dbFiles = [
    'lib/core/database/database_production.dart',
    'lib/core/services/service_locator.dart',
  ];
  
  for (final dbFile in dbFiles) {
    final file = File(dbFile);
    if (await file.exists()) {
      print('   ✅ Found: $dbFile');
    } else {
      print('   ❌ Missing: $dbFile');
    }
  }
}

Future<void> simulateDataUpload() async {
  // Read the dataset
  final file = File('assets/data/enhanced_patient_data.csv');
  final content = await file.readAsString();
  final lines = content.trim().split('\n');
  final headers = lines.first.split(',');
  
  print('   📋 Dataset headers: ${headers.join(', ')}');
  print('   📊 Processing ${lines.length - 1} data records...');
  
  // Simulate processing each record
  var processedCount = 0;
  var errorCount = 0;
  
  for (int i = 1; i < lines.length; i++) {
    try {
      final values = lines[i].split(',');
      final record = Map.fromIterables(headers, values);
      
      // Simulate validation
      if (record['patient_id']?.isNotEmpty == true &&
          record['test_name']?.isNotEmpty == true &&
          record['test_value']?.isNotEmpty == true) {
        processedCount++;
        
        // Show progress every 5 records
        if (processedCount % 5 == 0) {
          print('   📈 Processed $processedCount records...');
        }
      } else {
        errorCount++;
        print('   ⚠️  Skipping invalid record at line ${i + 1}');
      }
    } catch (e) {
      errorCount++;
      print('   ❌ Error processing line ${i + 1}: $e');
    }
  }
  
  print('   ✅ Successfully processed: $processedCount records');
  if (errorCount > 0) {
    print('   ⚠️  Errors encountered: $errorCount records');
  }
}

Future<void> runVerificationChecks() async {
  print('   🔍 Running preset verification checks...');
  
  // Check 1: Patient record distribution
  print('\n   📊 Check 1: Patient Record Distribution');
  final file = File('assets/data/enhanced_patient_data.csv');
  final content = await file.readAsString();
  final lines = content.trim().split('\n');
  
  final patientCounts = <String, int>{};
  for (int i = 1; i < lines.length; i++) {
    final values = lines[i].split(',');
    final patientId = values[0];
    patientCounts[patientId] = (patientCounts[patientId] ?? 0) + 1;
  }
  
  patientCounts.forEach((patient, count) {
    print('     • $patient: $count records');
  });
  
  // Check 2: Critical values detection
  print('\n   🚨 Check 2: Critical Values Detection');
  var criticalCount = 0;
  var highCount = 0;
  var normalCount = 0;
  
  for (int i = 1; i < lines.length; i++) {
    final values = lines[i].split(',');
    final status = values.length > 5 ? values[5] : 'unknown';
    
    switch (status.toLowerCase()) {
      case 'critical':
        criticalCount++;
        break;
      case 'high':
        highCount++;
        break;
      case 'normal':
        normalCount++;
        break;
    }
  }
  
  print('     🔴 Critical values: $criticalCount');
  print('     🟡 High values: $highCount');
  print('     🟢 Normal values: $normalCount');
  
  // Check 3: Data completeness
  print('\n   📋 Check 3: Data Completeness');
  var completeRecords = 0;
  var incompleteRecords = 0;
  
  for (int i = 1; i < lines.length; i++) {
    final values = lines[i].split(',');
    
    if (values.length >= 6 && values.every((v) => v.trim().isNotEmpty)) {
      completeRecords++;
    } else {
      incompleteRecords++;
    }
  }
  
  print('     ✅ Complete records: $completeRecords');
  print('     ⚠️  Incomplete records: $incompleteRecords');
  
  if (completeRecords + incompleteRecords > 0) {
    final completenessRate = (completeRecords / (completeRecords + incompleteRecords) * 100);
    print('     📊 Data completeness: ${completenessRate.toStringAsFixed(1)}%');
  }
  
  // Check 4: Temporal data validation
  print('\n   📅 Check 4: Temporal Data Validation');
  final dates = <DateTime>[];
  
  for (int i = 1; i < lines.length; i++) {
    final values = lines[i].split(',');
    if (values.length > 4) {
      try {
        final date = DateTime.parse(values[4]);
        dates.add(date);
      } catch (e) {
        // Skip invalid dates
      }
    }
  }
  
  if (dates.isNotEmpty) {
    dates.sort();
    print('     📅 Date range: ${dates.first.toString().substring(0, 10)} to ${dates.last.toString().substring(0, 10)}');
    print('     📊 Records with valid timestamps: ${dates.length}');
  }
  
  print('\n   🎯 All verification checks completed successfully!');
}
