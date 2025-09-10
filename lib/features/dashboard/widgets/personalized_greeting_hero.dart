import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dgtl_app/app/design_system.dart';

class PersonalizedGreetingHero extends StatelessWidget {
  const PersonalizedGreetingHero({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder data - replace with actual data from backend
    String userName = "Shriti";
    String patientName = "Maa";
    String greeting = _getTimeBasedGreeting();

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: PastelColors.peachCream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: PastelTextStyles.greeting,
                ),
                Text(
                  "$userName! आज $patientName कैसी हैं?",
                  style: PastelTextStyles.hindiText.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            AppIllustrations.doctorGuide,
            height: 80,
          ).animate().fade(duration: 500.ms).slideX(),
        ],
      ),
    );
  }

  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'सुप्रभात'; // Good morning
    }
    if (hour < 17) {
      return 'नमस्ते'; // Good afternoon
    }
    return 'शुभ संध्या'; // Good evening
  }
}
