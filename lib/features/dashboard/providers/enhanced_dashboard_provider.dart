// Enhanced dashboard provider integrating existing services with new UI
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/dgtl_clinical_service.dart';
import '../models/dashboard_models.dart';

// Provider for dashboard state with empathy-driven enhancements
final enhancedDashboardProvider = StateNotifierProvider<EnhancedDashboardNotifier, EnhancedDashboardState>((ref) {
  return EnhancedDashboardNotifier(ref);
});

class EnhancedDashboardNotifier extends StateNotifier<EnhancedDashboardState> {
  final Ref ref;
  
  EnhancedDashboardNotifier(this.ref) : super(const EnhancedDashboardState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // Get patient data from existing DgtlClinicalService
      final clinicalService = ref.read(dgtlClinicalServiceProvider);
      
      // Load medical data with empathy context
      final medicalData = await _loadMedicalDataWithEmpathy();
      final empathyGreeting = _generateEmpathyGreeting();
      final moodSuggestion = _getMoodBasedSuggestion();
      
      state = state.copyWith(
        isLoading: false,
        empathyGreeting: empathyGreeting,
        medicalCards: medicalData,
        moodSuggestion: moodSuggestion,
        lastUpdated: DateTime.now(),
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: error.toString(),
      );
    }
  }

  Future<List<MedicalCardData>> _loadMedicalDataWithEmpathy() async {
    // Simulated integration with your existing medical data
    // In real implementation, this would pull from DgtlClinicalService
    return [
      MedicalCardData(
        id: 'bp',
        label: 'रक्तचाप',
        value: '120',
        unit: '/80 mmHg',
        status: 'normal',
        icon: 'heart',
        empathyMessage: 'आपका रक्तचाप सामान्य है, बहुत अच्छा!',
        lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      MedicalCardData(
        id: 'glucose',
        label: 'ग्लूकोज',
        value: '95',
        unit: 'mg/dL',
        status: 'excellent',
        icon: 'glucose',
        empathyMessage: 'आपकी शुगर बिलकुल नियंत्रण में है',
        lastUpdated: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      MedicalCardData(
        id: 'kidney',
        label: 'किडनी फंक्शन',
        value: '85',
        unit: '%',
        status: 'normal',
        icon: 'kidney',
        empathyMessage: 'आपकी किडनी अच्छी तरह काम कर रही है',
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];
  }

  String _generateEmpathyGreeting() {
    final hour = DateTime.now().hour;
    final greetings = [
      'सुप्रभात! आज आपका स्वास्थ्य कैसा है?',
      'नमस्ते! आप कैसा महसूस कर रहे हैं?',
      'शुभ संध्या! आज कैसा रहा?',
    ];
    
    if (hour < 12) return greetings[0];
    if (hour < 17) return greetings[1];
    return greetings[2];
  }

  String _getMoodBasedSuggestion() {
    final suggestions = [
      'आज पानी पीना न भूलें',
      'थोड़ी देर टहलने जाएं',
      'गहरी सांस लेकर आराम करें',
      'अपनी दवा का समय हो गया है',
    ];
    
    return suggestions[DateTime.now().hour % suggestions.length];
  }

  Future<void> refreshData() async {
    await _initialize();
  }

  void updateMood(String mood) {
    state = state.copyWith(currentMood: mood);
    // In real implementation, save to your existing database
  }

  void recordSymptom(String symptom) {
    final updatedSymptoms = [...state.todaySymptoms, symptom];
    state = state.copyWith(todaySymptoms: updatedSymptoms);
    // In real implementation, save to your Drift database
  }
}

// Enhanced dashboard state
class EnhancedDashboardState {
  final bool isLoading;
  final String? error;
  final String empathyGreeting;
  final List<MedicalCardData> medicalCards;
  final String moodSuggestion;
  final String? currentMood;
  final List<String> todaySymptoms;
  final DateTime? lastUpdated;

  const EnhancedDashboardState({
    this.isLoading = false,
    this.error,
    this.empathyGreeting = '',
    this.medicalCards = const [],
    this.moodSuggestion = '',
    this.currentMood,
    this.todaySymptoms = const [],
    this.lastUpdated,
  });

  EnhancedDashboardState copyWith({
    bool? isLoading,
    String? error,
    String? empathyGreeting,
    List<MedicalCardData>? medicalCards,
    String? moodSuggestion,
    String? currentMood,
    List<String>? todaySymptoms,
    DateTime? lastUpdated,
  }) {
    return EnhancedDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      empathyGreeting: empathyGreeting ?? this.empathyGreeting,
      medicalCards: medicalCards ?? this.medicalCards,
      moodSuggestion: moodSuggestion ?? this.moodSuggestion,
      currentMood: currentMood ?? this.currentMood,
      todaySymptoms: todaySymptoms ?? this.todaySymptoms,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
