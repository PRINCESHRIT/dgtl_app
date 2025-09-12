// Enhanced color palette for DGTL Kidney Care
// Integrates with existing theme.dart while adding empathy-driven colors
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (Medical Theme)
  static const Color primaryRed = Color(0xFFCF3C3C);
  static const Color primaryRedLight = Color(0xFFE57373);
  static const Color primaryRedDark = Color(0xFFB71C1C);
  
  // Background Colors
  static const Color backgroundCream = Color(0xFFFAF5F3);
  static const Color cardBackground = Color(0xFFF0E6E3);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  
  // Empathy & AI Colors (Special for AI-driven components)
  static const Color empathyTeal = Color(0xFFDDEFEA);
  static const Color empathyTealLight = Color(0xFFE8F5F0);
  static const Color empathyTealDark = Color(0xFFB2DFDB);
  
  // Mood & Emotion Colors (for symptom logging)
  static const Color moodHappy = Color(0xFFFFE082);      // Yellow
  static const Color moodCalm = Color(0xFF9CCC65);       // Green
  static const Color moodSad = Color(0xFFF8BBD0);        // Pink
  static const Color moodAnxious = Color(0xFFB39DDB);    // Purple
  static const Color moodAngry = Color(0xFFEF9A9A);      // Light Red
  static const Color moodExcited = Color(0xFF90CAF9);    // Blue
  
  // Status Colors (for medical data visualization)
  static const Color statusNormal = Color(0xFF66BB6A);    // Green
  static const Color statusWarning = Color(0xFFFFB74D);   // Orange
  static const Color statusCritical = Color(0xFFE57373);  // Red
  static const Color statusExcellent = Color(0xFF4CAF50); // Excellent status
  
  // Additional background colors
  static const Color backgroundLight = Color(0xFFFAFAFA); // Light background
  static const Color shadowLight = Color(0x1A000000);     // Light shadow
  
  // Mood variations
  static const Color moodTired = Color(0xFFBDBDBD);       // Tired state
  
  // Neutral Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  static const Color divider = Color(0xFFE0E0E0);
  
  // Gradient combinations for empathy cards
  static LinearGradient get empathyGradient => LinearGradient(
    colors: [empathyTealLight, empathyTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get moodGradient => LinearGradient(
    colors: [moodHappy.withOpacity(0.3), moodCalm.withOpacity(0.3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
