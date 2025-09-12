#!/usr/bin/env python3
"""
Fix test file issues
"""

def fix_test_file():
    """Fix test file import conflicts, parameter naming and DAO access"""
    with open('test/core/database/database_clean_test.dart', 'r') as f:
        content = f.read()
    
    # Fix import conflicts - use proper namespace for isNotNull
    content = content.replace(
        "import 'package:flutter_test/flutter_test.dart' hide isNotNull;",
        "import 'package:flutter_test/flutter_test.dart';"
    )
    content = content.replace(
        "import 'package:matcher/matcher.dart' show isNotNull;",
        "import 'package:matcher/matcher.dart' as matcher;"
    )
    
    # Replace all isNotNull with matcher.isNotNull
    import re
    content = re.sub(r'\bisNotNull\b', 'matcher.isNotNull', content)
    
    # Fix the value parameter to result in createTestLabResult call
    content = content.replace(
        'TestUtils.createTestLabResult(patientId, testId, value: 1.5)',
        'TestUtils.createTestLabResult(patientId, testId, result: 1.5)'
    )
    
    # Fix the expectation to use 'result' field instead of 'value' field
    content = content.replace(
        'expect(results.first.value, equals(1.5))',
        'expect(results.first.result, equals(1.5))'
    )
    
    with open('test/core/database/database_clean_test.dart', 'w') as f:
        f.write(content)
    
    print("Fixed test file import conflicts and parameter naming")

if __name__ == "__main__":
    fix_test_file()
