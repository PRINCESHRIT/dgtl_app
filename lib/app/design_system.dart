import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// DGTL App Design System
// Pastel minimalism with empathetic doodle illustrations

class PastelColors {
  // Base pastel system
  static const peachCream = Color(0xFFFFF2E7);      // Background
  static const softWhite = Color(0xFFFAFAFA);       // Cards
  static const pastelMint = Color(0xFFE8F5E8);      // Success/Good
  static const mutedBlack = Color(0xFF2C2C2C);      // Text
  
  // Empathy theme colors - for AI and supportive components
  static const cardEmpathy = Color(0xFFE6F7F1);     // Calming teal/green background
  static const empathyAccent = Color(0xFF4ECDC4);   // Soft teal accent
  static const empathyBorder = Color(0xFFB8E6D3);   // Gentle border for empathy cards
  static const empathyText = Color(0xFF2C7A7B);     // Readable text on empathy background
  
  // Primary action colors - purposeful red for important elements
  static const primaryAction = Color(0xFFE74C3C);   // Professional red
  static const primaryActionHover = Color(0xFFC0392B); // Darker red for hover
  static const primaryActionLight = Color(0xFFFDEDED); // Light red background
  
  // Emotion mapping (consistent across all UI)
  static const calmBlue = Color(0xFFE3F2FD);        // Calm, medical info
  static const hopefulGreen = Color(0xFFE8F5E8);    // Positive, improving
  static const worriedYellow = Color(0xFFFFF9C4);   // Caution, attention needed
  static const anxiousRose = Color(0xFFFFEBEE);     // Concern, high values
  
  // Cultural accents
  static const warmSaffron = Color(0xFFFFE0B2);     // Important highlights
  static const secondaryGray = Color(0xFFF8F9FA);   // Calm background canvas
}

class PastelTextStyles {
  // Primary typography using Poppins for modern, friendly feel with enhanced polish
  static TextStyle greeting = GoogleFonts.poppins(
    fontSize: 28, fontWeight: FontWeight.w700, color: PastelColors.mutedBlack,
    letterSpacing: -0.5, height: 1.2
  );
  
  // Hindi text with excellent Devanagari support and refined spacing
  static TextStyle hindiHeading = GoogleFonts.poppins(
    fontSize: 22, fontWeight: FontWeight.w600, color: PastelColors.mutedBlack,
    letterSpacing: -0.3, height: 1.3
  );
  
  static TextStyle hindiText = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w400, color: PastelColors.mutedBlack,
    height: 1.5, letterSpacing: 0.1
  );
  
  // Enhanced card title with better visual hierarchy
  static TextStyle cardTitle = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.w600, color: PastelColors.mutedBlack,
    letterSpacing: -0.2, height: 1.2
  );
  
  // Polished subtitle with refined opacity
  static TextStyle cardSubtitle = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w500, color: PastelColors.mutedBlack.withOpacity(0.75),
    height: 1.4, letterSpacing: 0.1
  );
  
  // Elegant caption text
  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, color: PastelColors.mutedBlack.withOpacity(0.6),
    height: 1.3, letterSpacing: 0.2
  );
  
  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, color: PastelColors.mutedBlack,
    height: 1.5
  );
  
  // Empathy-themed text styles for AI components with enhanced polish
  static TextStyle empathyHeading = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w600, color: PastelColors.empathyText,
    letterSpacing: -0.2, height: 1.2
  );
  
  static TextStyle empathyBody = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, color: PastelColors.empathyText,
    height: 1.6, letterSpacing: 0.1
  );
}

// Sophisticated Visual Effects & Polish
class PastelEffects {
  // Enhanced card shadows with depth
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: PastelColors.mutedBlack.withOpacity(0.04),
      offset: const Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: PastelColors.mutedBlack.withOpacity(0.02),
      offset: const Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  // Premium elevated shadow for interactive elements
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: PastelColors.mutedBlack.withOpacity(0.08),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: PastelColors.mutedBlack.withOpacity(0.04),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  // Subtle inner glow for empathy-themed cards
  static List<BoxShadow> get empathyGlow => [
    BoxShadow(
      color: PastelColors.empathyAccent.withOpacity(0.1),
      offset: const Offset(0, 0),
      blurRadius: 20,
      spreadRadius: -5,
    ),
  ];

  // Professional gradient overlays
  static LinearGradient get cardGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      PastelColors.softWhite,
      PastelColors.softWhite.withOpacity(0.9),
    ],
  );

  static LinearGradient get empathyGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      PastelColors.cardEmpathy,
      PastelColors.cardEmpathy.withOpacity(0.8),
    ],
  );
}

// Animation Curves & Durations for Polished Interactions
class PastelAnimations {
  // Sophisticated easing curves
  static const Curve softEase = Curves.easeOutCubic;
  static const Curve quickEase = Curves.easeOutQuart;
  static const Curve bounceEase = Curves.elasticOut;
  
  // Carefully tuned durations
  static const Duration quick = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration dramatic = Duration(milliseconds: 800);
  
  // Staggered animation delays for premium feel
  static const Duration staggerDelay = Duration(milliseconds: 100);
}

// Premium Border Radius for Consistent Polish
class PastelBorders {
  static BorderRadius get card => BorderRadius.circular(20);
  static BorderRadius get button => BorderRadius.circular(16);
  static BorderRadius get input => BorderRadius.circular(12);
  static BorderRadius get avatar => BorderRadius.circular(50);
  static BorderRadius get subtle => BorderRadius.circular(8);
  
  // Action button styles
  static TextStyle actionButton = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white
  );
  
  // Health metrics and scores
  static TextStyle healthScore = GoogleFonts.poppins(
    fontSize: 20, fontWeight: FontWeight.w700, color: PastelColors.primaryAction
  );
}

class AppIllustrations {
  static const String happy = 'assets/illustrations/happy-2-svgrepo-com.svg';
  static const String heart = 'assets/illustrations/heart-svgrepo-com.svg';
  static const String kidney = 'assets/illustrations/kidney-svgrepo-com.svg';
  static const String doctorGuide = 'assets/illustrations/male-doctor-to-guide-svgrepo-com.svg';
  static const String medicalExam = 'assets/illustrations/medical-examination-male-svgrepo-com.svg';
  static const String onlineConsult = 'assets/illustrations/online-medical-consultation-male-svgrepo-com.svg';
}
