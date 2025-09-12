import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'package:dgtl_app/features/dashboard/widgets/polished_pastel_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const SimpleHealthApp());
}

class SimpleHealthApp extends StatelessWidget {
  const SimpleHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'डीजीटल किडनी केयर',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: PastelColors.primary,
          primary: PastelColors.primary,
          secondary: PastelColors.empathyAccent,
          surface: PastelColors.surface,
          background: PastelColors.background,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins', // Excellent Devanagari script support
        textTheme: TextTheme(
          headlineLarge: PastelTextStyles.greeting,
          headlineMedium: PastelTextStyles.hindiHeading,
          bodyLarge: PastelTextStyles.hindiText,
          bodyMedium: PastelTextStyles.cardSubtitle,
        ),
      ),
      home: const SimpleHealthDashboard(),
    );
  }
}

class SimpleHealthDashboard extends StatelessWidget {
  const SimpleHealthDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PastelColors.secondary, // Soft gray for calming canvas
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Greeting Hero with new color scheme - Borderless hero header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      PastelColors.surface,
                      PastelColors.empathy.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  // Removed border to make it feel like a hero header, not a card
                ),
                child: Row(
                  children: [
                    // Left medical examination image - 90x90 size
                    Container(
                      width: 90,
                      height: 90,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/medical_examination_male.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Centered text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "नमस्ते माँ",
                            style: PastelTextStyles.greeting,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "और क्या हाल चाल?",
                            style: PastelTextStyles.hindiText.copyWith(
                              color: PastelColors.secondaryText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Right medical consultation image - 90x90 size
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/medical_consultation.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.8, 0.8)),
                  ],
                ),
              ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2),
              
              const SizedBox(height: 24),
              
              // Combined Symptom Logger Card - BP, Fatigue, Pain, Fluid, Toilet
              const CombinedSymptomsCard(),
              
              const SizedBox(height: 20),
              
              // AI Health Recommendation Card - Empathy-driven design for daily reassurance
              const AIHealthRecommendationCard(),
              
              const SizedBox(height: 20),
              
              // Card #3: Vitals Tracker - CKD "Big 7" Biomarkers with Hindi-first design
              const VitalsTrackerCard(),
            ],
          ),
        ),
      ),
    );
  }
}

// AI Health Recommendation Card - Empathy-driven design for daily reassurance
class AIHealthRecommendationCard extends StatelessWidget {
  const AIHealthRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // The most important design choice - soft, gentle teal/green for calming healing properties
        color: PastelColors.empathy, // Creates a visual "safe space"
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: PastelColors.empathyBorder,
          width: 1,
        ),
        // Subtle shadow for depth without harshness
        boxShadow: [
          BoxShadow(
            color: PastelColors.empathyAccent.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Sparkles icon - communicates "special" or "intelligent" insights
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: const Text(
                  "👨‍⚕️",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "AI हेल्थ सुझाव",
                  style: PastelTextStyles.empathyHeading.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: PastelColors.empathyText,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Section 1: Doctor's Insight - Medical icon grounds advice in medical expertise
          _buildInsightSection(
            icon: Icons.medical_services,
            title: "विशेषज्ञ की राय",
            content: "आपके आज के रक्तचाप और लक्षणों के आधार पर, स्थिति नियंत्रण में है। निरंतर मॉनिटरिंग जारी रखें।",
            isQuote: true, // Italicized to feel like expert's personal analysis
          ),
          
          const SizedBox(height: 20),
          
          // Section 2: Today's Recommendations - Lightbulb for helpful tips
          _buildInsightSection(
            icon: Icons.lightbulb_outline,
            title: "आज के खास सुझाव",
            bullets: [
              "सुबह 6-7 बजे हल्की सैर करें (20-30 मिनट)",
              "दिन भर में 8-10 गिलास पानी पिएं",
              "नमक का सेवन कम से कम करें",
              "तनाव कम करने के लिए गहरी सांस का अभ्यास करें",
              "शाम 6 बजे के बाद भारी भोजन न करें"
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Section 3: Daily Meal Plan - Chef Hat for friendly dietary guidance
          _buildInsightSection(
            icon: Icons.restaurant_menu,
            title: "आज का भोजन प्लान",
            bullets: [
              "सुबह: दलिया + फल + हरी चाय",
              "दोपहर: रोटी + सब्जी + दाल + सलाद",
              "शाम: हर्बल चाय + बिस्कुट (1-2)",
              "रात: हल्का खाना + छाछ"
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Separator for visual break between meal plan and dietary notes
          Container(
            height: 1,
            width: double.infinity,
            color: PastelColors.empathyBorder,
          ),
          
          const SizedBox(height: 16),
          
          // Important dietary notes section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PastelColors.empathyAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: PastelColors.empathyAccent.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: PastelColors.empathyAccent,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "महत्वपूर्ण सुझाव",
                      style: PastelTextStyles.empathyText.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "भोजन के साथ पानी कम पिएं • खाना धीरे-धीरे चबाकर खाएं • खाने के 1 घंटे बाद पानी पिएं",
                  style: PastelTextStyles.empathyText.copyWith(
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildInsightSection({
    required IconData icon,
    required String title,
    String? content,
    List<String>? bullets,
    bool isQuote = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with icon
        Row(
          children: [
            Icon(
              icon,
              color: PastelColors.empathyAccent,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: PastelTextStyles.empathyText.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Content area
        Padding(
          padding: const EdgeInsets.only(left: 32), // Align with icon
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Single content block (for expert insight)
              if (content != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PastelColors.empathyAccent.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PastelColors.empathyAccent.withOpacity(0.15),
                    ),
                  ),
                  child: Text(
                    content,
                    style: PastelTextStyles.empathyText.copyWith(
                      fontSize: 15,
                      height: 1.6,
                      fontStyle: isQuote ? FontStyle.italic : FontStyle.normal, // Italics for quotes
                      fontWeight: isQuote ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              
              // Bulleted list (for recommendations and meal plans)
              if (bullets != null)
                ...bullets.map((bullet) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8, right: 12),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: PastelColors.empathyAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          bullet,
                          style: PastelTextStyles.empathyText.copyWith(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
            ],
          ),
        ),
      ],
    );
  }
}

// Combined Symptoms Card - BP, Fatigue, Pain, Fluid, Toilet in one card
class CombinedSymptomsCard extends StatefulWidget {
  const CombinedSymptomsCard({super.key});

  @override
  State<CombinedSymptomsCard> createState() => _CombinedSymptomsCardState();
}

class _CombinedSymptomsCardState extends State<CombinedSymptomsCard> {
  // BP Logger variables
  String systolic = "";
  String diastolic = "";
  
  // Enhanced BP tracking variables
  String activeField = ""; // Track which field is active for highlighting
  String bpStatus = ""; // Live feedback status
  Color bpStatusColor = Colors.grey;
  
  // Mock BP history data for trend chart (last 7 days)
  final List<Map<String, dynamic>> bpHistory = [
    {"date": "6 सितं", "systolic": 118, "diastolic": 78},
    {"date": "7 सितं", "systolic": 122, "diastolic": 82},
    {"date": "8 सितं", "systolic": 115, "diastolic": 75},
    {"date": "9 सितं", "systolic": 125, "diastolic": 85},
    {"date": "10 सितं", "systolic": 120, "diastolic": 80},
    {"date": "11 सितं", "systolic": 117, "diastolic": 77},
    {"date": "आज", "systolic": 0, "diastolic": 0}, // Today's reading to be updated
  ];
  
  // Additional symptoms variables
  int fatigueLevel = 1; // 1-3 scale
  int painLevel = 1; // 1-3 scale
  String fluidIntake = "";
  String toiletVisits = "";

  @override
  Widget build(BuildContext context) {
    return PolishedPastelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: const Text(
                  "❤️",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "संपूर्ण स्वास्थ्य ट्रैकर",
                  style: PastelTextStyles.cardTitle.copyWith(
                    color: PastelColors.primary, // Primary red for critical health elements
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Section 1: Enhanced BP Monitor with Live Feedback and Trend
          Text(
            "रक्तचाप मॉनिटर",
            style: PastelTextStyles.cardTitle.copyWith(
              fontSize: 16,
              color: PastelColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Enhanced BP Input Row with Active Highlighting
          Row(
            children: [
              Expanded(
                child: _buildEnhancedBPInput(
                  "सिस्टोलिक", 
                  systolic, 
                  (value) {
                    setState(() {
                      systolic = value;
                      _updateBPStatus();
                    });
                  },
                  isActive: activeField == "सिस्टोलिक",
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: PastelColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "/", 
                  style: PastelTextStyles.cardTitle.copyWith(
                    color: PastelColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildEnhancedBPInput(
                  "डायास्टोलिक", 
                  diastolic, 
                  (value) {
                    setState(() {
                      diastolic = value;
                      _updateBPStatus();
                    });
                  },
                  isActive: activeField == "डायास्टोलिक",
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Live Feedback Status - Instant color-coded interpretation
          if (systolic.isNotEmpty || diastolic.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bpStatusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: bpStatusColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: bpStatusColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getBPStatusIcon(),
                      color: bpStatusColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bpStatus,
                          style: PastelTextStyles.cardTitle.copyWith(
                            color: bpStatusColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        if (systolic.isNotEmpty && diastolic.isNotEmpty)
                          Text(
                            _getBPAdvice(),
                            style: PastelTextStyles.caption.copyWith(
                              color: bpStatusColor.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 16),
          
          // Live Trend Chart - Last 7 BP readings
          if (systolic.isNotEmpty && diastolic.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: PastelColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: PastelColors.primary.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: PastelColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "7 दिनों का रुझान",
                        style: PastelTextStyles.cardTitle.copyWith(
                          fontSize: 14,
                          color: PastelColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildBPTrendChart(),
                ],
              ),
            ),
          
          const SizedBox(height: 32),
          
          // Section 2: Fatigue/Tired Slider (1-3 scale)
          _buildSliderSection(
            title: "थकान का स्तर",
            subtitle: "आज आप कितना थका हुआ महसूस कर रहे हैं?",
            value: fatigueLevel,
            onChanged: (value) => setState(() => fatigueLevel = value.round()),
            icon: Icons.battery_2_bar,
            color: Colors.orange,
            labels: ['कम', 'मध्यम', 'अधिक'],
          ),
          
          const SizedBox(height: 24),
          
          // Section 3: Pain Slider (1-3 scale)
          _buildSliderSection(
            title: "दर्द का स्तर",
            subtitle: "आज आपको कितना दर्द हो रहा है?",
            value: painLevel,
            onChanged: (value) => setState(() => painLevel = value.round()),
            icon: Icons.sentiment_dissatisfied,
            color: Colors.orange,
            labels: ['हल्का', 'मध्यम', 'तेज़'],
          ),
          
          const SizedBox(height: 24),
          
          // Section 4: Fluid Intake (Numeric - Liters)
          _buildNumericSection(
            title: "तरल पदार्थ सेवन",
            subtitle: "आज कितने लीटर पानी पिया? (लीटर में)",
            value: fluidIntake,
            onChanged: (value) => setState(() => fluidIntake = value),
            icon: Icons.local_drink,
            color: Colors.orange,
            unit: "लीटर",
          ),
          
          const SizedBox(height: 24),
          
          // Section 5: Toilet Visits (Numeric)
          _buildNumericSection(
            title: "शौचालय की यात्राएं",
            subtitle: "आज कितनी बार शौचालय गए?",
            value: toiletVisits,
            onChanged: (value) => setState(() => toiletVisits = value),
            icon: Icons.wc,
            color: Colors.orange,
            unit: "बार",
          ),
          
          const SizedBox(height: 32),
          
          // Combined Log Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                String bpText = (systolic.isNotEmpty && diastolic.isNotEmpty) 
                  ? "रक्तचाप: $systolic/$diastolic" : "रक्तचाप: दर्ज नहीं";
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$bpText, थकान: $fatigueLevel, दर्द: $painLevel, पानी: ${fluidIntake.isEmpty ? "0" : fluidIntake}L, शौचालय: ${toiletVisits.isEmpty ? "0" : toiletVisits} बार',
                    ),
                    duration: const Duration(seconds: 4),
                    backgroundColor: PastelColors.primary,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PastelColors.primary, // Primary red for critical actions
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Text(
                'सभी लक्षण दर्ज करें',
                style: PastelTextStyles.buttonText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1);
  }
  
  // BP Input Builder (from BP Logger)
  Widget _buildBPInput(String hindiLabel, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hindiLabel,
          style: PastelTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showNumericKeypad(context, hindiLabel, value, onChanged),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: PastelColors.surface, // Card surface color
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: PastelColors.primary.withOpacity(0.2), // Primary red border
              ),
              boxShadow: [
                BoxShadow(
                  color: PastelColors.primary.withOpacity(0.08), // Primary red shadow
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                value.isEmpty ? (hindiLabel == "सिस्टोलिक" ? "120" : "80") : value,
                style: PastelTextStyles.medicalData.copyWith( // Medical data styling
                  fontSize: 20,
                  color: value.isEmpty 
                    ? PastelColors.secondaryText
                    : PastelColors.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Enhanced BP Input Builder with Active Highlighting
  Widget _buildEnhancedBPInput(String hindiLabel, String value, Function(String) onChanged, {required bool isActive}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hindiLabel,
          style: PastelTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: isActive ? PastelColors.primary : PastelColors.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              activeField = hindiLabel;
            });
            _showNumericKeypad(context, hindiLabel, value, onChanged);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 64,
            decoration: BoxDecoration(
              color: PastelColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isActive 
                  ? PastelColors.primary
                  : PastelColors.primary.withOpacity(0.2),
                width: isActive ? 3 : 1,
              ),
              boxShadow: isActive ? [
                BoxShadow(
                  color: PastelColors.primary.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                  spreadRadius: 2,
                ),
              ] : [
                BoxShadow(
                  color: PastelColors.primary.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                value.isEmpty ? (hindiLabel == "सिस्टोलिक" ? "120" : "80") : value,
                style: PastelTextStyles.medicalData.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: value.isEmpty 
                    ? PastelColors.secondaryText.withOpacity(0.6)
                    : PastelColors.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Update BP Status with Live Feedback
  void _updateBPStatus() {
    final sys = int.tryParse(systolic) ?? 0;
    final dia = int.tryParse(diastolic) ?? 0;
    
    if (systolic.isEmpty && diastolic.isEmpty) {
      setState(() {
        bpStatus = "";
        bpStatusColor = Colors.grey;
      });
      return;
    }
    
    if (systolic.isEmpty || diastolic.isEmpty) {
      setState(() {
        bpStatus = "कृपया दोनों वैल्यू दर्ज करें";
        bpStatusColor = Colors.orange;
      });
      return;
    }
    
    // Update today's reading in history for trend chart
    bpHistory.last['systolic'] = sys;
    bpHistory.last['diastolic'] = dia;
    
    if (sys < 90 || dia < 60) {
      setState(() {
        bpStatus = "निम्न रक्तचाप";
        bpStatusColor = Colors.blue;
      });
    } else if (sys <= 120 && dia <= 80) {
      setState(() {
        bpStatus = "सामान्य रक्तचाप";
        bpStatusColor = Colors.green;
      });
    } else if (sys <= 139 || dia <= 89) {
      setState(() {
        bpStatus = "उच्च सामान्य";
        bpStatusColor = Colors.orange;
      });
    } else {
      setState(() {
        bpStatus = "उच्च रक्तचाप";
        bpStatusColor = Colors.red;
      });
    }
  }

  // Get BP Status Icon
  IconData _getBPStatusIcon() {
    if (bpStatusColor == Colors.blue) return Icons.trending_down;
    if (bpStatusColor == Colors.green) return Icons.check_circle;
    if (bpStatusColor == Colors.orange) return Icons.warning;
    if (bpStatusColor == Colors.red) return Icons.priority_high;
    return Icons.info;
  }

  // Get BP Advice
  String _getBPAdvice() {
    if (bpStatusColor == Colors.blue) return "अधिक तरल पदार्थ लें और आराम करें";
    if (bpStatusColor == Colors.green) return "बहुत अच्छा! इसे बनाए रखें";
    if (bpStatusColor == Colors.orange) return "नमक कम करें और नियमित व्यायाम करें";
    if (bpStatusColor == Colors.red) return "तुरंत डॉक्टर से संपर्क करें";
    return "कृपया दोनों मान दर्ज करें";
  }

  // Build BP Trend Chart
  Widget _buildBPTrendChart() {
    return Container(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bpHistory.map((data) {
          final isToday = data['date'] == 'आज';
          final sys = data['systolic'] as int;
          final dia = data['diastolic'] as int;
          final avgBP = (sys + dia) / 2;
          final normalizedHeight = (avgBP / 160) * 80; // Normalize to chart height
          
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // BP Bar
                  Container(
                    height: normalizedHeight.clamp(10.0, 80.0),
                    decoration: BoxDecoration(
                      color: isToday 
                        ? PastelColors.primary 
                        : PastelColors.primary.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: isToday ? [
                        BoxShadow(
                          color: PastelColors.primary.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ] : [],
                    ),
                    width: double.infinity,
                  ),
                  const SizedBox(height: 8),
                  // Date Label
                  Text(
                    data['date'],
                    style: PastelTextStyles.caption.copyWith(
                      fontSize: 10,
                      fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                      color: isToday 
                        ? PastelColors.primary 
                        : PastelColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // BP Values for today
                  if (isToday && sys > 0)
                    Text(
                      "$sys/$dia",
                      style: PastelTextStyles.caption.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: PastelColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // BP Visualizer (from BP Logger)
  Widget _buildBPVisualizer() {
    final bpData = _getBPStatus(int.tryParse(systolic) ?? 0, int.tryParse(diastolic) ?? 0);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bpData['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: bpData['color'].withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            bpData['icon'],
            color: bpData['color'],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bpData['text'],
                  style: PastelTextStyles.cardTitle.copyWith(
                    color: bpData['color'],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  bpData['advice'],
                  style: PastelTextStyles.caption.copyWith(
                    color: bpData['color'].withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Slider Section Builder (from Additional Symptoms)
  Widget _buildSliderSection({
    required String title,
    required String subtitle,
    required int value,
    required Function(double) onChanged,
    required IconData icon,
    required Color color,
    required List<String> labels,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: PastelTextStyles.cardTitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: PastelTextStyles.caption.copyWith(
              color: PastelColors.mutedBlack.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          
          // Custom Slider with Labels
          Column(
            children: [
              // Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: color,
                  inactiveTrackColor: color.withOpacity(0.3),
                  thumbColor: color,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                  overlayColor: color.withOpacity(0.2),
                ),
                child: Slider(
                  value: value.toDouble(),
                  min: 1,
                  max: 3,
                  divisions: 2,
                  onChanged: onChanged,
                ),
              ),
              
              // Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: labels.asMap().entries.map((entry) {
                  int index = entry.key;
                  String label = entry.value;
                  bool isSelected = value == (index + 1);
                  
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? color : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? color : color.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      label,
                      style: PastelTextStyles.caption.copyWith(
                        color: isSelected ? Colors.white : color,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Numeric Section Builder (from Additional Symptoms)
  Widget _buildNumericSection({
    required String title,
    required String subtitle,
    required String value,
    required Function(String) onChanged,
    required IconData icon,
    required Color color,
    required String unit,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: PastelTextStyles.cardTitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: PastelTextStyles.caption.copyWith(
              color: PastelColors.mutedBlack.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          
          // Numeric Input
          GestureDetector(
            onTap: () => _showNumericKeypad(context, title, value, onChanged),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: PastelColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.isEmpty ? "0" : value,
                    style: PastelTextStyles.cardTitle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: value.isEmpty ? PastelColors.secondaryText : color,
                    ),
                  ),
                  Text(
                    unit,
                    style: PastelTextStyles.caption.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Numeric Keypad (from BP Logger)
  void _showNumericKeypad(BuildContext context, String title, String currentValue, Function(String) onChanged) {
    String tempValue = currentValue;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: PastelColors.softWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: PastelColors.mutedBlack.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: PastelTextStyles.cardTitle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: PastelColors.calmBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: PastelColors.calmBlue.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        tempValue.isEmpty ? '0' : tempValue,
                        textAlign: TextAlign.center,
                        style: PastelTextStyles.cardTitle.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: PastelColors.primaryAction,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Numeric Keypad
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Row 1: 1, 2, 3
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('1', () => setModalState(() => tempValue += '1')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('2', () => setModalState(() => tempValue += '2')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('3', () => setModalState(() => tempValue += '3')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 2: 4, 5, 6
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('4', () => setModalState(() => tempValue += '4')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('5', () => setModalState(() => tempValue += '5')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('6', () => setModalState(() => tempValue += '6')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 3: 7, 8, 9
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('7', () => setModalState(() => tempValue += '7')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('8', () => setModalState(() => tempValue += '8')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('9', () => setModalState(() => tempValue += '9')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 4: Clear, 0, Backspace
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('साफ़', () => setModalState(() => tempValue = ''), isSpecial: true),
                            const SizedBox(width: 12),
                            _buildKeypadButton('0', () => setModalState(() => tempValue += '0')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('⌫', () {
                              setModalState(() {
                                if (tempValue.isNotEmpty) {
                                  tempValue = tempValue.substring(0, tempValue.length - 1);
                                }
                              });
                            }, isSpecial: true),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Done Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            onChanged(tempValue);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PastelColors.primaryAction,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'पूर्ण',
                            style: PastelTextStyles.buttonText,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String text, VoidCallback onTap, {bool isSpecial = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isSpecial ? PastelColors.calmBlue.withOpacity(0.1) : PastelColors.softWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSpecial 
                ? PastelColors.calmBlue.withOpacity(0.3)
                : PastelColors.mutedBlack.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: PastelColors.mutedBlack.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: PastelTextStyles.cardTitle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSpecial ? PastelColors.calmBlue : PastelColors.mutedBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getBPStatus(int systolic, int diastolic) {
    if (systolic < 90 || diastolic < 60) {
      return {'text': 'निम्न रक्तचाप', 'color': Colors.blue, 'icon': Icons.trending_down, 'advice': 'अधिक तरल पदार्थ लें'};
    } else if (systolic <= 120 && diastolic <= 80) {
      return {'text': 'सामान्य रक्तचाप', 'color': Colors.green, 'icon': Icons.check_circle, 'advice': 'बहुत अच्छा! इसे बनाए रखें'};
    } else if (systolic <= 139 || diastolic <= 89) {
      return {'text': 'उच्च सामान्य', 'color': Colors.orange, 'icon': Icons.warning, 'advice': 'नमक कम करें, व्यायाम करें'};
    } else {
      return {'text': 'उच्च रक्तचाप', 'color': Colors.red, 'icon': Icons.priority_high, 'advice': 'तुरंत डॉक्टर से मिलें'};
    }
  }
}

class SimpleBPLoggerCard extends StatefulWidget {
  const SimpleBPLoggerCard({super.key});

  @override
  State<SimpleBPLoggerCard> createState() => _SimpleBPLoggerCardState();
}

class _SimpleBPLoggerCardState extends State<SimpleBPLoggerCard> {
  String systolic = "";
  String diastolic = "";

  @override
  Widget build(BuildContext context) {
    return PolishedPastelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PastelColors.primary.withOpacity(0.1), // Primary red background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: PastelColors.primary.withOpacity(0.2),
                  ),
                ),
                child: Icon(
                  Icons.monitor_heart,
                  color: PastelColors.primary, // Primary red for vital metrics
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "रक्तचाप ट्रैकर",
                  style: PastelTextStyles.cardTitle.copyWith(
                    color: PastelColors.primary, // Primary red for critical health elements
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // BP Input Row
          Row(
            children: [
              Expanded(
                child: _buildBPInput("सिस्टोलिक", systolic, (value) => setState(() => systolic = value)),
              ),
              const SizedBox(width: 16),
              Text("/", style: PastelTextStyles.cardTitle),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBPInput("डायास्टोलिक", diastolic, (value) => setState(() => diastolic = value)),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // BP Visualizer
          if (systolic.isNotEmpty && diastolic.isNotEmpty) _buildBPVisualizer(),
          
          const SizedBox(height: 20),
          
          // Log Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('रक्तचाप रिकॉर्ड हो गया!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PastelColors.primary, // Primary red for critical actions
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Text(
                'लक्षण दर्ज करें',
                style: PastelTextStyles.buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBPInput(String hindiLabel, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hindiLabel,
          style: PastelTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showNumericKeypad(context, hindiLabel, value, onChanged),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: PastelColors.surface, // Card surface color
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: PastelColors.primary.withOpacity(0.2), // Primary red border
              ),
              boxShadow: [
                BoxShadow(
                  color: PastelColors.primary.withOpacity(0.08), // Primary red shadow
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                value.isEmpty ? (hindiLabel == "सिस्टोलिक" ? "120" : "80") : value,
                style: PastelTextStyles.medicalData.copyWith( // Medical data styling
                  fontSize: 20,
                  color: value.isEmpty 
                    ? PastelColors.secondaryText
                    : PastelColors.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showNumericKeypad(BuildContext context, String title, String currentValue, Function(String) onChanged) {
    String tempValue = currentValue;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: PastelColors.softWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: PastelColors.mutedBlack.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: PastelTextStyles.cardTitle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: PastelColors.calmBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: PastelColors.calmBlue.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        tempValue.isEmpty ? '0' : tempValue,
                        textAlign: TextAlign.center,
                        style: PastelTextStyles.cardTitle.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: PastelColors.primaryAction,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Numeric Keypad
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Row 1: 1, 2, 3
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('1', () => setModalState(() => tempValue += '1')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('2', () => setModalState(() => tempValue += '2')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('3', () => setModalState(() => tempValue += '3')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 2: 4, 5, 6
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('4', () => setModalState(() => tempValue += '4')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('5', () => setModalState(() => tempValue += '5')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('6', () => setModalState(() => tempValue += '6')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 3: 7, 8, 9
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('7', () => setModalState(() => tempValue += '7')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('8', () => setModalState(() => tempValue += '8')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('9', () => setModalState(() => tempValue += '9')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 4: Clear, 0, Backspace
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('साफ़', () => setModalState(() => tempValue = ''), isSpecial: true),
                            const SizedBox(width: 12),
                            _buildKeypadButton('0', () => setModalState(() => tempValue += '0')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('⌫', () => setModalState(() {
                              if (tempValue.isNotEmpty) {
                                tempValue = tempValue.substring(0, tempValue.length - 1);
                              }
                            }), isSpecial: true),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Done Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            onChanged(tempValue);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PastelColors.primaryAction,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'पूर्ण',
                            style: PastelTextStyles.cardTitle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String label, VoidCallback onTap, {bool isSpecial = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isSpecial 
              ? PastelColors.empathyAccent.withOpacity(0.1)
              : PastelColors.softWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSpecial 
                ? PastelColors.empathyAccent.withOpacity(0.3)
                : PastelColors.mutedBlack.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: PastelColors.mutedBlack.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: PastelTextStyles.cardTitle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSpecial 
                  ? PastelColors.empathyAccent
                  : PastelColors.mutedBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBPVisualizer() {
    final sys = int.tryParse(systolic) ?? 0;
    final dia = int.tryParse(diastolic) ?? 0;
    final status = _getBPStatus(sys, dia);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            status['color'].withOpacity(0.1),
            status['color'].withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: status['color'].withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Reading Display
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: status['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  status['icon'], 
                  color: Colors.white, 
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$sys/$dia mmHg',
                      style: PastelTextStyles.cardTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: PastelColors.mutedBlack,
                      ),
                    ),
                    Text(
                      status['text'],
                      style: PastelTextStyles.cardSubtitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: status['color'],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Health Advice
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PastelColors.softWhite.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: PastelColors.empathyAccent,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    status['advice'],
                    style: PastelTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: PastelColors.mutedBlack.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }
  
  Map<String, dynamic> _getBPStatus(int sys, int dia) {
    if (sys < 90 || dia < 60) {
      return {'text': 'कम रक्तचाप', 'color': Colors.blue, 'icon': Icons.arrow_downward, 'advice': 'नमक और पानी बढ़ाएं'};
    } else if (sys < 120 && dia < 80) {
      return {'text': 'सामान्य रक्तचाप', 'color': Colors.green, 'icon': Icons.check_circle, 'advice': 'बहुत अच्छा! इसे बनाए रखें'};
    } else if (sys <= 139 || dia <= 89) {
      return {'text': 'थोड़ा बढ़ा हुआ', 'color': Colors.orange, 'icon': Icons.warning, 'advice': 'नमक कम करें, व्यायाम करें'};
    } else {
      return {'text': 'उच्च रक्तचाप', 'color': Colors.red, 'icon': Icons.priority_high, 'advice': 'तुरंत डॉक्टर से मिलें'};
    }
  }
}

class AdditionalSymptomsCard extends StatefulWidget {
  const AdditionalSymptomsCard({super.key});

  @override
  State<AdditionalSymptomsCard> createState() => _AdditionalSymptomsCardState();
}

class _AdditionalSymptomsCardState extends State<AdditionalSymptomsCard> {
  int fatigueLevel = 1; // 1-3 scale
  int painLevel = 1; // 1-3 scale
  String fluidIntake = "";
  String toiletVisits = "";

  @override
  Widget build(BuildContext context) {
    return PolishedPastelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PastelColors.empathy.withOpacity(0.7), // Empathy background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: PastelColors.empathyBorder,
                  ),
                ),
                child: Icon(
                  Icons.healing,
                  color: PastelColors.empathyText, // Empathy text color
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "अन्य लक्षण ट्रैकर",
                  style: PastelTextStyles.cardTitle.copyWith(
                    color: PastelColors.empathyText, // Empathy text color
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // 1. Fatigue/Tired Slider (1-3 scale)
          _buildSliderSection(
            title: "थकान का स्तर",
            subtitle: "आज आप कितना थका हुआ महसूस कर रहे हैं?",
            value: fatigueLevel,
            onChanged: (value) => setState(() => fatigueLevel = value.round()),
            icon: Icons.battery_2_bar,
            color: PastelColors.calmBlue,
            labels: ['कम', 'मध्यम', 'अधिक'],
          ),
          
          const SizedBox(height: 24),
          
          // 2. Pain Slider (1-3 scale)
          _buildSliderSection(
            title: "दर्द का स्तर",
            subtitle: "आज आपको कितना दर्द हो रहा है?",
            value: painLevel,
            onChanged: (value) => setState(() => painLevel = value.round()),
            icon: Icons.sentiment_dissatisfied,
            color: Colors.orange,
            labels: ['हल्का', 'मध्यम', 'तेज़'],
          ),
          
          const SizedBox(height: 24),
          
          // 3. Fluid Intake (Numeric - Liters)
          _buildNumericSection(
            title: "तरल पदार्थ सेवन",
            subtitle: "आज कितने लीटर पानी पिया? (लीटर में)",
            value: fluidIntake,
            onChanged: (value) => setState(() => fluidIntake = value),
            icon: Icons.local_drink,
            color: PastelColors.calmBlue,
            unit: "लीटर",
          ),
          
          const SizedBox(height: 24),
          
          // 4. Toilet Visits (Numeric)
          _buildNumericSection(
            title: "शौचालय की यात्राएं",
            subtitle: "आज कितनी बार शौचालय गए?",
            value: toiletVisits,
            onChanged: (value) => setState(() => toiletVisits = value),
            icon: Icons.wc,
            color: PastelColors.hopefulGreen,
            unit: "बार",
          ),
          
          const SizedBox(height: 24),
          
          // Log Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'लक्षण दर्ज हो गए! थकान: $fatigueLevel, दर्द: $painLevel, पानी: ${fluidIntake.isEmpty ? "0" : fluidIntake}L, शौचालय: ${toiletVisits.isEmpty ? "0" : toiletVisits} बार',
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PastelColors.empathyAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Text(
                'अन्य लक्षण दर्ज करें',
                style: PastelTextStyles.cardTitle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1);
  }
  
  Widget _buildSliderSection({
    required String title,
    required String subtitle,
    required int value,
    required Function(double) onChanged,
    required IconData icon,
    required Color color,
    required List<String> labels,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: PastelTextStyles.cardTitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: PastelTextStyles.caption.copyWith(
              color: PastelColors.mutedBlack.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          
          // Custom Slider with Labels
          Column(
            children: [
              // Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: color,
                  inactiveTrackColor: color.withOpacity(0.3),
                  thumbColor: color,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                  overlayColor: color.withOpacity(0.2),
                ),
                child: Slider(
                  value: value.toDouble(),
                  min: 1,
                  max: 3,
                  divisions: 2,
                  onChanged: onChanged,
                ),
              ),
              
              // Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: labels.asMap().entries.map((entry) {
                  int index = entry.key;
                  String label = entry.value;
                  bool isSelected = value == (index + 1);
                  
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? color : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? color : color.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      label,
                      style: PastelTextStyles.caption.copyWith(
                        color: isSelected ? Colors.white : color,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildNumericSection({
    required String title,
    required String subtitle,
    required String value,
    required Function(String) onChanged,
    required IconData icon,
    required Color color,
    required String unit,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: PastelTextStyles.cardTitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: PastelTextStyles.caption.copyWith(
              color: PastelColors.mutedBlack.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          
          // Numeric Input
          GestureDetector(
            onTap: () => _showNumericKeypad(context, title, value, onChanged, unit),
            child: Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: PastelColors.softWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: PastelColors.mutedBlack.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value.isEmpty ? "0" : value,
                    style: PastelTextStyles.cardTitle.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: value.isEmpty 
                        ? PastelColors.mutedBlack.withOpacity(0.4)
                        : color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    unit,
                    style: PastelTextStyles.cardSubtitle.copyWith(
                      color: color.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showNumericKeypad(BuildContext context, String title, String currentValue, Function(String) onChanged, String unit) {
    String tempValue = currentValue;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: PastelColors.softWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: PastelColors.mutedBlack.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: PastelTextStyles.cardTitle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: PastelColors.empathyAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: PastelColors.empathyAccent.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tempValue.isEmpty ? '0' : tempValue,
                            textAlign: TextAlign.center,
                            style: PastelTextStyles.cardTitle.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: PastelColors.empathyAccent,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            unit,
                            style: PastelTextStyles.cardSubtitle.copyWith(
                              color: PastelColors.empathyAccent.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Numeric Keypad (same as BP keypad)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Row 1: 1, 2, 3
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('1', () => setModalState(() => tempValue += '1')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('2', () => setModalState(() => tempValue += '2')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('3', () => setModalState(() => tempValue += '3')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 2: 4, 5, 6
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('4', () => setModalState(() => tempValue += '4')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('5', () => setModalState(() => tempValue += '5')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('6', () => setModalState(() => tempValue += '6')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 3: 7, 8, 9
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('7', () => setModalState(() => tempValue += '7')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('8', () => setModalState(() => tempValue += '8')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('9', () => setModalState(() => tempValue += '9')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 4: Clear, 0, Backspace, Decimal (for fluid intake)
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('साफ़', () => setModalState(() => tempValue = ''), isSpecial: true),
                            const SizedBox(width: 12),
                            _buildKeypadButton('0', () => setModalState(() => tempValue += '0')),
                            const SizedBox(width: 12),
                            if (unit == "लीटर") // Show decimal point only for fluid intake
                              _buildKeypadButton('.', () => setModalState(() {
                                if (!tempValue.contains('.')) tempValue += '.';
                              }))
                            else
                              _buildKeypadButton('⌫', () => setModalState(() {
                                if (tempValue.isNotEmpty) {
                                  tempValue = tempValue.substring(0, tempValue.length - 1);
                                }
                              }), isSpecial: true),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Done Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            onChanged(tempValue);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PastelColors.empathyAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'पूर्ण',
                            style: PastelTextStyles.cardTitle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildKeypadButton(String label, VoidCallback onTap, {bool isSpecial = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isSpecial 
              ? PastelColors.empathyAccent.withOpacity(0.1)
              : PastelColors.softWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSpecial 
                ? PastelColors.empathyAccent.withOpacity(0.3)
                : PastelColors.mutedBlack.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: PastelColors.mutedBlack.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: PastelTextStyles.cardTitle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSpecial 
                  ? PastelColors.empathyAccent
                  : PastelColors.mutedBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Card #3: Vitals Tracker - CKD "Big 7" Biomarkers with Hindi-first design
class VitalsTrackerCard extends StatelessWidget {
  const VitalsTrackerCard({super.key});

  // CKD "Big 7" biomarkers data structure
  static const List<Map<String, dynamic>> vitals = [
    // Kidney Function Primary Indicators
    {
      "name": "Creatinine",
      "hindi": "क्रिएटिनिन",
      "value": "3.2",
      "unit": "mg/dL",
      "normal": "0.7-1.3",
      "status": "high",
      "progress": 0.85
    },
    {
      "name": "eGFR",
      "hindi": "eGFR",
      "value": "27.3",
      "unit": "mL/min",
      "normal": ">60",
      "status": "low",
      "progress": 0.45
    },
    // Electrolyte Balance
    {
      "name": "Potassium",
      "hindi": "पोटेशियम",
      "value": "4.2",
      "unit": "mEq/L",
      "normal": "3.5-5.0",
      "status": "normal",
      "progress": 0.7
    },
    // Protein & Kidney Damage Markers
    {
      "name": "Urine Albumin",
      "hindi": "यूरिन एल्ब्यूमिन",
      "value": "45",
      "unit": "mg/g",
      "normal": "<30",
      "status": "high",
      "progress": 0.9
    },
    // Anemia & Bone Health (CKD Complications)
    {
      "name": "Hemoglobin",
      "hindi": "हीमोग्लोबिन",
      "value": "11.2",
      "unit": "g/dL",
      "normal": "12-16",
      "status": "low",
      "progress": 0.6
    },
    {
      "name": "Calcium",
      "hindi": "कैल्शियम",
      "value": "9.1",
      "unit": "mg/dL",
      "normal": "8.5-10.5",
      "status": "normal",
      "progress": 0.75
    },
    {
      "name": "Phosphorus",
      "hindi": "फास्फोरस",
      "value": "4.8",
      "unit": "mg/dL",
      "normal": "2.5-4.5",
      "status": "high",
      "progress": 0.8
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: PastelColors.mutedBlack.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: PastelColors.mutedBlack.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header with animated icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.monitor_heart,
                  color: PastelColors.wellness,
                  size: 22,
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(duration: 2.seconds, begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1)),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "वाइटल्स ट्रैकर",
                  style: PastelTextStyles.cardTitle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: PastelColors.mutedBlack,
                  ),
                ),
              ),
              // Trend view button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PastelColors.empathyAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: PastelColors.empathyAccent.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  "📈 ट्रेंड देखें",
                  style: PastelTextStyles.cardSubtitle.copyWith(
                    color: PastelColors.empathyAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Vitals Grid - The Big 7 CKD biomarkers
          ...vitals.asMap().entries.map((entry) {
            final index = entry.key;
            final vital = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: _buildVitalCard(vital, index),
            ).animate(delay: (100 * index).ms)
              .fadeIn(duration: 600.ms)
              .slideX(begin: -0.3);
          }).toList(),
          
          const SizedBox(height: 20),
          
          // Action Buttons Row
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  "📤 रिपोर्ट अपलोड",
                  PastelColors.empathyAccent,
                  () {
                    // Handle upload action
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  "📥 रिपोर्ट डाउनलोड",
                  PastelColors.wellness,
                  () {
                    // Handle download action
                  },
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Next test reminder
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PastelColors.empathy,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: PastelColors.empathyBorder,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: PastelColors.empathyAccent,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "📅 अगला टेस्ट: 5 दिन में (18 सितंबर)",
                    style: PastelTextStyles.cardSubtitle.copyWith(
                      color: PastelColors.empathyText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(delay: 400.ms, duration: 600.ms)
      .slideY(begin: 0.3);
  }

  // Build individual vital card
  Widget _buildVitalCard(Map<String, dynamic> vital, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getStatusBackgroundColor(vital['status']),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor(vital['status']).withOpacity(0.3),
        ),
      ),
      child: InkWell(
        onTap: () {
          // Handle tap to expand with detailed trends
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Status icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getStatusColor(vital['status']).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getStatusIcon(vital['status']),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 16),
            // Vital information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hindi name (primary)
                  Text(
                    vital['hindi'],
                    style: PastelTextStyles.cardTitle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: PastelColors.mutedBlack,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // English name (subtitle)
                  Text(
                    vital['name'],
                    style: PastelTextStyles.cardSubtitle.copyWith(
                      fontSize: 12,
                      color: PastelColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Normal range
                  Text(
                    "सामान्य: ${vital['normal']}",
                    style: PastelTextStyles.cardSubtitle.copyWith(
                      fontSize: 11,
                      color: _getStatusColor(vital['status']),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Value and progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Large value display
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: vital['value'],
                        style: PastelTextStyles.cardTitle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _getStatusColor(vital['status']),
                        ),
                      ),
                      TextSpan(
                        text: " ${vital['unit']}",
                        style: PastelTextStyles.cardSubtitle.copyWith(
                          fontSize: 12,
                          color: PastelColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Progress bar
                Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _getStatusColor(vital['status']).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: vital['progress'],
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getStatusColor(vital['status']),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ).animate()
                  .scaleX(duration: 1000.ms, delay: (200 * index).ms),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build action button
  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: PastelTextStyles.cardSubtitle.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // Helper functions for status-based styling
  Color _getStatusColor(String status) {
    switch (status) {
      case 'normal':
        return PastelColors.wellness; // Green for normal
      case 'high':
        return PastelColors.primary; // Red for high values
      case 'low':
        return PastelColors.empathyAccent; // Blue for low values
      default:
        return PastelColors.mutedBlack;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'normal':
        return PastelColors.wellness.withOpacity(0.05); // Mint background
      case 'high':
        return PastelColors.primary.withOpacity(0.05); // Peach background
      case 'low':
        return PastelColors.empathyAccent.withOpacity(0.05); // Lavender background
      default:
        return Colors.white;
    }
  }

  String _getStatusIcon(String status) {
    switch (status) {
      case 'normal':
        return '✅'; // Green checkmark for normal
      case 'high':
        return '⬆️'; // Up arrow for high
      case 'low':
        return '⬇️'; // Down arrow for low
      default:
        return '➖'; // Neutral dash
    }
  }
}
