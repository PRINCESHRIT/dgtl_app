import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'package:dgtl_app/features/dashboard/widgets/polished_pastel_card.dart';

class AIRecommendationsCard extends StatelessWidget {
  const AIRecommendationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PolishedPastelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),
          const SizedBox(height: 20),

          // Recommendation Items
          _buildRecommendationItem(
            icon: Icons.lightbulb_outline_rounded,
            iconColor: PastelColors.warmSaffron,
            title: "स्वास्थ्य अंतर्दृष्टि",
            subtitle: "आपके हाल के बीपी रीडिंग थोड़े बढ़े हुए हैं। नमक का सेवन कम करने की कोशिश करें।",
            delay: 200.ms,
          ),
          const SizedBox(height: 16),
          _buildRecommendationItem(
            icon: Icons.medical_services_outlined,
            iconColor: PastelColors.calmBlue,
            title: "दवा अनुस्मारक",
            subtitle: "रात 9 बजे अपनी Amlodipine लेना न भूलें।",
            delay: 300.ms,
          ),
          const SizedBox(height: 16),
          _buildRecommendationItem(
            icon: Icons.directions_walk_rounded,
            iconColor: PastelColors.empathyAccent,
            title: "जीवनशैली सुझाव",
            subtitle: "रात के खाने के बाद 15 मिनट की छोटी सैर अद्भुत काम कर सकती है।",
            delay: 400.ms,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: PastelColors.primaryAction.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.psychology_outlined,
            color: PastelColors.primaryAction,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI से व्यक्तिगत सलाह",
                style: PastelTextStyles.cardTitle.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                "आपके स्वास्थ्य के लिए स्मार्ट सुझाव",
                style: PastelTextStyles.caption.copyWith(color: PastelColors.mutedBlack.withOpacity(0.7)),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 100.ms);
  }

  Widget _buildRecommendationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Duration delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withOpacity(0.2), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PastelTextStyles.cardSubtitle.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: PastelTextStyles.body.copyWith(color: PastelColors.mutedBlack.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay).slideX(begin: -0.1, curve: Curves.easeOut);
  }
}
