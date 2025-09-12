#!/usr/bin/env python3
"""
Fix DAO methods with proper implementations
"""

def fix_symptom_logs_dao():
    """Fix symptom_logs_dao methods to call proper implementations"""
    with open('lib/core/database/daos/symptom_logs_dao.dart', 'r') as f:
        content = f.read()
    
    # Fix getSymptomLogsByPatientId to call getRecentLogs 
    content = content.replace(
        'return await getSymptomLogsByPatientId(patientId);',
        'return await getRecentLogs(patientId);'
    )
    
    with open('lib/core/database/daos/symptom_logs_dao.dart', 'w') as f:
        f.write(content)
    
    print("Fixed symptom_logs_dao.dart method implementations")

def fix_lab_results_dao():
    """Fix lab_results_dao methods to call proper implementations"""
    with open('lib/core/database/daos/lab_results_dao.dart', 'r') as f:
        content = f.read()
    
    # Fix getLabResultsByPatientId to call getRecentResults
    content = content.replace(
        'return await getLabResultsByPatient(patientId);',
        'return await getRecentResults(patientId);'
    )
    
    with open('lib/core/database/daos/lab_results_dao.dart', 'w') as f:
        f.write(content)
    
    print("Fixed lab_results_dao.dart method implementations")

if __name__ == "__main__":
    fix_symptom_logs_dao()
    fix_lab_results_dao()
    print("All DAO method implementations fixed!")
