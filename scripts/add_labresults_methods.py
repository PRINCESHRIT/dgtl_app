# Add missing methods to LabResultsDao
with open('lib/core/database/daos/lab_results_dao.dart', 'r') as f:
    content = f.read()

# Add missing methods for test compatibility
additional_methods = '''
  // Test compatibility methods
  Future<List<LabResult>> getLabResultsByPatientId(int patientId) async {
    return await getLabResultsByPatient(patientId);
  }'''

# Insert before the last closing brace
content = content.replace(
    '  }\n}', 
    additional_methods + '\n  }\n}'
)

with open('lib/core/database/daos/lab_results_dao.dart', 'w') as f:
    f.write(content)

print("Added missing methods to LabResultsDao")
