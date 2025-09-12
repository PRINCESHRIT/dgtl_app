# DGTL Pastel Minimalist Development Plan
# Single Page Dashboard with Playful Analytics

## 🎯 CLEAR VISION
**"Pastel minimalism with empathetic doodle illustrations for a calming, culturally-aware experience"**

## 📋 SIMPLE IMPLEMENTATION PLAN

### Single Page Layout Structure
1. **Personalized Greeting Hero Section**
2. **Dashboard Card 1**: BP/Symptom Logger with Numeric Keypad
3. **Dashboard Card 2**: AI Personal Tips/Recommendations  
4. **Dashboard Card 3**: Vital Tracker with Report Features

### Day 1: Project Setup & Design System
```yaml
# Add to pubspec.yaml
dependencies:
  # UI & Design
  flutter_svg: ^2.0.9          # Doodle illustrations
  google_fonts: ^6.1.0         # Typography
  flutter_animate: ^4.2.0      # Smooth animations
  
  # Data visualization (playful, not rigid)
  fl_chart: ^0.68.0            # Bubble charts
  
  # File handling for reports
  file_picker: ^6.1.1          # Upload reports
  path_provider: ^2.1.1        # File storage
  share_plus: ^7.2.1           # Download/share
```

### Day 2: Personalized Greeting Hero Section
```dart
class PersonalizedGreetingHero extends StatelessWidget {
  // "Namaste Shriti! आज Maa कैसी हैं?" 
  // Soft pastel background with doodle illustration
  // Time-appropriate cultural greetings
  // Smooth fade-in animation
}
```

### Day 3: Dashboard Card 1 - BP/Symptom Logger
```dart
class BPSymptomLoggerCard extends StatelessWidget {
  // Pastel card with rounded corners
  // Numeric keypad with bubble-style buttons
  // Visual BP indicator (not rigid charts)
  // AI tips: "आपका BP pattern shows..."
  // Culturally appropriate recommendations
}
```

### Day 4: Dashboard Card 2 - AI Personal Tips
```dart
class AIPersonalTipsCard extends StatelessWidget {
  // Doodle illustration of caring figure
  // Personalized insights from RAG pipeline
  // Cultural context: "Maa के लिए आज का सुझाव"
  // Playful bubble design for tips
  // Smooth card animations
}
```

### Day 5: Dashboard Card 3 - Vital Tracker
```dart
class VitalTrackerCard extends StatelessWidget {
  // Hindi/English vital names:
  // - Creatinine (क्रिएटिनिन)
  // - eGFR (eGFR) 
  // - Potassium (पोटेशियम)
  // - Urine Albumin (यूरिन एल्ब्यूमिन)
  // - Hemoglobin (हीमोग्लोबिन)
  // - Calcium (कैल्शियम)
  // - Phosphorus (फास्फोरस)
  
  // Bubble-based analytics (not rigid charts)
  // Upload/Download report features
  // Playful progress indicators
}
```

## 🎨 PASTEL MINIMALIST DESIGN SYSTEM

### Color Palette (Consistent Emotion Mapping)
```dart
class PastelColors {
  // Base pastel system
  static const peachCream = Color(0xFFFFF2E7);      // Background
  static const softWhite = Color(0xFFFAFAFA);       // Cards
  static const pastelMint = Color(0xFFE8F5E8);      // Success/Good
  static const mutedBlack = Color(0xFF2C2C2C);      // Text
  
  // Emotion mapping (consistent across all UI)
  static const calmBlue = Color(0xFFE3F2FD);        // Calm, medical info
  static const hopefulGreen = Color(0xFFE8F5E8);    // Positive, improving
  static const worriedYellow = Color(0xFFFFF9C4);   // Caution, attention needed
  static const anxiousRose = Color(0xFFFFEBEE);     // Concern, high values
  
  // Cultural accents
  static const warmSaffron = Color(0xFFFFE0B2);     // Important highlights
}
```

### Typography (Hindi + English Support)
```dart
class PastelTextStyles {
  static TextStyle greeting = GoogleFonts.inter(
    fontSize: 24, fontWeight: FontWeight.w600, color: PastelColors.mutedBlack
  );
  
  static TextStyle hindiText = GoogleFonts.notoSansDevanagari(
    fontSize: 16, fontWeight: FontWeight.w400, color: PastelColors.mutedBlack
  );
  
  static TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 18, fontWeight: FontWeight.w500, color: PastelColors.mutedBlack
  );
}
```

### Component Design Specifications

**1. Pastel Card Container**
```dart
class PastelCard extends StatelessWidget {
  // Soft rounded corners (BorderRadius.circular(20))
  // Subtle shadow with pastel colors
  // Smooth fade-in animation
  // Consistent padding and margins
}
```

**2. Bubble Analytics (Replace Rigid Charts)**
```dart
class BubbleAnalytics extends StatelessWidget {
  // Circular progress indicators with doodle centers
  // Animated bubble growth for values
  // Color-coded by emotion mapping
  // Playful bounce animations
}
```

**3. Numeric Keypad (Bubble Style)**
```dart
class BubbleNumericKeypad extends StatelessWidget {
  // Circular buttons with pastel colors
  // Gentle tap animations
  // Large, accessible touch targets
  // Cultural number support (Hindi numerals optional)
}
```

**4. Doodle Illustrations**
```dart
class DoodleIllustrations {
  // SVG line-art style illustrations
  // Single accent color (warm saffron)
  // Caring, empathetic figures
  // Family-appropriate imagery
  // Simple, non-intimidating medical symbols
}
```

## 🔧 SIMPLE TECHNICAL INTEGRATION

### Single Page Structure
```dart
class SinglePageDashboard extends StatefulWidget {
  @override
  _SinglePageDashboardState createState() => _SinglePageDashboardState();
}

class _SinglePageDashboardState extends State<SinglePageDashboard> {
  // Use existing backend services
  final _database = GetIt.instance<AppDatabase>();
  final _ragService = GetIt.instance<Gemma3NRagService>();
  final _embeddingService = GetIt.instance<EmbeddingGemmaService>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PastelColors.peachCream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PersonalizedGreetingHero(),
            SizedBox(height: 20),
            BPSymptomLoggerCard(),
            SizedBox(height: 20), 
            AIPersonalTipsCard(),
            SizedBox(height: 20),
            VitalTrackerCard(),
          ],
        ),
      ),
    );
  }
}
```

### Information Hierarchy (Simple)
```dart
// Check-in → Progress → Learning modules
enum DashboardSection {
  checkIn,    // Greeting + current status
  progress,   // BP/Symptoms with bubble analytics  
  learning,   // AI tips + vital tracking
}
```

### Backend Integration (Use Existing Services)
```dart
// No new services needed - use what's already built
class DashboardController {
  // Get personalized greeting
  Future<String> getPersonalizedGreeting() async {
    final patient = await _database.patientsDao.getPatient(1);
    final timeGreeting = _getTimeBasedGreeting();
    return "$timeGreeting ${patient.name}! आज Maa कैसी हैं?";
  }
  
  // Get AI recommendations using existing RAG service
  Future<String> getPersonalizedTips() async {
    return await _ragService.answerQuestion(
      "आज के लिए क्या सुझाव है?", 
      patientId: 1
    );
  }
}
```

## 🎯 SIMPLE SUCCESS GOALS

### User Experience Goals
- ✅ Single page, intuitive navigation
- ✅ Calming pastel aesthetics with doodle illustrations
- ✅ Personalized cultural greetings: "Namaste Shriti!"
- ✅ Bubble-based playful analytics (not intimidating charts)
- ✅ Hindi/English vital names: Creatinine (क्रिएटिनिन)

### Functionality Goals  
- ✅ BP logging with numeric keypad
- ✅ AI personal tips culturally appropriate
- ✅ Vital tracking with report upload/download
- ✅ Smooth animations and transitions
- ✅ Consistent emotion color mapping

### Technical Goals
- ✅ Use existing backend services (no new complexity)
- ✅ Clean single-page architecture
- ✅ Efficient file handling for reports
- ✅ Responsive design with accessibility

## 🚀 IMPLEMENTATION READINESS

**Your Plan**: Pastel minimalism + doodle illustrations + cultural sensitivity
**Your Backend**: Already functional with AI services and database
**Implementation**: 5 days to complete single-page dashboard

**Next Steps**:
1. Add required packages to pubspec.yaml
2. Create pastel design system with color constants
3. Build PersonalizedGreetingHero component
4. Implement 3 dashboard cards with existing backend integration
5. Add doodle SVG illustrations and bubble analytics

**Ready to start building this calm, empathetic interface?**
