# Add missing methods to SymptomLogsDao
with open('lib/core/database/daos/symptom_logs_dao.dart', 'r') as f:
    content = f.read()

# Add missing methods for test compatibility
additional_methods = '''
  // Test compatibility methods
  Future<List<SymptomLog>> getSymptomLogsByPatientId(int patientId) async {
    return await getSymptomLogsByPatient(patientId);
  }

  Future<List<SymptomLog>> getRecentSymptomLogs(int patientId, {int limit = 10}) async {
    return await getRecentLogs(patientId, limit: limit);
  }'''

# Insert before the last closing brace
content = content.replace(
    '  }\n}', 
    additional_methods + '\n  }\n}'
)

with open('lib/core/database/daos/symptom_logs_dao.dart', 'w') as f:
    f.write(content)

print("Added missing methods to SymptomLogsDao")
