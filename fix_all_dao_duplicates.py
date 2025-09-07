#!/usr/bin/env python3
"""
Fix all DAO duplicate methods systematically
"""

import re

def fix_patients_dao():
    """Remove duplicate methods in patients_dao.dart"""
    with open('lib/core/database/daos/patients_dao.dart', 'r') as f:
        content = f.read()
    
    # Remove the second occurrence of duplicate methods
    # Pattern: Find and remove the duplicate block starting from the second "// Test compatibility methods"
    lines = content.split('\n')
    
    # Find the first occurrence of "// Test compatibility methods"
    first_test_comment = -1
    second_test_comment = -1
    
    for i, line in enumerate(lines):
        if "// Test compatibility methods" in line:
            if first_test_comment == -1:
                first_test_comment = i
            else:
                second_test_comment = i
                break
    
    if second_test_comment != -1:
        # Remove everything from the second comment to the end (before the closing brace)
        # Find the last closing brace
        last_brace = -1
        for i in range(len(lines) - 1, -1, -1):
            if '}' in lines[i] and 'class' not in lines[i]:
                last_brace = i
                break
        
        # Keep everything before the second duplicate block and add back the closing brace
        new_lines = lines[:second_test_comment] + ['}']
        content = '\n'.join(new_lines)
    
    with open('lib/core/database/daos/patients_dao.dart', 'w') as f:
        f.write(content)
    
    print("Fixed patients_dao.dart duplicate methods")

def fix_symptom_logs_dao():
    """Fix duplicate methods and wrong method calls in symptom_logs_dao.dart"""
    with open('lib/core/database/daos/symptom_logs_dao.dart', 'r') as f:
        content = f.read()
    
    # Remove duplicate methods
    lines = content.split('\n')
    
    # Find duplicate method definitions and remove them
    new_lines = []
    skip_until_next_method = False
    
    for i, line in enumerate(lines):
        # Skip duplicate getSymptomLogsByPatientId and getRecentSymptomLogs
        if 'getSymptomLogsByPatientId(int patientId) async {' in line and any('getSymptomLogsByPatientId' in prev_line for prev_line in new_lines[-20:]):
            skip_until_next_method = True
            continue
        elif 'getRecentSymptomLogs(int patientId, {int limit = 10}) async {' in line and any('getRecentSymptomLogs' in prev_line for prev_line in new_lines[-20:]):
            skip_until_next_method = True
            continue
        
        # End skipping when we hit the next method or class end
        if skip_until_next_method and ('  }' in line or '  Future<' in line or '}' == line.strip()):
            if '}' in line and 'return' not in line:
                skip_until_next_method = False
            if not skip_until_next_method:
                continue
                
        if not skip_until_next_method:
            new_lines.append(line)
    
    content = '\n'.join(new_lines)
    
    # Fix wrong method calls: getSymptomLogsByPatient -> getSymptomLogsByPatientId  
    content = re.sub(r'getSymptomLogsByPatient\(patientId\)', 'getSymptomLogsByPatientId(patientId)', content)
    
    with open('lib/core/database/daos/symptom_logs_dao.dart', 'w') as f:
        f.write(content)
    
    print("Fixed symptom_logs_dao.dart duplicate methods and method calls")

def fix_lab_results_dao():
    """Fix duplicate methods and wrong method calls in lab_results_dao.dart"""
    with open('lib/core/database/daos/lab_results_dao.dart', 'r') as f:
        content = f.read()
    
    # Remove duplicate methods  
    lines = content.split('\n')
    
    # Find duplicate method definitions and remove them
    new_lines = []
    skip_until_next_method = False
    
    for i, line in enumerate(lines):
        # Skip duplicate getLabResultsByPatientId
        if 'getLabResultsByPatientId(int patientId) async {' in line and any('getLabResultsByPatientId' in prev_line for prev_line in new_lines[-20:]):
            skip_until_next_method = True
            continue
        
        # End skipping when we hit the next method or class end
        if skip_until_next_method and ('  }' in line or '  Future<' in line or '}' == line.strip()):
            if '}' in line and 'return' not in line:
                skip_until_next_method = False
            if not skip_until_next_method:
                continue
                
        if not skip_until_next_method:
            new_lines.append(line)
    
    content = '\n'.join(new_lines)
    
    # Fix wrong method calls: getLabResultsByPatient -> getLabResultsByPatientId
    content = re.sub(r'getLabResultsByPatient\(patientId\)', 'getLabResultsByPatientId(patientId)', content)
    
    with open('lib/core/database/daos/lab_results_dao.dart', 'w') as f:
        f.write(content)
    
    print("Fixed lab_results_dao.dart duplicate methods and method calls")

if __name__ == "__main__":
    fix_patients_dao()
    fix_symptom_logs_dao() 
    fix_lab_results_dao()
    print("All DAO duplicate methods fixed!")
