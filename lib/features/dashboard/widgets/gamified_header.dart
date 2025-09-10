import 'package:flutter/material.dart';
import 'package:dgtl_app/app/design_system.dart';

class GamifiedHeader extends StatelessWidget {
  final String userName;
  final int healthScore;
  final int loginStreak;
  
  const GamifiedHeader({
    super.key,
    this.userName = "उपयोगकर्ता", // User in Hindi
    this.healthScore = 85,
    this.loginStreak = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: PastelColors.softWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // App branding
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "डीजीटल किडनी केयर",
                  style: PastelTextStyles.hindiHeading.copyWith(
                    color: PastelColors.primaryAction,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "नमस्ते, $userName",
                  style: PastelTextStyles.body.copyWith(
                    color: PastelColors.mutedBlack.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          
          // Gamification elements
          Row(
            children: [
              // Health Score
              _buildScoreCard(
                icon: Icons.local_hospital,
                label: "स्वास्थ्य स्कोर",
                value: "$healthScore",
                color: _getHealthScoreColor(healthScore),
              ),
              
              const SizedBox(width: 12),
              
              // Login Streak
              _buildScoreCard(
                icon: Icons.star,
                label: "दिन लगातार",
                value: "$loginStreak",
                color: PastelColors.warmSaffron,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildScoreCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: PastelTextStyles.healthScore.copyWith(
              color: color,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: PastelTextStyles.body.copyWith(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getHealthScoreColor(int score) {
    if (score >= 80) return PastelColors.hopefulGreen;
    if (score >= 60) return PastelColors.warmSaffron;
    return PastelColors.anxiousRose;
  }
}
