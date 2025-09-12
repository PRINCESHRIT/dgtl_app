#!/usr/bin/env python3
"""
Fix test file to use existing DAO methods instead of adding new methods
"""

def fix_test_file():
    """Update test file to use existing DAO method names"""
    with open('test/core/database/database_clean_test.dart', 'r') as f:
        content = f.read()
    
    # Replace method calls with existing method names
    
    # For symptom logs: use getRecentLogs instead of getSymptomLogsByPatientId
    content = content.replace(
        'database.symptomLogsDao.getSymptomLogsByPatientId(patientId)',
        'database.symptomLogsDao.getRecentLogs(patientId)'
    )
    
    # For lab tests: use getLabTestByCode or a different method
    # First let's use getAllLabTests and get by index, but better to use getLabTestByCode
    content = content.replace(
        'database.labTestsDao.getLabTest(testId)',
        '(await database.labTestsDao.getAllLabTests()).where((t) => t.id == testId).firstOrNull'
    )
    
    # For lab results: use getRecentResults instead of getLabResultsByPatientId
    content = content.replace(
        'database.labResultsDao.getLabResultsByPatientId(patientId)',
        'database.labResultsDao.getRecentResults(patientId)'
    )
    
    with open('test/core/database/database_clean_test.dart', 'w') as f:
        f.write(content)
    
    print("Fixed test file to use existing DAO methods")

if __name__ == "__main__":
    fix_test_file()
