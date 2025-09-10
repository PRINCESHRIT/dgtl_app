import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dgtl_app/app/design_system.dart';

class PastelCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const PastelCard({
    super.key,
    required this.child,
    this.color = PastelColors.softWhite,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    ).animate().fade(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1);
  }
}
