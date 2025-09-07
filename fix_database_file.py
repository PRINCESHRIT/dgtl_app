#!/usr/bin/env python3
"""
Fix database.dart file issues
"""

def fix_database_dart():
    """Fix duplicate DAOs and inconsistent naming in database.dart"""
    with open('lib/core/database/database.dart', 'r') as f:
        content = f.read()
    
    # Replace the entire daos section with the correct, non-duplicate list
    import re
    
    # Find the daos section and replace it
    dao_pattern = r'daos: \[(.*?)\],'
    
    # Define the correct DAO list
    correct_daos = """daos: [
    PatientsDao,
    SymptomLogsDao,
    LabTestsDao,
    LabResultsDao,
    ScheduledTestsDao,
    AiInsightsDao,
    EmbeddingCacheDao,
  ],"""
    
    # Replace the daos section
    content = re.sub(dao_pattern, correct_daos, content, flags=re.DOTALL)
    
    with open('lib/core/database/database.dart', 'w') as f:
        f.write(content)
    
    print("Fixed database.dart DAO duplicates and naming issues")

if __name__ == "__main__":
    fix_database_dart()
