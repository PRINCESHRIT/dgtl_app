#!/usr/bin/env python3
"""
Comprehensive DAO and test fix
"""

def fix_lab_tests_dao():
    """Fix the lab_tests_dao.dart file properly"""
    with open('lib/core/database/daos/lab_tests_dao.dart', 'r') as f:
        content = f.read()
    
    # Find the last proper method and class ending
    lines = content.split('\n')
    
    # Find where the class should end (before extra additions)
    proper_lines = []
    in_class = False
    
    for line in lines:
        if 'class LabTestsDao' in line:
            in_class = True
        
        if in_class:
            proper_lines.append(line)
            # Stop at first proper closing brace after methods
            if line.strip() == '}' and len(proper_lines) > 10:
                # Check if this seems like the end of a method, not the class
                prev_line = proper_lines[-2].strip() if len(proper_lines) > 1 else ""
                if not (prev_line.endswith(';') or prev_line.endswith(')')):
                    # This is likely the class ending, but let's add our method before it
                    proper_lines[-1] = '''  
  // Test compatibility method
  Future<LabTest?> getLabTest(int id) async {
    return await (select(labTests)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}'''
                    break
    
    content = '\n'.join(proper_lines)
    
    with open('lib/core/database/daos/lab_tests_dao.dart', 'w') as f:
        f.write(content)
    
    print("Fixed lab_tests_dao.dart structure and added getLabTest method")

def check_method_exists():
    """Check if methods exist in DAOs"""
    import subprocess
    
    # Check symptom_logs_dao for the method
    result = subprocess.run(['grep', '-n', 'getSymptomLogsByPatientId', 'lib/core/database/daos/symptom_logs_dao.dart'], 
                          capture_output=True, text=True)
    if result.returncode == 0:
        print("✅ getSymptomLogsByPatientId exists in symptom_logs_dao.dart")
    else:
        print("❌ getSymptomLogsByPatientId missing in symptom_logs_dao.dart")
    
    # Check lab_results_dao for the method
    result = subprocess.run(['grep', '-n', 'getLabResultsByPatientId', 'lib/core/database/daos/lab_results_dao.dart'], 
                          capture_output=True, text=True)
    if result.returncode == 0:
        print("✅ getLabResultsByPatientId exists in lab_results_dao.dart")
    else:
        print("❌ getLabResultsByPatientId missing in lab_results_dao.dart")

if __name__ == "__main__":
    fix_lab_tests_dao()
    check_method_exists()
