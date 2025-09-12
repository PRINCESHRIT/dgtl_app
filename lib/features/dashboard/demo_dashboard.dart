import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../shared/design_system/bubble_analytics.dart';
import '../../shared/design_system/pastel_colors.dart';
import '../../shared/design_system/pastel_text_styles.dart';
import '../../shared/design_system/pastel_components.dart';

/// Standalone demo dashboard showcasing our enhanced pastel design with bubble analytics
/// This version works without database dependencies for demonstration
class DemoDashboard extends StatelessWidget {
  const DemoDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PastelColors.peachCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Greeting with Doodles
              _buildGreetingHero(),
              const SizedBox(height: 24),
              
              // BP Logger with Bubble Analytics
              _buildBPCard(),
              const SizedBox(height: 20),
              
              // Vitals Tracker with Multi-Bubble Display
              _buildVitalsCard(),
              const SizedBox(height: 20),
              
              // AI Tips Card
              _buildAITipsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingHero() {
    return PastelCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "नमस्ते, Welcome Back!",
                      style: PastelTextStyles.greeting.copyWith(
                        color: PastelColors.mutedBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Your health journey continues with gentle care",
                      style: PastelTextStyles.heroSubtitle.copyWith(
                        color: PastelColors.mutedBlack.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PastelColors.warmSaffron.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.orange,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildBPCard() {
    return PastelCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.monitor_heart,
                color: PastelColors.warmSaffron,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                "Blood Pressure Logger",
                style: PastelTextStyles.cardTitle,
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Bubble Analytics for BP readings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BubbleAnalytics(
                title: "Systolic\nसिस्टोलिक",
                value: 120,
                maxValue: 200,
                unit: "mmHg",
                type: BubbleAnalyticsType.bloodPressure,
              ),
              BubbleAnalytics(
                title: "Diastolic\nडायस्टोलिक", 
                value: 80,
                maxValue: 120,
                unit: "mmHg",
                type: BubbleAnalyticsType.bloodPressure,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          Text(
            "Great readings! Your BP is in a healthy range today.",
            style: PastelTextStyles.bodyText.copyWith(
              color: PastelColors.mutedBlack.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 800.ms, delay: 200.ms)
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildVitalsCard() {
    return PastelCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.health_and_safety,
                color: PastelColors.warmSaffron,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                "Vital Signs Tracker",
                style: PastelTextStyles.cardTitle,
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Multi-bubble display for different vitals
          MultiBubbleAnalytics(
            title: "Latest Vitals",
            bubbles: [
              BubbleData(
                title: "Heart Rate\nहृदय गति",
                value: 72,
                maxValue: 120,
                unit: "bpm",
                type: BubbleAnalyticsType.vitals,
              ),
              BubbleData(
                title: "Temperature\nतापमान",
                value: 98.6,
                maxValue: 105,
                unit: "°F",
                type: BubbleAnalyticsType.vitals,
              ),
              BubbleData(
                title: "Oxygen\nऑक्सीजन",
                value: 98,
                maxValue: 100,
                unit: "%",
                type: BubbleAnalyticsType.positive,
              ),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 800.ms, delay: 400.ms)
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildAITipsCard() {
    return PastelCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: PastelColors.warmSaffron,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                "AI Personal Tips",
                style: PastelTextStyles.cardTitle,
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PastelColors.calmBlue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "💡 Today's Personalized Tip",
                  style: PastelTextStyles.cardTitle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Based on your excellent BP readings, continue with your current medication timing. Consider a gentle 10-minute walk after meals to maintain this healthy trend.",
                  style: PastelTextStyles.bodyText.copyWith(
                    color: PastelColors.mutedBlack.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red.withOpacity(0.6),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Caring AI Assistant",
                      style: PastelTextStyles.cardSubtitle.copyWith(
                        color: PastelColors.mutedBlack.withOpacity(0.6),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 800.ms, delay: 600.ms)
      .slideY(begin: 0.2, end: 0);
  }
}
