import 'dart:convert';
import 'dart:math' as math;

import 'lib/services/gemma_embedding_service.dart';
import 'lib/services/vector_search_service.dart';
import 'lib/services/medication_safety_service.dart';

// Data Models (CKDPatientData, CreatinineReading, etc. are unchanged)
class CKDPatientData {
  final String patientId;
  final int age;
  final String sex;
  final List<CreatinineReading> creatinineHistory;
  final List<BPReading> bpHistory;
  final List<CKDMBDReading> mbdHistory;
  final List<String> medications;

  CKDPatientData({
    required this.patientId,
    required this.age,
    required this.sex,
    required this.creatinineHistory,
    required this.bpHistory,
    required this.mbdHistory,
    required this.medications,
  });
}

class CreatinineReading {
  final DateTime date;
  final double value;
  CreatinineReading(this.date, this.value);
}

class BPReading {
  final DateTime date;
  final int systolic;
  final int diastolic;
  BPReading(this.date, this.systolic, this.diastolic);
}

class CKDMBDReading {
  final DateTime date;
  final double? calcium;
  final double? phosphate;
  final double? pth;
  CKDMBDReading({required this.date, this.calcium, this.phosphate, this.pth});
}


// Updated ClinicalAssessment to include medication safety results
class ClinicalAssessment {
  final String ckdStage;
  final double egfr;
  final String actionPriority;
  final List<String> clinicalFlags;
  final List<String> recommendations;
  final Map<String, String> rationale;
  final List<Map<String, dynamic>> guidelineSearchResults;
  final List<MedicationSafetyResult> medicationSafetyWarnings; // NEW

  ClinicalAssessment({
    required this.ckdStage,
    required this.egfr,
    required this.actionPriority,
    required this.clinicalFlags,
    required this.recommendations,
    required this.rationale,
    this.guidelineSearchResults = const [],
    this.medicationSafetyWarnings = const [], // NEW
  });

  @override
  String toString() {
    final warningsText = medicationSafetyWarnings.isNotEmpty
        ? '''
Medication Safety Alerts:
${medicationSafetyWarnings.map((w) => '  - ${w.toString()}').join('\n')}
'''
        : '';

    return """
--- CLINICAL ANALYSIS REPORT ---
$warningsText
Patient Assessment:
  - CKD Stage: $ckdStage
  - Calculated eGFR: ${egfr.toStringAsFixed(1)} ml/min/1.73m²
  - Action Priority: $actionPriority

Clinical Flags Triggered:
${clinicalFlags.map((f) => '  - $f').join('\n')}

Guideline-Informed Recommendations:
${recommendations.map((r) => '  - $r').join('\n')}

Guideline Search Results:
${guidelineSearchResults.map((r) => '  - Found Document: ${r['id']} (Similarity: ${r['score'].toStringAsFixed(2)})').join('\n')}

Clinical Rationale:
${rationale.entries.map((e) => '  - ${e.key}: ${e.value}').join('\n')}
--------------------------------
""";
  }
}

class CKDClinicalAnalyzer {
  final GemmaEmbeddingService embeddingService;
  final VectorSearchService vectorSearchService;
  final MedicationSafetyService medicationSafetyService; // NEW

  CKDClinicalAnalyzer({
    required this.embeddingService,
    required this.vectorSearchService,
    required this.medicationSafetyService, // NEW
  });

  // _parsePatientData, _calculateGFRFromCreatinine etc. are unchanged
    CKDPatientData _parsePatientData(String jsonData) {
    final data = json.decode(jsonData);
    final patientInfo = data['patient_info'];
    final labHistory = data['lab_history'] as List;

    return CKDPatientData(
      patientId: patientInfo['patient_id'],
      age: patientInfo['age'],
      sex: patientInfo['sex'],
      creatinineHistory: labHistory
          .where((r) => r['test'] == 'Creatinine')
          .map((r) => CreatinineReading(
              _parseDate(r['date']), _parseNumericResult(r['result'])))
          .toList(),
      bpHistory: labHistory
          .where((r) => r['test'] == 'Blood Pressure')
          .map((r) => BPReading(_parseDate(r['date']), r['result']['systolic'],
              r['result']['diastolic']))
          .toList(),
      mbdHistory: labHistory
          .where((r) => ['Calcium', 'Phosphate', 'PTH'].contains(r['test']))
          .fold<Map<String, CKDMBDReading>>({}, (map, record) {
            final date = _parseDate(record['date']);
            final dateStr = date.toIso8601String().substring(0, 10);
            map.putIfAbsent(dateStr, () => CKDMBDReading(date: date));
            final entry = map[dateStr]!;
            switch (record['test']) {
              case 'Calcium':
                map[dateStr] = CKDMBDReading(date: entry.date, calcium: _parseNumericResult(record['result']), phosphate: entry.phosphate, pth: entry.pth);
                break;
              case 'Phosphate':
                 map[dateStr] = CKDMBDReading(date: entry.date, calcium: entry.calcium, phosphate: _parseNumericResult(record['result']), pth: entry.pth);
                break;
              case 'PTH':
                 map[dateStr] = CKDMBDReading(date: entry.date, calcium: entry.calcium, phosphate: entry.phosphate, pth: _parseNumericResult(record['result']));
                break;
            }
            return map;
          })
          .values
          .toList(),
      medications: List<String>.from(patientInfo['medications']),
    );
  }

  DateTime _parseDate(String dateStr) => DateTime.parse(dateStr);
  double _parseNumericResult(dynamic result) =>
      double.parse(result.toString().split(' ')[0]);

  void _sortByDate(List<dynamic> list) {
    list.sort((a, b) => a.date.compareTo(b.date));
  }

  double _calculateGFRFromCreatinine(double creatinine, int age, String sex) {
    final double a = (sex == 'Female') ? 0.7 : 0.9;
    final double b = (sex == 'Female') ? -0.241 : -0.302;
    final double c = (sex == 'Female') ? 1.012 : 1.0;
    final double minRatio = math.min(creatinine / a, 1.0);
    final double maxRatio = math.max(creatinine / a, 1.0);

    final gfr = 142 * math.pow(minRatio, b) * math.pow(maxRatio, -1.2) * math.pow(0.9938, age) * c;
    return gfr;
  }

  Future<ClinicalAssessment> analyzeCKDPatientClinical(String jsonData) async {
    final patientData = _parsePatientData(jsonData);
    _sortByDate(patientData.creatinineHistory);
    _sortByDate(patientData.bpHistory);
    _sortByDate(patientData.mbdHistory);

    final latestCreatinine = patientData.creatinineHistory.last;
    final egfr = _calculateGFRFromCreatinine(latestCreatinine.value, patientData.age, patientData.sex);

    final assessment = await _applyClinicalRules(patientData, egfr);
    return assessment;
  }

  // Updated _applyClinicalRules to include medication check
  Future<ClinicalAssessment> _applyClinicalRules(CKDPatientData patientData, double egfr) async {
    var flags = <String>[];
    var recommendations = <String>[];
    var rationale = <String, String>{};
    var guidelineResults = <Map<String, dynamic>>[];

    // NEW: Perform medication safety check
    final medicationWarnings = medicationSafetyService.checkMedications(patientData.medications, egfr);
    if (medicationWarnings.isNotEmpty) {
      flags.add('medication_safety_alert');
      recommendations.add('Review and address high-risk medications.');
      rationale['Medication Safety'] = 'Potentially inappropriate medications identified for current eGFR.';
    }

    // CKD Staging (unchanged)
    String stage;
    if (egfr >= 90) stage = 'G1';
    else if (egfr >= 60) stage = 'G2';
    else if (egfr >= 45) stage = 'G3a';
    else if (egfr >= 30) stage = 'G3b';
    else if (egfr >= 15) stage = 'G4';
    else stage = 'G5';
    rationale['CKD Stage'] = 'eGFR of ${egfr.toStringAsFixed(1)} places patient in Stage $stage.';
    if (egfr < 20) {
      flags.add('predialysis_pathway');
      recommendations.add('Initiate predialysis education and planning.');
      recommendations.add('Evaluate for vascular access placement.');
      rationale['Predialysis'] = 'eGFR is below 20 ml/min, requiring preparation for renal replacement therapy.';
    }

    // BP Control (unchanged)
    if (patientData.bpHistory.isNotEmpty) {
      final latestBP = patientData.bpHistory.last;
      if (latestBP.systolic > 140 || latestBP.diastolic > 90) {
        flags.add('BP_uncontrolled');
        recommendations.add('Optimize antihypertensive regimen; consider RAASi if appropriate.');
        rationale['BP Control'] = 'Latest BP of ${latestBP.systolic}/${latestBP.diastolic} is above target.';
        final bpGuidelineQuery = {
          'query_text': 'uncontrolled hypertension in CKD G4',
          'context': {'eGFR': egfr, 'blood_pressure': '${latestBP.systolic}/${latestBP.diastolic}'}
        };
        final bpVector = await embeddingService.generateEmbedding(bpGuidelineQuery);
        guidelineResults.addAll(await vectorSearchService.search(bpVector));
      }
    }

    // CKD-MBD (unchanged)
    if (patientData.mbdHistory.isNotEmpty) {
        final latestMBD = patientData.mbdHistory.last;
        if (latestMBD.pth != null && latestMBD.pth! > 150) {
            flags.add('CKD-MBD_active');
            recommendations.add('Manage hyperparathyroidism: dietary phosphate restriction, binders, vitamin D analogs as per guidelines.');
            rationale['CKD-MBD'] = 'PTH level of ${latestMBD.pth} is significantly elevated.';
        }
    }

    return ClinicalAssessment(
      ckdStage: stage,
      egfr: egfr,
      actionPriority: (egfr < 30 || medicationWarnings.isNotEmpty) ? 'Urgent' : 'Routine',
      clinicalFlags: flags,
      recommendations: recommendations,
      rationale: rationale,
      guidelineSearchResults: guidelineResults,
      medicationSafetyWarnings: medicationWarnings, // NEW
    );
  }
}
