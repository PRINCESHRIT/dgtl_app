/// Represents the result of a medication safety check.
class MedicationSafetyResult {
  final String medicationName;
  final String warning;
  final String severity; // e.g., 'High', 'Moderate'

  MedicationSafetyResult({
    required this.medicationName,
    required this.warning,
    this.severity = 'High',
  });

  @override
  String toString() {
    return '[$severity Risk] $medicationName: $warning';
  }
}

/// A service to check for potentially inappropriate medications in CKD patients.
class MedicationSafetyService {
  // A simplified, mock database of nephrotoxic or contraindicated drugs.
  // In a real system, this would be a comprehensive, evidence-based database.
  static final Map<String, String> _highRiskMedications = {
    // Common NSAIDs
    'ibuprofen': 'NSAID - High risk of acute kidney injury (AKI) in CKD. Avoid.',
    'naproxen': 'NSAID - High risk of AKI in CKD. Avoid.',
    'diclofenac': 'NSAID - High risk of AKI in CKD. Avoid.',
    'ketorolac': 'NSAID - Very high risk of AKI. Strongly contraindicated.',

    // Certain Antibiotics
    'gentamicin': 'Aminoglycoside - High risk of nephrotoxicity. Requires therapeutic drug monitoring.',
    'vancomycin': 'Glycopeptide - Risk of nephrotoxicity. Requires therapeutic drug monitoring.',

    // Other
    'metformin': 'Risk of lactic acidosis increases with declining eGFR. Requires dose adjustment or cessation below eGFR 30.',
    'spironolactone': 'Risk of hyperkalemia, especially with RAAS inhibitors. Use with caution and monitor potassium.',
    'gadolinium': 'Gadolinium-based contrast agents risk NSF in eGFR < 30. Avoid if possible.',
  };

  /// Checks a list of patient medications against a database of high-risk drugs.
  ///
  /// Returns a list of [MedicationSafetyResult] for any identified risks.
  List<MedicationSafetyResult> checkMedications(List<String> patientMedications, double egfr) {
    final results = <MedicationSafetyResult>[];
    final patientMedsLower = patientMedications.map((m) => m.toLowerCase()).toList();

    for (var med in patientMedsLower) {
      if (_highRiskMedications.containsKey(med)) {
        // Basic check
        results.add(MedicationSafetyResult(
          medicationName: med,
          warning: _highRiskMedications[med]!,
        ));
      }
    }

    // eGFR-specific check for Metformin
    if (egfr < 30 && patientMedsLower.contains('metformin')) {
      // If metformin wasn't already added, add a specific warning.
      if (!results.any((r) => r.medicationName == 'metformin')) {
         results.add(MedicationSafetyResult(
          medicationName: 'metformin',
          warning: 'Contraindicated or requires significant dose reduction with eGFR < 30.',
          severity: 'High'
        ));
      }
    }

    return results;
  }
}
