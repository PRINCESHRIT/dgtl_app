# Frontend Requirements - Complete Package List

## 📦 Add These Packages to pubspec.yaml

```yaml
dependencies:
  # Existing dependencies (keep all current ones)
  
  # ADD THESE FOR FRONTEND:
  
  # Data Visualization
  fl_chart: ^0.68.0
  
  # Image & Media
  image_picker: ^1.0.4
  cached_network_image: ^3.3.0
  
  # UI Enhancements  
  flutter_svg: ^2.0.9
  shimmer: ^3.0.0
  
  # Notifications & Local Services
  flutter_local_notifications: ^16.1.0
  
  # Additional Utilities (may be needed)
  file_picker: ^6.1.1
  share_plus: ^7.2.1
  url_launcher: ^6.2.1
```

## 🎯 IMPLEMENTATION ROADMAP

### PHASE 1: Dashboard (Days 1-3)
**Goal**: Replace placeholder with functional dashboard

**Tasks**:
1. Create PatientProfileCard widget
2. Add RecentSymptomsCard widget  
3. Add LatestLabResultsCard widget
4. Integrate with existing database services
5. Add basic navigation improvements

**Backend Integration**:
```dart
// Use existing services
final database = GetIt.instance<AppDatabase>();
final patients = await database.patientsDao.getAllPatients();
final symptoms = await database.symptomLogsDao.getRecentSymptoms(patientId);
```

### PHASE 2: Symptom Logger (Days 4-7)
**Goal**: Functional symptom input with AI features

**Tasks**:
1. Multi-language text input form
2. Severity slider and date picker
3. Photo capture integration
4. AI similarity detection alerts
5. Symptom history list

**Backend Integration**:
```dart
// Use AI services for symptom processing
final embeddingService = GetIt.instance<EmbeddingGemmaService>();
final vectorService = GetIt.instance<VectorSearchService>();
final embedding = await embeddingService.generateEmbedding(symptomText);
final similar = await vectorService.findSimilarSymptoms(embedding);
```

### PHASE 3: AI Chat (Days 8-10)
**Goal**: Working chat interface

**Tasks**:
1. Chat UI with message bubbles
2. Integration with Q&A service
3. Quick question chips
4. Chat history persistence

**Backend Integration**:
```dart
// Use existing RAG service
final ragService = GetIt.instance<Gemma3NRagService>();
final response = await ragService.answerQuestion(question, patientId: 1);
```

### PHASE 4: Data Visualization (Days 11-14)
**Goal**: Charts and trends

**Tasks**:
1. Lab results trend charts
2. Symptom frequency visualization  
3. Correlation analysis displays
4. Export functionality

**Backend Integration**:
```dart
// Use database for trend data
final labResults = await database.labResultsDao.getResultsForTimeRange(
  patientId, startDate, endDate
);
```

## 🔧 TECHNICAL IMPLEMENTATION NOTES

### Service Integration Pattern
```dart
class SymptomLoggerPage extends StatefulWidget {
  @override
  _SymptomLoggerPageState createState() => _SymptomLoggerPageState();
}

class _SymptomLoggerPageState extends State<SymptomLoggerPage> {
  // Get services via dependency injection
  final _database = GetIt.instance<AppDatabase>();
  final _embeddingService = GetIt.instance<EmbeddingGemmaService>();
  final _vectorService = GetIt.instance<VectorSearchService>();
  
  Future<void> _saveSymptom(String description) async {
    try {
      // 1. Generate embedding
      final embedding = await _embeddingService.generateEmbedding(description);
      
      // 2. Check for similar symptoms  
      final similar = await _vectorService.findSimilarSymptoms(embedding);
      
      // 3. Save to database
      final symptom = SymptomLogsCompanion.insert(
        patientId: 1,
        description: description,
        embedding: embedding.join(','),
        timestamp: DateTime.now(),
      );
      await _database.symptomLogsDao.insertSymptomLog(symptom);
      
      // 4. Show UI feedback
      if (similar.isNotEmpty) {
        _showSimilarSymptomsDialog(similar);
      }
    } catch (e) {
      // Handle errors gracefully
      _showErrorDialog('Failed to save symptom: $e');
    }
  }
}
```

### Error Handling Pattern
```dart
// Consistent error handling across the app
Future<T?> safeServiceCall<T>(Future<T> Function() serviceCall) async {
  try {
    return await serviceCall();
  } catch (e) {
    print('Service call failed: $e');
    // Show user-friendly message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Service temporarily unavailable'))
    );
    return null;
  }
}
```

## 📋 IMMEDIATE ACTION ITEMS

### Day 1: Setup
1. Add required packages to pubspec.yaml
2. Run `flutter pub get`
3. Test app still compiles and runs

### Day 2: Dashboard
1. Create `lib/features/dashboard/widgets/` folder
2. Build PatientProfileCard widget
3. Replace placeholder dashboard content
4. Test with real patient data

### Day 3: Symptom Logger  
1. Create symptom input form
2. Add AI similarity detection
3. Test end-to-end symptom logging workflow

## ✅ SUCCESS METRICS

**Week 1 Goals**:
- ✅ Dashboard shows real patient data
- ✅ Symptom logger accepts multilingual input
- ✅ AI provides similarity alerts
- ✅ App works offline for core functions

**Week 2 Goals**:
- ✅ Charts display lab trends
- ✅ AI chat answers patient questions
- ✅ All 5 main features are functional
- ✅ Ready for caregiver beta testing

## 🎨 ENHANCED PLAN RECOMMENDATIONS

### 📋 CRITICAL MISSING ELEMENTS

**1. Emotional Wellness Integration**
```dart
// Enhanced database schema needed for emotional data
class EmotionalData {
  int? id;
  int patientId;
  String mood; // happy, anxious, tired, hopeful
  int moodIntensity; // 1-10 scale
  String? reflection; // daily reflection text
  DateTime timestamp;
  String? triggers; // what caused the mood
}
```

**2. Cultural Sensitivity Enhancements**
```dart
// Enhanced AI service for cultural context
class CulturalAwarenesService {
  // Handle family dynamics: "Maa ki tabiyat", "Baba ka BP"
  Future<String> culturallyAwareResponse(String query, String language);
  
  // Understand Indian medical terms and family relationships
  Map<String, String> familyTermsHindi = {
    'maa': 'mother',
    'papa': 'father', 
    'dadi': 'grandmother',
    'nani': 'maternal grandmother',
  };
}
```

**3. Caregiver-Specific UI Components**
```yaml
# Additional packages needed for enhanced plan
dependencies:
  # Emotional wellness
  flutter_emoji: ^2.4.0
  
  # Enhanced charts for medical data
  syncfusion_flutter_charts: ^23.1.36
  
  # Voice input for elderly users
  speech_to_text: ^6.3.0
  
  # Medication reminders
  timezone: ^0.9.2
  
  # Family sharing
  qr_flutter: ^4.1.0
```

### 🔄 REVISED IMPLEMENTATION PHASES

**PHASE 1A: Emotional Foundation (Days 1-2)**
- Mood logging with cultural emotions (खुशी, चिंता, थकान)
- Daily reflection in Hindi/English
- Emotional trend correlation with symptoms

**PHASE 1B: Medical Dashboard (Days 3-4)**  
- Patient profile with family context
- Symptom logger with emotional correlation
- Cultural greeting system ("Namaste", time-appropriate)

**PHASE 2A: AI Emotional Support (Days 5-7)**
- Culturally aware chat responses
- Emotional pattern recognition
- Family-friendly explanations of medical data

**PHASE 2B: Caregiver Tools (Days 8-10)**
- Multi-patient support (whole family)
- Voice input for elderly users
- Medication reminder system with family notifications

**PHASE 3: Advanced Integration (Days 11-14)**
- Emotional correlation with medical trends
- Family sharing dashboard
- Export reports for doctor visits

### 🎯 ENHANCED SUCCESS METRICS

**Emotional Wellness Goals**:
- ✅ User can log mood in preferred language
- ✅ AI provides culturally sensitive responses  
- ✅ Emotional trends correlate with medical symptoms
- ✅ Family members can share care responsibilities

**Medical Integration Goals**:
- ✅ Seamless switching between emotional and medical tracking
- ✅ Holistic view: "High BP when anxious about Maa"
- ✅ Doctor reports include emotional context

### 🔧 TECHNICAL ARCHITECTURE ENHANCEMENTS

**Enhanced Service Layer**:
```dart
// Emotional wellness service
class EmotionalWellnessService {
  Future<void> logMood(String mood, int intensity, String? reflection);
  Future<List<EmotionalTrend>> getEmotionalTrends(DateTime startDate);
  Future<String> getEmotionalInsight(String medicalSymptom);
}

// Enhanced RAG service with emotional context
class EnhancedRagService extends Gemma3NRagService {
  @override
  Future<String> answerQuestion(String question, {
    int? patientId,
    String? emotionalContext, // NEW: Include mood context
    String? culturalContext,  // NEW: Include family context
  });
}
```

**Enhanced Database Schema**:
```dart
// Add to existing database
@DataClassName('MoodLog')
class MoodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  TextColumn get mood => text()();
  IntColumn get intensity => integer()();
  TextColumn get reflection => text().nullable()();
  TextColumn get triggers => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get language => text().withDefault(const Constant('en'))();
}
```

## 🚀 THE ENHANCED KEY ADVANTAGE

**Your backend + emotional wellness = Complete caregiver solution!** 

The technical infrastructure exists - now we're adding the human-centered emotional layer that makes this app truly supportive for families managing chronic kidney disease.

**This isn't just medical tracking - it's family care management with emotional intelligence.**

Focus on creating a warm, culturally aware companion that understands both "Creatinine level 2.1" and "मैं बहुत चिंतित हूँ" (I'm very worried).
