import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'polished_pastel_card.dart';
import 'polished_button.dart';

class PolishedAIPersonalTipsCard extends StatefulWidget {
  const PolishedAIPersonalTipsCard({super.key});

  @override
  State<PolishedAIPersonalTipsCard> createState() => _PolishedAIPersonalTipsCardState();
}

class _PolishedAIPersonalTipsCardState extends State<PolishedAIPersonalTipsCard>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PolishedPastelCard(
      isEmpathy: true,
      enableGlow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            PastelColors.empathyAccent.withOpacity(0.3),
                            PastelColors.empathyAccent.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: PastelColors.empathyAccent.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.psychology_rounded,
                        color: PastelColors.empathyText,
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("AI विशेषज्ञ की राय", style: PastelTextStyles.empathyHeading),
                    const SizedBox(height: 4),
                    Text(
                      "आपके स्वास्थ्य डेटा पर आधारित व्यक्तिगत सुझाव",
                      style: PastelTextStyles.empathyBody.copyWith(
                        fontSize: 13,
                        color: PastelColors.empathyText.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: PastelColors.empathyAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: PastelColors.empathyText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "नया",
                      style: PastelTextStyles.caption.copyWith(
                        color: PastelColors.empathyText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
          
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  PastelColors.softWhite.withOpacity(0.9),
                  PastelColors.softWhite.withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: PastelColors.empathyBorder.withOpacity(0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: PastelColors.empathyAccent.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: -2,
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
                        color: PastelColors.empathyAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.lightbulb_rounded,
                        color: PastelColors.empathyText,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "आज के खास सुझाव",
                      style: PastelTextStyles.cardTitle.copyWith(
                        color: PastelColors.empathyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                ..._buildAnimatedTips().asMap().entries.map((entry) {
                  int index = entry.key;
                  Widget tip = entry.value;
                  return tip.animate()
                    .fadeIn(delay: (200 + (index * 100)).ms)
                    .slideX(begin: 0.1);
                }),
                
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: PastelColors.empathyAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.restaurant_menu_rounded,
                        color: PastelColors.empathyText,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "आज का भोजन प्लान",
                      style: PastelTextStyles.cardTitle.copyWith(
                        color: PastelColors.empathyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                ..._buildMealPlans().asMap().entries.map((entry) {
                  int index = entry.key;
                  Widget meal = entry.value;
                  return meal.animate()
                    .fadeIn(delay: (400 + (index * 100)).ms)
                    .slideX(begin: 0.1);
                }),
                
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(
                      child: PolishedButton(
                        text: "और सुझाव देखें",
                        isEmpathy: true,
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () {
                          setState(() => _isExpanded = !_isExpanded);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    PolishedButton(
                      text: "शेयर करें",
                      icon: Icons.share_rounded,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.95, 0.95)),
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedTips() {
    final tips = [
      _buildPolishedTipItem("🧘‍♂️", "सुबह 10 मिनट योग करें", "तनाव कम करता है"),
      _buildPolishedTipItem("💧", "दिन में 8-10 गिलास पानी पिएं", "किडनी के लिए जरूरी"),
      _buildPolishedTipItem("🥗", "नमक कम करके खाना खाएं", "BP नियंत्रित रखता है"),
    ];
    return tips;
  }

  List<Widget> _buildMealPlans() {
    final meals = [
      _buildPolishedMealPlan("नाश्ता", "ओट्स + बादाम दूध", "7:00 AM"),
      _buildPolishedMealPlan("दोपहर", "चपाती + दाल + सब्जी", "1:00 PM"),
      _buildPolishedMealPlan("रात", "सूप + सलाद", "7:30 PM"),
    ];
    return meals;
  }

  Widget _buildPolishedTipItem(String emoji, String text, String benefit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PastelColors.empathyAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PastelColors.empathyBorder.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PastelColors.empathyAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: PastelTextStyles.empathyBody.copyWith(
                  fontWeight: FontWeight.w600,
                )),
                const SizedBox(height: 2),
                Text(benefit, style: PastelTextStyles.caption.copyWith(
                  color: PastelColors.empathyText.withOpacity(0.7),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolishedMealPlan(String meal, String food, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PastelColors.empathyAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PastelColors.empathyBorder.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: PastelColors.empathyAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              meal,
              style: PastelTextStyles.empathyBody.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(food, style: PastelTextStyles.empathyBody),
          ),
          Text(
            time,
            style: PastelTextStyles.caption.copyWith(
              color: PastelColors.empathyText.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
