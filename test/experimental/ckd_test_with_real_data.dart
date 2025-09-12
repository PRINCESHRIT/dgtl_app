// Test CKD Analyzer with Real Patient Data
import 'ckd_lab_analyzer_week1.dart';

void main() async {
  print('🚀 Testing CKD Analyzer with Real Patient Data');
  
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
      "Date": "07-Dec-2017",
      "Test Name": "Ultrasound Kidneys",
      "Result": "Bilateral small echogenic kidneys",
      "Unit": null,
      "Reference Range": "Normal",
      "Method": "Ultrasound",
      "Source": "Harsh Diagnostic",
      "Doctor": "Dr. Ravindra Kumar Sinha",
      "Remarks": "Suggestive of CKD"
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
      "Date": "11-Nov-2022",
      "Test Name": "Urine Protein (24hr)",
      "Result": 165.2,
      "Unit": "mg/24hr",
      "Reference Range": "<150",
      "Method": "Pyrogallol Red",
      "Source": "SagePath",
      "Doctor": "Dr. Yashwant Singh",
      "Remarks": "Slightly High"
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
    }
  ];
  
  print('\n📊 Patient Data Overview:');
  print('- Total Records: \${realPatientData.length}');
  print('- Date Range: Dec 2017 - 2023 (5+ years)');
  print('- Key Tests: Creatinine, GFR, PTH, Ultrasound, BP');
  
  final analyzer = CKDLabAnalyzer();
  final analysis = await analyzer.analyzeCKDPatient(realPatientData);
  
  print('\n🏥 CKD Analysis Results:');
  print('Current Stage: \${analysis.currentCKDStage}');
  print('Time Span: \${analysis.timeSpan}');
  print('Total Records: \${analysis.totalRecords}');
  
  print('\n💡 Key Clinical Recommendations:');
  for (int i = 0; i < analysis.recommendations.length; i++) {
    print('\${i + 1}. \${analysis.recommendations[i]}');
  }
  
  print('\n🔍 Critical Findings from Data:');
  print('• Creatinine progression: 3.0 → 3.22 mg/dl (2017-2022)');
  print('• GFR severely reduced: 8.8 ml/min (Stage 5 CKD)');
  print('• Secondary hyperparathyroidism: PTH 190.1 pg/ml');
  print('• Proteinuria present: 165.2 mg/24hr');
  print('• Hypertension: 143/94 mmHg');
  print('• Structural changes: Bilateral small echogenic kidneys');
  
  print('\n⚠️ Clinical Priority: This patient requires immediate nephrology care and dialysis evaluation.');
}
