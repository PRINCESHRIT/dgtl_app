import 'package:flutter/material.dart';
import 'app/di.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'package:dgtl_app/features/dashboard/widgets/polished_pastel_card.dart';
import 'package:dgtl_app/features/dashboard/widgets/polished_button.dart';
import 'package:dgtl_app/features/dashboard/widgets/detailed_symptom_logger_card.dart';
import 'package:dgtl_app/features/dashboard/widgets/ai_recommendations_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const EmpatheticHealthApp());
}

class EmpatheticHealthApp extends StatelessWidget {
  const EmpatheticHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'डीजीटल किडनी केयर',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PastelColors.empathyAccent),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const EmpatheticDashboard(),
    );
  }
}

class EmpatheticDashboard extends StatelessWidget {
  const EmpatheticDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PastelColors.peachCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Simple Greeting Hero (Top Right aligned)
              _buildGreetingHero(),
              const SizedBox(height: 24),

              // 1. Enhanced Detailed Symptom Logger Card with BP Visualizer
              const DetailedSymptomLoggerCard()
                .animate()
                .fadeIn(delay: 200.ms)
                .slideY(begin: 0.05),
              
              const SizedBox(height: 20),

              // 2. AI Recommendations Card  
              _buildAIRecommendationsCard()
                .animate()
                .fadeIn(delay: 400.ms)
                .slideY(begin: 0.05),
              
              const SizedBox(height: 20),

              // 3. Vital Tracker Card
              _buildVitalTrackerCard()
                .animate()
                .fadeIn(delay: 600.ms)
                .slideY(begin: 0.05),
              
              const SizedBox(height: 20),

              // 4. Upload/Download Reports Card
              _buildReportsCard()
                .animate()
                .fadeIn(delay: 800.ms)
                .slideY(begin: 0.05),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingHero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PastelColors.softWhite,
            PastelColors.cardEmpathy.withOpacity(0.3),
          ],
        ),
        borderRadius: PastelBorders.card,
        boxShadow: PastelEffects.cardShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "नमस्ते माँ",
                  style: PastelTextStyles.greeting.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  "आज आपका स्वास्थ्य कैसा है?",
                  style: PastelTextStyles.cardSubtitle.copyWith(
                    color: PastelColors.empathyText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PastelColors.empathyAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.health_and_safety,
              size: 32,
              color: PastelColors.empathyAccent,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.05);
  }

  Widget _buildSymptomLoggerCard() {
    return PolishedPastelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PastelColors.hopefulGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.monitor_heart,
                  color: PastelColors.empathyText,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "लक्षण लॉगर",
                      style: PastelTextStyles.cardTitle,
                    ),
                    Text(
                      "अपने दैनिक लक्षणों को रिकॉर्ड करें",
                      style: PastelTextStyles.cardSubtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PastelColors.hopefulGreen.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSymptomItem("रक्तचाप", "120/80", Icons.favorite, Colors.green),
                    _buildSymptomItem("दर्द", "2/10", Icons.sentiment_satisfied, Colors.orange),
                  ],
                ),
                const SizedBox(height: 16),
                PolishedButton(
                  text: "आज के लक्षण लॉग करें",
                  isPrimary: true,
                  icon: Icons.add_circle_outline,
                  width: double.infinity,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(title, style: PastelTextStyles.caption),
        Text(
          value, 
          style: PastelTextStyles.cardSubtitle.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAIRecommendationsCard() {
  return const AIRecommendationsCard();
  }

  Widget _buildRecommendationItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: PastelTextStyles.empathyBody),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalTrackerCard() {
    return PolishedPastelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PastelColors.calmBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.show_chart,
                  color: PastelColors.empathyText,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "महत्वपूर्ण संकेतक",
                      style: PastelTextStyles.cardTitle,
                    ),
                    Text(
                      "आपके स्वास्थ्य की स्थिति",
                      style: PastelTextStyles.cardSubtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildVitalMetric("रक्तचाप", "120/80", "सामान्य", Colors.green),
              ),
              Expanded(
                child: _buildVitalMetric("वजन", "70 kg", "स्थिर", Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 16),
          PolishedButton(
            text: "पूरा ट्रेंड देखें",
            icon: Icons.analytics,
            width: double.infinity,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVitalMetric(String title, String value, String status, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: PastelTextStyles.caption),
          Text(
            value,
            style: PastelTextStyles.cardTitle.copyWith(color: color),
          ),
          Text(
            status,
            style: PastelTextStyles.caption.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsCard() {
    return PolishedPastelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PastelColors.warmSaffron,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.folder_shared,
                  color: PastelColors.empathyText,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "रिपोर्ट्स",
                      style: PastelTextStyles.cardTitle,
                    ),
                    Text(
                      "अपनी मेडिकल रिपोर्ट्स का प्रबंधन करें",
                      style: PastelTextStyles.cardSubtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: PolishedButton(
                  text: "अपलोड करें",
                  icon: Icons.upload_file,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PolishedButton(
                  text: "डाउनलोड करें",
                  icon: Icons.download,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PastelColors.warmSaffron.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: PastelColors.empathyText,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "आपकी अंतिम रिपोर्ट: 5 दिन पहले",
                    style: PastelTextStyles.caption.copyWith(
                      color: PastelColors.empathyText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
