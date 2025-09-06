class MedicalConstants {
  // CKD Staging
  static const Map<int, String> ckdStages = {
    1: 'Stage 1 - Normal or high (GFR ≥ 90)',
    2: 'Stage 2 - Mild decrease (GFR 60-89)',
    3: 'Stage 3A - Moderate decrease (GFR 45-59)',
    4: 'Stage 3B - Moderate decrease (GFR 30-44)',
    5: 'Stage 4 - Severe decrease (GFR 15-29)',
    6: 'Stage 5 - Kidney failure (GFR < 15 or dialysis)',
  };
  
  // Normal Lab Value Ranges
  static const Map<String, Map<String, double>> normalRanges = {
    'creatinine': {'low': 0.6, 'high': 1.2}, // mg/dL
    'bun': {'low': 7.0, 'high': 20.0}, // mg/dL
    'gfr': {'low': 90.0, 'high': 120.0}, // mL/min/1.73m²
    'albumin': {'low': 3.5, 'high': 5.0}, // g/dL
    'hemoglobin': {'low': 12.0, 'high': 16.0}, // g/dL
    'phosphorus': {'low': 2.5, 'high': 4.5}, // mg/dL
    'calcium': {'low': 8.5, 'high': 10.2}, // mg/dL
    'potassium': {'low': 3.5, 'high': 5.0}, // mEq/L
    'sodium': {'low': 136.0, 'high': 145.0}, // mEq/L
    'uric_acid': {'low': 2.4, 'high': 6.0}, // mg/dL
  };
  
  // Vital Signs Normal Ranges
  static const Map<String, Map<String, double>> vitalRanges = {
    'systolic_bp': {'low': 90.0, 'high': 120.0}, // mmHg
    'diastolic_bp': {'low': 60.0, 'high': 80.0}, // mmHg
    'heart_rate': {'low': 60.0, 'high': 100.0}, // bpm
    'weight': {'low': 40.0, 'high': 150.0}, // kg (reasonable range)
    'fluid_intake': {'low': 1.0, 'high': 4.0}, // L/day
    'fluid_output': {'low': 0.5, 'high': 3.0}, // L/day
  };
  
  // Symptom Severity Scales (1-10)
  static const Map<String, List<String>> symptomScales = {
    'swelling': ['None', 'Minimal', 'Mild', 'Moderate', 'Significant', 'Severe', 'Very Severe', 'Extreme', 'Critical', 'Emergency'],
    'fatigue': ['None', 'Minimal', 'Mild', 'Noticeable', 'Moderate', 'Significant', 'Severe', 'Very Severe', 'Extreme', 'Debilitating'],
    'pain': ['None', 'Minimal', 'Mild', 'Uncomfortable', 'Moderate', 'Distressing', 'Severe', 'Intense', 'Excruciating', 'Unbearable'],
  };
  
  // Lab Test Categories
  static const Map<String, List<String>> labCategories = {
    'kidney': ['creatinine', 'bun', 'gfr', 'albumin', 'protein', 'microalbumin'],
    'hematology': ['hemoglobin', 'hematocrit', 'rbc', 'wbc', 'platelets'],
    'cardio': ['cholesterol', 'ldl', 'hdl', 'triglycerides', 'bnp'],
    'liver': ['alt', 'ast', 'bilirubin', 'alkaline_phosphatase'],
    'diabetes': ['glucose', 'hba1c', 'insulin', 'c_peptide'],
    'thyroid': ['tsh', 't3', 't4'],
    'nutrition': ['b12', 'folate', 'iron', 'ferritin', 'vitamin_d'],
    'electrolytes': ['sodium', 'potassium', 'chloride', 'co2', 'calcium', 'phosphorus', 'magnesium'],
  };
  
  // Test Frequencies by CKD Stage
  static const Map<int, Map<String, String>> recommendedFrequencies = {
    1: {'basic_panel': 'yearly', 'kidney_function': 'yearly'},
    2: {'basic_panel': 'yearly', 'kidney_function': 'every_6_months'},
    3: {'basic_panel': 'every_6_months', 'kidney_function': 'every_3_months'},
    4: {'basic_panel': 'every_3_months', 'kidney_function': 'monthly'},
    5: {'basic_panel': 'monthly', 'kidney_function': 'weekly'},
    6: {'basic_panel': 'weekly', 'kidney_function': 'daily'},
  };
  
  // Medical Alerts Thresholds
  static const Map<String, Map<String, double>> alertThresholds = {
    'critical_high': {
      'creatinine': 5.0,
      'potassium': 6.0,
      'systolic_bp': 180.0,
      'diastolic_bp': 120.0,
    },
    'critical_low': {
      'gfr': 15.0,
      'hemoglobin': 8.0,
      'systolic_bp': 70.0,
      'albumin': 2.0,
    },
  };
  
  // Medical Disclaimer
  static const String medicalDisclaimer = 
    'This is educational information only. Always consult your healthcare provider before making treatment decisions.';
  
  // Emergency Contact Instructions
  static const String emergencyInstructions = 
    'If you experience severe symptoms, difficulty breathing, chest pain, or other emergency signs, contact emergency services immediately or go to the nearest emergency room.';
}
