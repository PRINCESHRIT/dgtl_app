import os
import re

def fix_test_file(filepath):
    print(f"Fixing {filepath}...")
    
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Fix imports
    content = re.sub(
        r"import 'package:flutter_test/flutter_test.dart';",
        "import 'package:flutter_test/flutter_test.dart' hide isNotNull;",
        content
    )
    
    # Add proper test imports
    if "import '../../../lib/core/database/database.dart';" in content:
        content = content.replace(
            "import '../../../lib/core/database/database.dart';",
            "import '../../../lib/core/database/database.dart';\nimport '../../test_utils.dart';\nimport 'package:matcher/matcher.dart' show isNotNull;"
        )
    elif "import '../lib/core/database/database.dart';" in content:
        content = content.replace(
            "import '../lib/core/database/database.dart';",
            "import '../lib/core/database/database.dart';\nimport 'test_utils.dart';\nimport 'package:matcher/matcher.dart' show isNotNull;"
        )
    
    # Fix LabTest.name -> LabTest.testName
    content = re.sub(r'\.name', '.testName', content)
    
    # Fix AppDatabase() constructor calls - remove arguments
    content = re.sub(r'AppDatabase\(NativeDatabase\.memory\(\)\)', 'TestUtils.createTestDatabase()', content)
    
    # Fix Value() function calls for test data creation
    content = re.sub(r'const PatientsCompanion\(([^)]+)\)', r'TestUtils.createTestPatient()', content)
    
    # Fix database test instantiation
    if 'NativeDatabase.memory()' in content:
        content = content.replace('NativeDatabase.memory()', 'TestUtils.createTestDatabase()')
    
    with open(filepath, 'w') as f:
        f.write(content)
    
    print(f"Fixed {filepath}")

# Fix all test files
test_files = [
    'test/core/database/database_test.dart',
    'test/core/database/database_encryption_test.dart', 
    'test/core/database/patients_dao_test.dart',
    'test/database_test.dart'
]

for test_file in test_files:
    if os.path.exists(test_file):
        fix_test_file(test_file)
    else:
        print(f"File {test_file} not found")

print("All test files processed")
