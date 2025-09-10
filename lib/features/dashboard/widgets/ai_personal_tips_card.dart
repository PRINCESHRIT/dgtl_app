import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'pastel_card.dart';

class AIPersonalTipsCard extends StatelessWidget {
  const AIPersonalTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: PastelColors.cardEmpathy, // Empathy theme background
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: PastelColors.empathyBorder,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: PastelColors.empathyAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.psychology, // Brain/AI icon
                      color: PastelColors.empathyAccent,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "विशेषज्ञ की राय", // Doctor's Insight in Hindi
                          style: PastelTextStyles.empathyHeading,
                        ),
                        Text(
                          "आपके लिए व्यक्तिगत सुझाव", // Personal suggestions for you
                          style: PastelTextStyles.empathyBody.copyWith(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // AI Analysis Summary
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "आपके रक्तचाप के आंकड़े स्थिर हैं। यह एक अच्छा संकेत है। आज भी अपनी दिनचर्या बनाए रखें।",
                  style: PastelTextStyles.empathyBody.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                "आज के खास सुझाव:", // Today's Special Suggestions
                style: PastelTextStyles.empathyHeading.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 8),
              
              _buildTip("💧 8-10 गिलास पानी पिएं - यह किडनी के लिए अच्छा है"),
              _buildTip("🚶‍♂️ भोजन के बाद 15 मिनट टहलें"),
              _buildTip("🥗 आज हरी सब्जियों को प्राथमिकता दें"),
              _buildTip("😴 रात में 7-8 घंटे की नींद लें"),
              
              const SizedBox(height: 12),
              
              // Encouragement message
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PastelColors.empathyAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: PastelColors.empathyAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "आप बहुत अच्छा कर रहे हैं! ऐसे ही जारी रखें।",
                        style: PastelTextStyles.empathyBody.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: PastelColors.empathyAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: PastelTextStyles.empathyBody,
            ),
          ),
        ],
      ),
    );
  }
}
