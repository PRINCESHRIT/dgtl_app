# DGTL Kidney Care: Frontend Engineering Roadmap & Technical Documentation

**Document Version:** 1.0  
**Date:** September 2025  
**Target Audience:** Frontend Engineers & Backend Integration Team  

---

## Executive Summary

This document provides the complete frontend implementation roadmap for DGTL Kidney Care application. The frontend will be built using Flutter, implementing an empathy-first, Hindi-native design system while integrating seamlessly with our production-ready encrypted backend services.

**Core Architecture:** Flutter UI → Riverpod State Management → Direct Backend Service Calls → Encrypted Drift Database

---

## Table of Contents

1. [Architecture Overview](#1-architecture-overview)
2. [Design System Specifications](#2-design-system-specifications)
3. [Component Library](#3-component-library)
4. [Backend Integration Points](#4-backend-integration-points)
5. [Implementation Phases](#5-implementation-phases)
6. [Technical Specifications](#6-technical-specifications)
7. [Performance Guidelines](#7-performance-guidelines)
8. [Testing Strategy](#8-testing-strategy)

---

## 1. Architecture Overview

### 1.1 Technology Stack

**Framework:** Flutter (Dart)  
**State Management:** Riverpod + Provider  
**Database:** Drift (SQLite) with AES-256 encryption  
**AI/ML:** TFLite for on-device processing  
**Localization:** intl package (Hindi-first)  
**Navigation:** go_router  

### 1.2 Folder Structure

```
lib/
├── main.dart                           # App entry point
├── core/
│   ├── theme/                          # Design system
│   │   ├── app_theme.dart             # Main theme configuration
│   │   ├── app_colors.dart            # Color palette
│   │   ├── app_text_styles.dart       # Typography system
│   │   └── app_dimensions.dart        # Spacing & sizing
│   ├── l10n/                          # Localization
│   │   ├── app_localizations.dart     # Generated localizations
│   │   ├── app_en.arb                 # English strings
│   │   └── app_hi.arb                 # Hindi strings (primary)
│   ├── constants/                      # App constants
│   ├── utils/                          # Utility functions
│   └── extensions/                     # Dart extensions
├── features/
│   ├── dashboard/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── dashboard_page.dart
│   │   │   └── widgets/
│   │   │       ├── patient_header.dart
│   │   │       ├── recommendation_card.dart
│   │   │       ├── mood_selector.dart
│   │   │       └── progress_overview.dart
│   │   └── providers/
│   │       └── dashboard_providers.dart
│   ├── symptom_logger/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── symptom_logger_page.dart
│   │   │   └── widgets/
│   │   │       ├── symptom_carousel.dart
│   │   │       ├── bp_logger_slide.dart
│   │   │       ├── vitals_slider_panel.dart
│   │   │       └── custom_keypad.dart
│   │   └── providers/
│   │       └── symptom_providers.dart
│   ├── ai_chat/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── ai_chat_page.dart
│   │   │   └── widgets/
│   │   │       ├── chat_message_list.dart
│   │   │       ├── chat_input.dart
│   │   │       ├── voice_input_button.dart
│   │   │       └── typing_indicator.dart
│   │   └── providers/
│   │       └── chat_providers.dart
│   ├── lab_management/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── lab_overview_page.dart
│   │   │   └── widgets/
│   │   │       ├── lab_countdown_list.dart
│   │   │       ├── lab_upload_dialog.dart
│   │   │       └── progress_indicators.dart
│   │   └── providers/
│   │       └── lab_providers.dart
└── shared/
    ├── widgets/                        # Reusable components
    │   ├── cards/
    │   │   ├── base_card.dart
    │   │   ├── empathy_card.dart
    │   │   └── data_card.dart
    │   ├── buttons/
    │   │   ├── primary_button.dart
    │   │   ├── secondary_button.dart
    │   │   └── icon_button_with_label.dart
    │   ├── inputs/
    │   │   ├── custom_text_field.dart
    │   │   ├── slider_with_labels.dart
    │   │   └── number_keypad.dart
    │   ├── indicators/
    │   │   ├── loading_skeleton.dart
    │   │   ├── progress_bubble.dart
    │   │   └── status_indicator.dart
    │   └── charts/
    │       ├── mini_trend_chart.dart
    │       ├── bubble_grid.dart
    │       └── progress_ring.dart
    └── providers/
        ├── app_providers.dart          # Global providers
        └── theme_provider.dart         # Theme management
```

### 1.3 Data Flow Architecture

```
UI Widget
    ↓
Riverpod Provider (State Management)
    ↓
DgtlClinicalService (Backend API)
    ↓
Drift Database (Encrypted Storage)
    ↓
Stream/Future Response
    ↓
UI Update (Reactive)
```

---

## 2. Design System Specifications

### 2.1 Color Palette

```dart
// lib/core/theme/app_colors.dart
class AppColors {
  // Primary Colors
  static const Color primaryRed = Color(0xFFCF3C3C);
  static const Color primaryRedLight = Color(0xFFE57373);
  static const Color primaryRedDark = Color(0xFFB71C1C);
  
  // Background Colors
  static const Color backgroundCream = Color(0xFFFAF5F3);
  static const Color cardBackground = Color(0xFFF0E6E3);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  
  // Empathy & AI Colors (Special for AI-driven components)
  static const Color empathyTeal = Color(0xFFDDEFEA);
  static const Color empathyTealLight = Color(0xFFE8F5F0);
  static const Color empathyTealDark = Color(0xFFB2DFDB);
  
  // Mood & Emotion Colors
  static const Color moodHappy = Color(0xFFFFE082);      // Yellow
  static const Color moodCalm = Color(0xFF9CCC65);       // Green
  static const Color moodSad = Color(0xFFF8BBD0);        // Pink
  static const Color moodAnxious = Color(0xFFB39DDB);    // Purple
  static const Color moodAngry = Color(0xFFEF9A9A);      // Light Red
  static const Color moodExcited = Color(0xFF90CAF9);    // Blue
  
  // Status Colors
  static const Color statusNormal = Color(0xFF66BB6A);    // Green
  static const Color statusWarning = Color(0xFFFFB74D);   // Orange
  static const Color statusCritical = Color(0xFFE57373);  // Red
  
  // Neutral Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  static const Color divider = Color(0xFFE0E0E0);
}
```

### 2.2 Typography System

```dart
// lib/core/theme/app_text_styles.dart
class AppTextStyles {
  // Font family supporting Hindi Devanagari
  static const String fontFamily = 'Poppins';
  
  // Headers (Hindi-optimized)
  static const TextStyle headerLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle headerMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle headerSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );
  
  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textPrimary,
  );
  
  // Special Styles
  static const TextStyle empathyText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textPrimary,
    fontStyle: FontStyle.italic,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.surfaceWhite,
  );
}
```

---

## 3. Backend Integration Points

### 3.1 Provider Architecture

```dart
// lib/features/dashboard/providers/dashboard_providers.dart
import 'package:riverpod/riverpod.dart';
import '../../../core/services/dgtl_clinical_service.dart';

// Clinical Service Provider
final clinicalServiceProvider = Provider<DgtlClinicalService>((ref) {
  return DgtlClinicalService();
});

// Patient Stats Provider
final patientStatsProvider = StreamProvider.autoDispose<PatientStats>((ref) {
  final service = ref.watch(clinicalServiceProvider);
  return service.getPatientStatsStream();
});

// Recommendations Provider
final recommendationsProvider = FutureProvider.autoDispose<RecommendationData>((ref) {
  final service = ref.watch(clinicalServiceProvider);
  return service.getDailyRecommendations();
});

// Mood Entries Provider
final moodEntriesProvider = StreamProvider.autoDispose<List<MoodEntry>>((ref) {
  final service = ref.watch(clinicalServiceProvider);
  return service.getMoodEntriesStream();
});

// Vitals Provider
final vitalsProvider = StreamProvider.autoDispose<List<VitalReading>>((ref) {
  final service = ref.watch(clinicalServiceProvider);
  return service.getVitalsStream();
});
```

### 3.2 Service Integration Examples

```dart
// Example: Symptom Logging Integration
class SymptomController extends StateNotifier<AsyncValue<void>> {
  final DgtlClinicalService _clinicalService;
  
  SymptomController(this._clinicalService) : super(AsyncValue.data(null));
  
  Future<void> logBloodPressure(int systolic, int diastolic) async {
    state = AsyncValue.loading();
    
    try {
      await _clinicalService.processSymptoms([
        'bp_systolic_$systolic',
        'bp_diastolic_$diastolic',
      ]);
      state = AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> logMood(String moodType, int intensity, String? note) async {
    state = AsyncValue.loading();
    
    try {
      await _clinicalService.processSymptoms([
        'mood_${moodType}_$intensity',
        if (note != null) 'mood_note_$note',
      ]);
      state = AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
```

---

## 4. Implementation Phases

### Phase 1: Foundation & Design System (Week 1)

**Objectives:**
- Set up the design system and theme
- Implement Hindi localization
- Create base components

**Deliverables:**
- [ ] Complete theme system (app_theme.dart, app_colors.dart, etc.)
- [ ] Hindi localization files (app_hi.arb)
- [ ] Base components (BaseCard, EmpathyCard, buttons, inputs)
- [ ] Poppins font integration with Devanagari support

**Backend Integration:**
- Test connection to DgtlClinicalService
- Verify database streams are working

### Phase 2: Core Dashboard (Week 2)

**Objectives:**
- Build the main dashboard page
- Implement patient header and stats
- Create recommendation system integration

**Deliverables:**
- [ ] Dashboard page layout
- [ ] PatientHeader component with live stats
- [ ] RecommendationCard with AI integration
- [ ] Basic navigation structure

**Backend Integration:**
- Connect to patient stats stream
- Integrate with RAG service for recommendations

### Phase 3: Symptom Logging (Week 3)

**Objectives:**
- Build the symptom logging carousel
- Implement BP keypad and vitals sliders
- Create data visualization mini-charts

**Deliverables:**
- [ ] SymptomCarousel with two slides
- [ ] Custom number keypad for BP entry
- [ ] Vitals sliders (swelling, fatigue, etc.)
- [ ] Mini trend charts for historical data
- [ ] Form validation and success feedback

**Backend Integration:**
- Connect to processSymptoms() method
- Stream historical data for charts

### Phase 4: AI Chat System (Week 4)

**Objectives:**
- Build the AI chat interface
- Implement voice input functionality
- Create streaming response handling

**Deliverables:**
- [ ] Chat message list with bubbles
- [ ] Chat input with voice support
- [ ] Streaming response animation
- [ ] Chat history persistence

**Backend Integration:**
- Connect to processChatQuery() streaming method
- Implement voice-to-text for Hindi

### Phase 5: Lab Management (Week 5)

**Objectives:**
- Build lab countdown and upload system
- Implement file upload and AI analysis
- Create progress tracking and reports

**Deliverables:**
- [ ] Lab countdown list with progress bars
- [ ] File upload dialog with preview
- [ ] AI analysis results display
- [ ] PDF report generation

**Backend Integration:**
- Connect to processLabResults() method
- Implement file upload handling

### Phase 6: Testing & Polish (Week 6)

**Objectives:**
- Comprehensive testing
- Performance optimization
- UI/UX refinements
- Accessibility improvements

**Deliverables:**
- [ ] Unit tests for all components
- [ ] Integration tests for key user flows
- [ ] Performance optimization
- [ ] Accessibility compliance
- [ ] Final UI/UX polish

---

## Backend Service Integration Reference

### Required Backend Methods

The frontend expects these methods to be available in DgtlClinicalService:

```dart
// Patient Data
Stream<PatientStats> getPatientStatsStream();
Future<PatientProfile> getPatientProfile();

// Symptoms & Vitals
Future<void> processSymptoms(List<String> symptoms);
Stream<List<VitalReading>> getVitalsStream();
Stream<List<MoodEntry>> getMoodEntriesStream();

// AI & Recommendations
Future<RecommendationData> getDailyRecommendations();
Stream<String> processChatQuery(String query);
Stream<List<ChatMessage>> getChatMessagesStream();

// Lab Management
Future<void> processLabResults(File report);
Stream<List<LabTest>> getLabTestsStream();
Future<String> generateHealthReport();
```

### Data Models Expected by Frontend

```dart
class PatientStats {
  final String patientName;
  final int healthScore;
  final int loginStreak;
  final DateTime lastUpdate;
}

class RecommendationData {
  final String doctorInsight;
  final List<String> recommendations;
  final MealPlan mealPlan;
}

class VitalReading {
  final String type; // 'bp_systolic', 'bp_diastolic', etc.
  final double value;
  final DateTime timestamp;
  final String unit;
}

class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final MessageStatus status;
}
```

---

## Conclusion

This comprehensive frontend roadmap provides everything needed for seamless integration between the Flutter frontend and our existing backend services. The modular architecture, clear component specifications, and detailed integration points ensure that both frontend and backend teams can work efficiently while maintaining code quality and performance.

The Hindi-first, empathy-driven design system ensures that the application meets the customer's requirements while providing an excellent user experience for kidney care patients.

**Next Steps:**
1. Review and approve this roadmap
2. Set up the development environment
3. Begin Phase 1 implementation
4. Establish regular integration testing cycles
5. Plan for user testing and feedback incorporation

---

## 3. Component Library

### 3.1 Core Dashboard Components

#### PatientHeader Widget
```dart
// lib/features/dashboard/widgets/patient_header.dart
class PatientHeader extends ConsumerWidget {
  const PatientHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientStats = ref.watch(patientStatsProvider);
    
    return patientStats.when(
      data: (stats) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'नमस्ते, ${stats.patientName}!',
              style: AppTextStyles.headerMedium,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                  'स्वास्थ्य स्कोर',
                  '${stats.healthScore}/100',
                  AppColors.statusNormal,
                  Icons.favorite,
                ),
                _buildStatCard(
                  'लगातार दिन',
                  '${stats.loginStreak}',
                  AppColors.primaryRed,
                  Icons.calendar_today,
                ),
              ],
            ),
          ],
        ),
      ),
      loading: () => const LoadingSkeleton(height: 120),
      error: (error, _) => ErrorCard(message: error.toString()),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodyMedium),
              Text(value, style: AppTextStyles.headerSmall.copyWith(color: color)),
            ],
          ),
        ],
      ),
    );
  }
}
```

#### RecommendationCard Widget
```dart
// lib/features/dashboard/widgets/recommendation_card.dart
class RecommendationCard extends ConsumerWidget {
  const RecommendationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendations = ref.watch(recommendationsProvider);
    
    return recommendations.when(
      data: (data) => EmpathyCard(
        title: 'आज का सुझाव',
        subtitle: 'डॉ. की सलाह',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.empathyTeal,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                data.doctorInsight,
                style: AppTextStyles.empathyText,
              ),
            ),
            const SizedBox(height: 16),
            ...data.recommendations.map((rec) => _buildRecommendationItem(rec)),
          ],
        ),
      ),
      loading: () => const LoadingSkeleton(height: 200),
      error: (error, _) => ErrorCard(message: error.toString()),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primaryRed,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              recommendation,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3.2 Symptom Logging Components

#### SymptomCarousel Widget
```dart
// lib/features/symptom_logger/widgets/symptom_carousel.dart
class SymptomCarousel extends ConsumerStatefulWidget {
  const SymptomCarousel({super.key});

  @override
  ConsumerState<SymptomCarousel> createState() => _SymptomCarouselState();
}

class _SymptomCarouselState extends ConsumerState<SymptomCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) => 
            ProgressBubble(isActive: index == _currentPage),
          ),
        ),
        const SizedBox(height: 20),
        
        // Carousel Content
        SizedBox(
          height: 400,
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) => setState(() => _currentPage = page),
            children: const [
              BPLoggerSlide(),
              VitalsSliderPanel(),
            ],
          ),
        ),
        
        // Navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage > 0)
              SecondaryButton(
                text: 'पिछला',
                onPressed: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            const Spacer(),
            if (_currentPage < 1)
              PrimaryButton(
                text: 'अगला',
                onPressed: () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
```

#### BPLoggerSlide Widget
```dart
// lib/features/symptom_logger/widgets/bp_logger_slide.dart
class BPLoggerSlide extends ConsumerStatefulWidget {
  const BPLoggerSlide({super.key});

  @override
  ConsumerState<BPLoggerSlide> createState() => _BPLoggerSlideState();
}

class _BPLoggerSlideState extends ConsumerState<BPLoggerSlide> {
  int? systolic;
  int? diastolic;
  bool _isLogging = false;

  @override
  Widget build(BuildContext context) {
    return DataCard(
      title: 'ब्लड प्रेशर',
      subtitle: 'आज का रीडिंग दर्ज करें',
      child: Column(
        children: [
          // BP Display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBPDisplay('सिस्टोलिक', systolic, AppColors.primaryRed),
              Text('/', style: AppTextStyles.headerLarge),
              _buildBPDisplay('डायस्टोलिक', diastolic, AppColors.primaryRedLight),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Custom Keypad
          NumberKeypad(
            onNumberPressed: _onNumberPressed,
            onBackspace: _onBackspace,
            onClear: _onClear,
          ),
          
          const SizedBox(height: 24),
          
          // Submit Button
          PrimaryButton(
            text: _isLogging ? 'सेव हो रहा है...' : 'सेव करें',
            isLoading: _isLogging,
            isEnabled: systolic != null && diastolic != null,
            onPressed: _logBloodPressure,
          ),
        ],
      ),
    );
  }

  Widget _buildBPDisplay(String label, int? value, Color color) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.bodyMedium),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              value?.toString() ?? '--',
              style: AppTextStyles.headerMedium.copyWith(color: color),
            ),
          ),
        ),
      ],
    );
  }

  void _onNumberPressed(int number) {
    // Implementation for number input logic
  }

  void _onBackspace() {
    // Implementation for backspace logic
  }

  void _onClear() {
    setState(() {
      systolic = null;
      diastolic = null;
    });
  }

  Future<void> _logBloodPressure() async {
    if (systolic == null || diastolic == null) return;
    
    setState(() => _isLogging = true);
    
    try {
      final controller = ref.read(symptomControllerProvider.notifier);
      await controller.logBloodPressure(systolic!, diastolic!);
      
      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ब्लड प्रेशर सफलतापूर्वक दर्ज हुआ!')),
      );
    } catch (error) {
      // Show error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('त्रुटि: $error')),
      );
    } finally {
      setState(() => _isLogging = false);
    }
  }
}
```

### 3.3 AI Chat Components

#### AIChatWidget
```dart
// lib/features/ai_chat/widgets/chat_message_list.dart
class ChatMessageList extends ConsumerWidget {
  const ChatMessageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatMessagesProvider);
    
    return messages.when(
      data: (messageList) => ListView.builder(
        reverse: true,
        padding: const EdgeInsets.all(16),
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          final message = messageList[index];
          return ChatBubble(message: message);
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorCard(message: error.toString()),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isUser ? AppColors.primaryRed : AppColors.empathyTeal,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(24),
              topRight: const Radius.circular(24),
              bottomLeft: isUser ? const Radius.circular(24) : Radius.zero,
              bottomRight: isUser ? Radius.zero : const Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isUser ? Colors.white : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _formatTime(message.timestamp),
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  color: isUser 
                    ? Colors.white.withOpacity(0.7)
                    : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'अभी';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} मिनट पहले';
    } else {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}
```

### 3.4 Shared Components

#### EmpathyCard Widget
```dart
// lib/shared/widgets/cards/empathy_card.dart
class EmpathyCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onTap;

  const EmpathyCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.empathyTeal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: AppColors.primaryRed,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.headerSmall),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
```

#### PrimaryButton Widget
```dart
// lib/shared/widgets/buttons/primary_button.dart
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryRed,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.textHint,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(text, style: AppTextStyles.buttonText),
              ],
            ),
      ),
    );
  }
}
```

---

## 6. Technical Specifications

### 6.1 Performance Requirements

- **App Launch Time**: < 2 seconds cold start
- **Database Queries**: < 100ms for local queries
- **AI Responses**: Streaming responses start within 500ms
- **Memory Usage**: < 150MB peak memory consumption
- **Battery Optimization**: Background processing minimized

### 6.2 Security Requirements

- **Data Encryption**: AES-256 encryption for all local data
- **Secure Storage**: Use flutter_secure_storage for sensitive data
- **Network Security**: Certificate pinning for API calls (if any)
- **Biometric Authentication**: Optional fingerprint/face unlock

### 6.3 Accessibility Requirements

- **Screen Reader Support**: Full VoiceOver/TalkBack compatibility
- **High Contrast**: Support for high contrast mode
- **Font Scaling**: Support for system font scaling up to 200%
- **Touch Targets**: Minimum 44pt touch target size
- **Hindi Voice Support**: Voice commands in Hindi language

---

## 7. Performance Guidelines

### 7.1 Widget Optimization

```dart
// Use const constructors wherever possible
const Widget myWidget = MyWidget();

// Implement proper widget keys for list items
ListView.builder(
  itemBuilder: (context, index) => MyListItem(
    key: ValueKey(items[index].id),
    item: items[index],
  ),
);

// Use RepaintBoundary for expensive widgets
RepaintBoundary(
  child: ExpensiveCustomPainter(),
);
```

### 7.2 State Management Optimization

```dart
// Use autoDispose for providers that don't need to persist
final temporaryDataProvider = StreamProvider.autoDispose<Data>((ref) {
  return dataService.getStream();
});

// Implement proper provider dependencies
final dependentProvider = Provider<Service>((ref) {
  final config = ref.watch(configProvider);
  return Service(config);
});
```

### 7.3 Database Optimization

```dart
// Use indexes for frequently queried columns
@TableIndex(name: 'patient_timestamp_idx', columns: {#timestamp})
class VitalReadings extends Table {
  // table definition
}

// Implement proper stream limiting
Stream<List<VitalReading>> getRecentVitals() {
  return (select(vitalReadings)
    ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
    ..limit(50)).watch();
}
```

---

## 8. Testing Strategy

### 8.1 Unit Testing

```dart
// Test providers with ProviderContainer
void main() {
  group('DashboardProviders', () {
    testWidgets('patientStatsProvider should return stats', (tester) async {
      final container = ProviderContainer(
        overrides: [
          clinicalServiceProvider.overrideWithValue(mockClinicalService),
        ],
      );
      
      final stats = await container.read(patientStatsProvider.future);
      expect(stats.patientName, 'Test Patient');
    });
  });
}
```

### 8.2 Integration Testing

```dart
// Test complete user flows
void main() {
  group('Symptom Logging Flow', () {
    testWidgets('should log blood pressure successfully', (tester) async {
      await tester.pumpWidget(MyApp());
      
      // Navigate to symptom logger
      await tester.tap(find.byKey(const Key('symptom_logger_tab')));
      await tester.pumpAndSettle();
      
      // Enter BP values
      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('0'));
      // ... continue test flow
      
      // Verify success message
      expect(find.text('ब्लड प्रेशर सफलतापूर्वक दर्ज हुआ!'), findsOneWidget);
    });
  });
}
```

### 8.3 Performance Testing

```dart
// Test widget performance
void main() {
  testWidgets('Dashboard should render smoothly', (tester) async {
    await tester.pumpWidget(MyApp());
    
    // Measure frame rendering times
    await tester.binding.setSurfaceSize(const Size(375, 812));
    await tester.pumpAndSettle();
    
    final timeline = await tester.binding.traceAction(() async {
      // Perform scrolling actions
      await tester.fling(find.byType(ListView), const Offset(0, -300), 1000);
      await tester.pumpAndSettle();
    });
    
    // Assert smooth rendering (< 16ms per frame)
    final frames = timeline.events.where((event) => event.name == 'Frame');
    for (final frame in frames) {
      expect(frame.duration.inMilliseconds, lessThan(16));
    }
  });
}
```

---

## Development Checklist

### Pre-Development Setup
- [ ] Flutter SDK 3.16+ installed
- [ ] Dart 3.2+ configured
- [ ] VS Code with Flutter/Dart extensions
- [ ] Android Studio/Xcode for device testing
- [ ] Git repository initialized with proper .gitignore

### Week 1 Checklist
- [ ] Theme system implemented and tested
- [ ] Hindi localization working
- [ ] Base components created
- [ ] Navigation structure established
- [ ] Backend service connection verified

### Week 2 Checklist
- [ ] Dashboard layout completed
- [ ] Patient stats integration working
- [ ] Recommendation system connected
- [ ] Basic state management tested
- [ ] Performance benchmarks established

### Week 3 Checklist
- [ ] Symptom logging carousel functional
- [ ] BP keypad input working
- [ ] Vitals sliders implemented
- [ ] Data persistence verified
- [ ] User feedback mechanisms working

### Week 4 Checklist
- [ ] AI chat interface completed
- [ ] Voice input functionality working
- [ ] Streaming responses implemented
- [ ] Chat history persistence working
- [ ] Error handling for AI responses

### Week 5 Checklist
- [ ] Lab management system functional
- [ ] File upload working
- [ ] AI analysis integration complete
- [ ] Progress tracking implemented
- [ ] Report generation working

### Week 6 Checklist
- [ ] All unit tests passing
- [ ] Integration tests completed
- [ ] Performance optimization done
- [ ] Accessibility compliance verified
- [ ] Final UI/UX review completed

---

**Document Status**: Complete  
**Last Updated**: September 2025  
**Review Required**: Yes (before implementation begins)

For questions or clarifications, contact the backend team for service integration details or the design team for UI/UX specifications.
