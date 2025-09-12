# Fix database DAO registration
with open('lib/core/database/database.dart', 'r') as f:
    content = f.read()

# Add missing DAOs to the list
content = content.replace(
    '''  daos: [
    PatientsDao,
    SymptomLogsDao,
    LabTestsDao,
    LabResultsDao,
    ScheduledTestsDao,''',
    '''  daos: [
    PatientsDao,
    SymptomLogsDao,
    LabTestsDao,
    LabResultsDao,
    ScheduledTestsDao,
    AiInsightsDao,
    EmbeddingCacheDao,'''
)

with open('lib/core/database/database.dart', 'w') as f:
    f.write(content)

print("Added missing DAOs to database registration")
