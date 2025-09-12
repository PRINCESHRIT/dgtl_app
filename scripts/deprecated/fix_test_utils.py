#!/usr/bin/env python3
"""
Fix test_utils.dart issues
"""

def fix_test_utils():
    """Fix import conflicts and parameter naming in test_utils.dart"""
    with open('test/test_utils.dart', 'r') as f:
        content = f.read()
    
    # Fix the import conflict with isNotNull
    # Remove the hide clause and use proper importing
    content = content.replace(
        "import 'package:flutter_test/flutter_test.dart' hide isNotNull;",
        "import 'package:flutter_test/flutter_test.dart';"
    )
    content = content.replace(
        "import 'package:matcher/matcher.dart' show isNotNull;",
        "import 'package:matcher/matcher.dart' as matcher;"
    )
    
    # Fix the dueDate parameter to nextDueDate in createTestScheduledTest
    content = content.replace(
        "dueDate: Value(DateTime.now().add(Duration(days: 30))),",
        "nextDueDate: Value(DateTime.now().add(Duration(days: 30))),"
    )
    
    # Add missing required parameters for ScheduledTestsCompanion
    scheduled_test_method = '''  /// Create a test scheduled test
  static ScheduledTestsCompanion createTestScheduledTest(int patientId, int labTestId) {
    return ScheduledTestsCompanion(
      patientId: Value(patientId),
      labTestId: Value(labTestId),
      frequency: Value('Monthly'),
      nextDueDate: Value(DateTime.now().add(Duration(days: 30))),
      isActive: Value(true),
      reminderDaysBefore: Value(3),
      priority: Value('Medium'),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }'''
    
    # Replace the createTestScheduledTest method
    import re
    pattern = r'  /// Create a test scheduled test\s*static ScheduledTestsCompanion createTestScheduledTest.*?\n  \}'
    content = re.sub(pattern, scheduled_test_method, content, flags=re.DOTALL)
    
    with open('test/test_utils.dart', 'w') as f:
        f.write(content)
    
    print("Fixed test_utils.dart import conflicts and parameter naming")

if __name__ == "__main__":
    fix_test_utils()
