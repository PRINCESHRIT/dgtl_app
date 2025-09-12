import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// DGTL App Design System
// Medical health context with empathetic design and Devanagari support

class PastelColors {
  // Primary Theme - Professional Red for critical health elements
  static const primary = Color(0xFFE74C3C);         // HSL red for vital metrics, alerts, primary actions
  static const primaryHover = Color(0xFFC0392B);    // Analogous red for hover states
  static const primaryLight = Color(0xFFFDEDED);    // Light red background for context
  
  // Secondary Theme - Soft Gray for neutral, calming canvas
  static const secondary = Color(0xFFF8F9FA);       // Soft gray background
  static const secondaryDark = Color(0xFFE9ECEF);   // Darker gray for cards
  static const secondaryText = Color(0xFF4A4A4A);   // Darker gray text
  
  // Empathy Theme - Soft Teal/Green for AI advisory and supportive components
  static const empathy = Color(0xFFE6F7F1);         // Gentle, hopeful teal/green background
  static const empathyAccent = Color(0xFF4ECDC4);   // Soft teal accent for AI components
  static const empathyBorder = Color(0xFFB8E6D3);   // Gentle border for empathy cards
  static const empathyText = Color(0xFF1E5A5A);     // Darker empathy text
  
  // Contextual colors for medical data
  static const success = Color(0xFF28A745);         // Good health indicators
  static const warning = Color(0xFFFFC107);         // Caution, attention needed
  static const danger = Color(0xFFDC3545);          // Critical health alerts
  static const info = Color(0xFF17A2B8);            // Medical information
  static const wellness = Color(0xFF22C55E);        // Green for normal vitals and wellness
  
  // Base system colors - enhanced with darker variants for better contrast
  static const background = Color(0xFFFFFFFE);      // Pure white background
  static const surface = Color(0xFFFAFAFA);        // Card surfaces
  static const mutedBlack = Color(0xFF1A1A1A);     // Darker primary text
  static const darkText = Color(0xFF0D0D0D);       // Extra dark text variant
  static const mediumText = Color(0xFF2D2D2D);     // Medium dark text
  
  // Legacy support (maintaining backward compatibility)
  static const peachCream = Color(0xFFFFF2E7);     
  static const softWhite = Color(0xFFFAFAFA);      
  static const calmBlue = Color(0xFFE3F2FD);       
  static const hopefulGreen = Color(0xFFE8F5E8);   
  static const worriedYellow = Color(0xFFFFF9C4);  
  static const anxiousRose = Color(0xFFFFEBEE);    
  static const warmSaffron = Color(0xFFFFE0B2);    
  
  // Aliases for new system
  static Color get primaryAction => primary;
  static Color get secondaryGray => secondary;
}

class PastelTextStyles {
  // Poppins font family - chosen for excellent readability and Devanagari script support
  // Enhanced with darker, bolder styling for better medical interface readability
  
  // Hero and greeting text - extra bold and dark
  static TextStyle greeting = GoogleFonts.poppins(
    fontSize: 28, 
    fontWeight: FontWeight.w800, // Increased from w700
    color: PastelColors.mutedBlack,
    letterSpacing: -0.5, 
    height: 1.2
  );
  
  // Hindi headings with optimized Devanagari support - bolder
  static TextStyle hindiHeading = GoogleFonts.poppins(
    fontSize: 22, 
    fontWeight: FontWeight.w700, // Increased from w600
    color: PastelColors.mutedBlack,
    letterSpacing: -0.3, 
    height: 1.4  // Enhanced line height for Devanagari
  );
  
  // Hindi body text - darker and bolder for health content readability
  static TextStyle hindiText = GoogleFonts.poppins(
    fontSize: 16, 
    fontWeight: FontWeight.w600, // Increased from w400
    color: const Color(0xFF1A1A1A), // Darker than mutedBlack
    letterSpacing: 0.0,
    height: 1.5  // Better spacing for Hindi text
  );
  
  // Medical data and vital metrics - extra bold with primary red
  static TextStyle medicalData = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w800, // Increased from w700
    color: PastelColors.primary,
    letterSpacing: -0.3
  );
  
  // Card titles - bolder for professional medical context
  static TextStyle cardTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700, // Increased from w600
    color: const Color(0xFF1A1A1A), // Darker color
    letterSpacing: -0.2
  );
  
  // Card subtitles and descriptions - bolder and darker
  static TextStyle cardSubtitle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Increased from w400
    color: const Color(0xFF4A4A4A), // Darker secondary text
    height: 1.4
  );
  
  // Captions and helper text - more prominent
  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600, // Increased from w500
    color: const Color(0xFF4A4A4A), // Darker secondary text
    letterSpacing: 0.1
  );
  
  // Empathy/AI advisory text - bolder empathy color scheme
  static TextStyle empathyText = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600, // Increased from w500
    color: const Color(0xFF1E5A5A), // Darker empathy text
    height: 1.5
  );
  
  // Button text - extra bold for primary actions
  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700, // Increased from w600
    color: Colors.white,
    letterSpacing: 0.1
  );
  
  // Body text for general content
  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14, 
    fontWeight: FontWeight.w500, 
    color: PastelColors.mutedBlack,
    height: 1.5
  );
  
  // Empathy-themed text styles for AI components
  static TextStyle empathyHeading = GoogleFonts.poppins(
    fontSize: 19, 
    fontWeight: FontWeight.w600, 
    color: PastelColors.empathyText,
    letterSpacing: -0.2, 
    height: 1.2
  );
  
  static TextStyle empathyBody = GoogleFonts.poppins(
    fontSize: 15, 
    fontWeight: FontWeight.w500, 
    color: PastelColors.empathyText,
    height: 1.6, 
    letterSpacing: 0.1
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
      PastelColors.empathy,
      PastelColors.empathy.withOpacity(0.8),
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
