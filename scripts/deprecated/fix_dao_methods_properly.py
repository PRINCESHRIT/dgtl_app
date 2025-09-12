import re

# Fix PatientsDao properly
with open('lib/core/database/daos/patients_dao.dart', 'r') as f:
    content = f.read()

# Add missing methods at the end, before final brace
additional_methods = '''
  // Test compatibility methods
  Future<Patient?> getPatientById(int id) async {
    return await getPatient(id);
  }

  Future<List<Patient>> searchPatients(String query) async {
    return await searchPatientsByName(query);
  }'''

# Insert before the final closing brace
content = content.rstrip()
if content.endswith('}'):
    content = content[:-1] + additional_methods + '\n}'

with open('lib/core/database/daos/patients_dao.dart', 'w') as f:
    f.write(content)

print("Fixed PatientsDao methods")

# Fix SymptomLogsDao 
with open('lib/core/database/daos/symptom_logs_dao.dart', 'r') as f:
    content = f.read()

# Check what methods exist
existing_methods = []
if 'getSymptomLogsByPatientId(' in content:
    existing_methods.append('getSymptomLogsByPatientId')
if 'getRecentSymptomLogs(' in content:
    existing_methods.append('getRecentSymptomLogs')

symptom_methods = ''
if 'getSymptomLogsByPatientId(' not in content:
    symptom_methods += '''
  // Test compatibility method
  Future<List<SymptomLog>> getSymptomLogsByPatientId(int patientId) async {
    return await (select(symptomLogs)
          ..where((s) => s.patientId.equals(patientId))
          ..orderBy([(s) => OrderingTerm.desc(s.logDate)]))
        .get();
  }'''

if 'getRecentSymptomLogs(' not in content:
    symptom_methods += '''
  
  Future<List<SymptomLog>> getRecentSymptomLogs(int patientId, {int limit = 10}) async {
    return await getRecentLogs(patientId, limit: limit);
  }'''

if symptom_methods:
    content = content.rstrip()
    if content.endswith('}'):
        content = content[:-1] + symptom_methods + '\n}'
    
    with open('lib/core/database/daos/symptom_logs_dao.dart', 'w') as f:
        f.write(content)

print("Fixed SymptomLogsDao methods")

# Fix LabResultsDao
with open('lib/core/database/daos/lab_results_dao.dart', 'r') as f:
    content = f.read()

if 'getLabResultsByPatientId(' not in content:
    lab_methods = '''
  // Test compatibility method
  Future<List<LabResult>> getLabResultsByPatientId(int patientId) async {
    return await (select(labResults)
          ..where((lr) => lr.patientId.equals(patientId))
          ..orderBy([(lr) => OrderingTerm.desc(lr.testDate)]))
        .get();
  }'''
    
    content = content.rstrip()
    if content.endswith('}'):
        content = content[:-1] + lab_methods + '\n}'
    
    with open('lib/core/database/daos/lab_results_dao.dart', 'w') as f:
        f.write(content)

print("Fixed LabResultsDao methods")
