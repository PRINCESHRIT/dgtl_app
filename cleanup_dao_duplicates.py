#!/usr/bin/env python3
"""
Clean up DAO duplicate methods that cause compilation errors
"""

def cleanup_symptom_logs_dao():
    """Remove duplicate/problematic methods from symptom_logs_dao.dart"""
    with open('lib/core/database/daos/symptom_logs_dao.dart', 'r') as f:
        content = f.read()
    
    # Remove the duplicate test compatibility methods section
    lines = content.split('\n')
    cleaned_lines = []
    skip_section = False
    
    for line in lines:
        # Skip the duplicate test compatibility methods
        if '// Test compatibility methods' in line:
            if not skip_section:
                skip_section = True
                continue
            else:
                # This is the second occurrence, skip it and everything after until class end
                continue
        
        if skip_section:
            # Skip until we find the class end
            if line.strip() == '}' and not line.strip().endswith(');'):
                cleaned_lines.append(line)
                break
            continue
        
        cleaned_lines.append(line)
    
    content = '\n'.join(cleaned_lines)
    
    with open('lib/core/database/daos/symptom_logs_dao.dart', 'w') as f:
        f.write(content)
    
    print("Cleaned symptom_logs_dao.dart")

def cleanup_lab_results_dao():
    """Remove duplicate/problematic methods from lab_results_dao.dart"""
    with open('lib/core/database/daos/lab_results_dao.dart', 'r') as f:
        content = f.read()
    
    # Remove the duplicate test compatibility methods section
    lines = content.split('\n')
    cleaned_lines = []
    skip_section = False
    
    for line in lines:
        # Skip the duplicate test compatibility methods
        if '// Test compatibility methods' in line:
            if not skip_section:
                skip_section = True
                continue
            else:
                # This is the second occurrence, skip it and everything after until class end
                continue
        
        if skip_section:
            # Skip until we find the class end
            if line.strip() == '}' and not line.strip().endswith(');'):
                cleaned_lines.append(line)
                break
            continue
        
        cleaned_lines.append(line)
    
    content = '\n'.join(cleaned_lines)
    
    with open('lib/core/database/daos/lab_results_dao.dart', 'w') as f:
        f.write(content)
    
    print("Cleaned lab_results_dao.dart")

if __name__ == "__main__":
    cleanup_symptom_logs_dao()
    cleanup_lab_results_dao()
    print("All DAO files cleaned!")
