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
  // Primary typography using Poppins for modern, friendly feel
  static TextStyle greeting = GoogleFonts.poppins(
    fontSize: 24, fontWeight: FontWeight.w600, color: PastelColors.mutedBlack
  );
  
  // Hindi text with excellent Devanagari support
  static TextStyle hindiHeading = GoogleFonts.poppins(
    fontSize: 20, fontWeight: FontWeight.w600, color: PastelColors.mutedBlack
  );
  
  static TextStyle hindiText = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w400, color: PastelColors.mutedBlack
  );
  
  static TextStyle cardTitle = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.w500, color: PastelColors.mutedBlack
  );

  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, color: PastelColors.mutedBlack
  );
  
  // Empathy-themed text styles for AI components
  static TextStyle empathyHeading = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.w600, color: PastelColors.empathyText
  );
  
  static TextStyle empathyBody = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, color: PastelColors.empathyText
  );
  
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
