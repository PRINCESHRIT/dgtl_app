import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dgtl_app/app/design_system.dart';

class PolishedGamifiedHeader extends StatefulWidget {
  final String userName;
  final int healthScore;
  final int loginStreak;

  const PolishedGamifiedHeader({
    super.key,
    required this.userName,
    required this.healthScore,
    required this.loginStreak,
  });

  @override
  State<PolishedGamifiedHeader> createState() => _PolishedGamifiedHeaderState();
}

class _PolishedGamifiedHeaderState extends State<PolishedGamifiedHeader>
    with TickerProviderStateMixin {
  late AnimationController _scoreAnimationController;
  late AnimationController _streakAnimationController;
  late Animation<double> _scoreCountAnimation;
  late Animation<double> _streakCountAnimation;

  @override
  void initState() {
    super.initState();
    
    _scoreAnimationController = AnimationController(
      duration: PastelAnimations.dramatic,
      vsync: this,
    );
    
    _streakAnimationController = AnimationController(
      duration: PastelAnimations.dramatic,
      vsync: this,
    );

    _scoreCountAnimation = Tween<double>(
      begin: 0,
      end: widget.healthScore.toDouble(),
    ).animate(CurvedAnimation(
      parent: _scoreAnimationController,
      curve: PastelAnimations.bounceEase,
    ));

    _streakCountAnimation = Tween<double>(
      begin: 0,
      end: widget.loginStreak.toDouble(),
    ).animate(CurvedAnimation(
      parent: _streakAnimationController,
      curve: PastelAnimations.bounceEase,
    ));

    // Start animations with delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _scoreAnimationController.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 700), () {
      _streakAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _scoreAnimationController.dispose();
    _streakAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PastelColors.softWhite,
            PastelColors.peachCream.withOpacity(0.3),
            PastelColors.cardEmpathy.withOpacity(0.1),
          ],
        ),
        borderRadius: PastelBorders.card,
        boxShadow: PastelEffects.elevatedShadow,
        border: Border.all(
          color: PastelColors.empathyBorder.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: PastelColors.empathyAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.health_and_safety_rounded,
                            size: 16,
                            color: PastelColors.empathyText,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "डीजीटल किडनी केयर",
                            style: PastelTextStyles.caption.copyWith(
                              color: PastelColors.empathyText,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "नमस्ते, ${widget.userName} 👋",
                      style: PastelTextStyles.greeting.copyWith(
                        fontSize: 26,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "आज आपका स्वास्थ्य कैसा है?",
                      style: PastelTextStyles.cardSubtitle.copyWith(
                        color: PastelColors.mutedBlack.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _scoreCountAnimation,
                    builder: (context, child) {
                      return _buildPolishedScoreBadge(
                        icon: Icons.emoji_events_rounded,
                        label: _scoreCountAnimation.value.round().toString(),
                        subtitle: "स्वास्थ्य स्कोर",
                        color: PastelColors.empathyAccent,
                        gradient: LinearGradient(
                          colors: [
                            PastelColors.empathyAccent,
                            PastelColors.empathyAccent.withOpacity(0.7),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  AnimatedBuilder(
                    animation: _streakCountAnimation,
                    builder: (context, child) {
                      return _buildPolishedScoreBadge(
                        icon: Icons.local_fire_department_rounded,
                        label: _streakCountAnimation.value.round().toString(),
                        subtitle: "दिन की लगन",
                        color: PastelColors.primaryAction,
                        gradient: LinearGradient(
                          colors: [
                            PastelColors.primaryAction,
                            PastelColors.primaryActionHover,
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Progress bar for daily health goals
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  PastelColors.empathyAccent.withOpacity(0.1),
                  PastelColors.empathyAccent.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: PastelColors.empathyBorder.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.track_changes_rounded,
                      size: 18,
                      color: PastelColors.empathyText,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "आज के लक्ष्य",
                      style: PastelTextStyles.cardTitle.copyWith(
                        color: PastelColors.empathyText,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "75% पूर्ण",
                      style: PastelTextStyles.caption.copyWith(
                        color: PastelColors.empathyText.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: PastelColors.empathyBorder.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.75,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            PastelColors.empathyAccent,
                            PastelColors.empathyAccent.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ).animate()
                  .slideX(begin: -1, duration: PastelAnimations.slow)
                  .then()
                  .shimmer(duration: PastelAnimations.dramatic),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: PastelAnimations.standard)
      .slideY(begin: -0.1, curve: PastelAnimations.softEase);
  }

  Widget _buildPolishedScoreBadge({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required LinearGradient gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: PastelTextStyles.cardTitle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: PastelTextStyles.caption.copyWith(
              fontSize: 11,
              color: color.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
