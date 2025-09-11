import 'package:dgtl_app/features/dashboard/widgets/ai_personal_tips_card.dart';
import 'package:dgtl_app/features/dashboard/widgets/bp_symptom_logger_card.dart';
import 'package:dgtl_app/features/dashboard/widgets/care_team_card.dart';
import 'package:dgtl_app/features/dashboard/widgets/vital_tracker_card.dart';
import 'package:dgtl_app/features/dashboard/widgets/gamified_header.dart';
import 'package:dgtl_app/features/dashboard/widgets/polished_ai_tips_card.dart';
import 'package:dgtl_app/features/dashboard/widgets/polished_gamified_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'widgets/personalized_greeting_hero.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PastelColors.secondaryGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Polished gamified header with enhanced animations
              const PolishedGamifiedHeader(
                userName: "श्रित जी",
                healthScore: 847,
                loginStreak: 15,
              ),
              const SizedBox(height: 32),
              Text(
                "आपका स्वास्थ्य डैशबोर्ड", // Your Health Dashboard
                style: PastelTextStyles.hindiHeading,
              ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
              const SizedBox(height: 20),
              const BPSymptomLoggerCard()
                .animate()
                .fadeIn(delay: 400.ms)
                .slideY(begin: 0.1),
              const SizedBox(height: 20),
              const PolishedAIPersonalTipsCard()
                .animate()
                .fadeIn(delay: 500.ms)
                .slideY(begin: 0.1),
              const SizedBox(height: 20),
              const VitalTrackerCard()
                .animate()
                .fadeIn(delay: 600.ms)
                .slideY(begin: 0.1),
              const SizedBox(height: 20),
              const CareTeamCard()
                .animate()
                .fadeIn(delay: 700.ms)
                .slideY(begin: 0.1),
            ],
          ).animate().fadeIn(duration: 500.ms),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: PastelColors.softWhite,
        selectedItemColor: PastelColors.mutedBlack,
        unselectedItemColor: PastelColors.mutedBlack.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'AI Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Symptoms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart_outlined),
            activeIcon: Icon(Icons.monitor_heart),
            label: 'Vitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Lab Tests',
          ),
        ],
      ),
    );
  }
}