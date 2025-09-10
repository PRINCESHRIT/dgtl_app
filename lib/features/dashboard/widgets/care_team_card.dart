import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'pastel_card.dart';

class CareTeamCard extends StatelessWidget {
  const CareTeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PastelCard(
      child: Row(
        children: [
          SvgPicture.asset(
            AppIllustrations.doctorGuide,
            width: 80,
            height: 80,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Care Team", style: PastelTextStyles.cardTitle),
                const SizedBox(height: 8),
                Text(
                  "Dr. Ananya Sharma is available for a video consultation.",
                  style: PastelTextStyles.body,
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  child: const Text("Schedule Now"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
