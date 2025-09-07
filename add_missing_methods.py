import re

# Fix patients DAO
with open('lib/core/database/daos/patients_dao.dart', 'r') as f:
    content = f.read()

# Add getPatientById method (alias for getPatient for test compatibility)
additional_methods = '''
  // Test compatibility method
  Future<Patient?> getPatientById(int id) async {
    return await getPatient(id);
  }

  // Search patients method for test compatibility  
  Future<List<Patient>> searchPatients(String query) async {
    return await searchPatientsByName(query);
  }'''

# Insert before the last closing brace
content = content.replace(
    '  }\n}', 
    additional_methods + '\n  }\n}'
)

with open('lib/core/database/daos/patients_dao.dart', 'w') as f:
    f.write(content)

print("Added missing methods to PatientsDao")
