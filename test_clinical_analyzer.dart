// Test Enhanced CKD Clinical Analyzer with Brenner & Rector's Logic
import 'ckd_clinical_analyzer_enhanced.dart';

void main() async {
  print('🚀 Testing Enhanced CKD Clinical Analyzer');
  print('📚 Based on Brenner & Rector\'s Clinical Ruleset');
  
  final analyzer = CKDClinicalAnalyzer();
  
  // Your actual patient data
  final realPatientData = [
    {
      "Date": "06-Dec-2017",
      "Test Name": "Creatinine (Blood)",
      "Result": 3.0,
      "Unit": "mg/dl",
      "Reference Range": "0.5-0.9",
      "Method": "Kinetic Jaffe",
      "Source": "Suraksha",
      "Doctor": "Dr. Nayana Deb",
      "Remarks": "High"
    },
    {
      "Date": "27-Jul-2018",
      "Test Name": "PTH (Parathyroid Hormone)",
      "Result": 190.1,
      "Unit": "pg/ml",
      "Reference Range": "15-65",
      "Method": "ECLIA",
      "Source": "Suraksha",
      "Doctor": "Dr. Neepa Chowdhury",
      "Remarks": "Very High"
    },
    {
      "Date": "29-Jan-2018",
      "Test Name": "GFR (Left Kidney)",
      "Result": 8.8,
      "Unit": "ml/min",
      "Reference Range": "≥80",
      "Method": null,
      "Source": "Dev Institute",
      "Doctor": "Dr. A.K. Das",
      "Remarks": "Severely reduced"
    },
    {
      "Date": "13-Oct-2022",
      "Test Name": "Creatinine (Serum)",
      "Result": 3.22,
      "Unit": "mg/dl",
      "Reference Range": "0.5-0.9",
      "Method": "Kinetic Jaffe",
      "Source": "SagePath",
      "Doctor": "Dr. Yashwant Singh",
      "Remarks": "High"
    },
    {
      "Date": "2023",
      "Test Name": "Blood Pressure Reading",
      "Result": {
        "Systolic": 143,
        "Diastolic": 94
      },
      "Unit": "mmHg",
      "Reference Range": "120/80",
      "Method": "Manual",
      "Source": "Home Record",
      "Doctor": null,
      "Remarks": "Hypertensive"
    },
    {
      "Date": "03-Jan-2023",
      "Test Name": "Prescription",
      "Result": [
        "Lasix",
        "Etroxin",
        "Shelcal HD",
        "Supradyn",
        "Autrin",
        "Amlodipin"
      ],
      "Unit": null,
      "Reference Range": null,
      "Method": "Clinic Note",
      "Source": null,
      "Doctor": "Dr. Singh",
      "Remarks": "Medication advice"
    }
  ];
  
  print('\n📊 Clinical Analysis in Progress...');
  final analysis = await analyzer.analyzeCKDPatientClinical(realPatientData);
  
  print('\n🏥 ENHANCED CKD CLINICAL ANALYSIS RESULTS');
  print('=' * 60);
  
  print('\n📋 PATIENT OVERVIEW:');
  print('• Age: ${analysis.patientData.age} years');
  print('• Sex: ${analysis.patientData.sex}');
  print('• Total Records: ${analysis.patientData.labHistory.length}');
  print('• Creatinine Readings: ${analysis.patientData.creatinineReadings.length}');
  print('• BP Readings: ${analysis.patientData.bpReadings.length}');
  print('• Current Medications: ${analysis.patientData.currentMedications.length}');
  
  print('\n🎯 CLINICAL ASSESSMENT:');
  print('• CKD Stage: ${analysis.clinicalAssessment.ckdStage}');
  print('• Action Priority: ${analysis.priority}');
  print('• Clinical Flags: ${analysis.clinicalAssessment.flags.join(", ")}');
  
  if (analysis.patientData.creatinineReadings.isNotEmpty) {
    final latest = analysis.patientData.creatinineReadings.last;
    print('• Latest Creatinine: ${latest.creatinine} ${latest.unit}');
    print('• Calculated eGFR: ${latest.estimatedGFR.toStringAsFixed(1)} ml/min/1.73m²');
  }
  
  print('\n💡 CLINICAL RECOMMENDATIONS:');
  for (int i = 0; i < analysis.recommendations.length; i++) {
    print('${i + 1}. ${analysis.recommendations[i]}');
  }
  
  print('\n🔬 NEXT LABORATORY TESTS:');
  for (int i = 0; i < analysis.nextLabs.length; i++) {
    print('${i + 1}. ${analysis.nextLabs[i]}');
  }
  
  if (analysis.redFlags.isNotEmpty) {
    print('\n🚨 RED FLAGS - URGENT ATTENTION REQUIRED:');
    for (int i = 0; i < analysis.redFlags.length; i++) {
      print('${i + 1}. ${analysis.redFlags[i]}');
    }
  }
  
  print('\n📖 CLINICAL RATIONALE:');
  for (int i = 0; i < analysis.rationale.length; i++) {
    print('${i + 1}. ${analysis.rationale[i]}');
  }
  
  print('\n🔍 DETAILED CLINICAL FINDINGS:');
  
  // Creatinine progression analysis
  if (analysis.patientData.creatinineReadings.length >= 2) {
    final first = analysis.patientData.creatinineReadings.first;
    final last = analysis.patientData.creatinineReadings.last;
    final progression = ((last.creatinine - first.creatinine) / first.creatinine) * 100;
    final timeSpan = last.date.difference(first.date).inDays / 365.25;
    
    print('• Creatinine Progression: ${first.creatinine} → ${last.creatinine} mg/dl');
    print('• Progression Rate: ${progression.toStringAsFixed(1)}% over ${timeSpan.toStringAsFixed(1)} years');
    print('• eGFR Decline: ${first.estimatedGFR.toStringAsFixed(1)} → ${last.estimatedGFR.toStringAsFixed(1)} ml/min/1.73m²');
  }
  
  // Blood pressure analysis
  if (analysis.patientData.bpReadings.isNotEmpty) {
    final latestBP = analysis.patientData.bpReadings.last;
    print('• Blood Pressure: ${latestBP.systolic}/${latestBP.diastolic} mmHg');
    final controlled = latestBP.systolic < 130 && latestBP.diastolic < 80;
    print('• BP Control Status: ${controlled ? "CONTROLLED" : "UNCONTROLLED"}');
  }
  
  print('\n⚠️ CLINICAL DECISION SUPPORT:');
  print('This analysis implements Brenner & Rector\'s clinical decision rules');
  print('for comprehensive CKD management and follows KDIGO guidelines.');
  print('Always validate with your nephrologist before clinical decisions.');
  
  print('\n✅ Analysis Complete - Enhanced Clinical Logic Applied');
}
