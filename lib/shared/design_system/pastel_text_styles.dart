import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pastel_colors.dart';

/// Typography system with Hindi + English support
class PastelTextStyles {
  // Greeting and hero text
  static TextStyle greeting = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: PastelColors.mutedBlack,
    height: 1.2,
  );
  
  static TextStyle heroSubtitle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: PastelColors.mutedBlack.withOpacity(0.7),
    height: 1.4,
  );
  
  // Card titles and content
  static TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: PastelColors.mutedBlack,
    height: 1.3,
  );
  
  static TextStyle cardSubtitle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: PastelColors.mutedBlack.withOpacity(0.6),
    height: 1.3,
  );
  
  static TextStyle bodyText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: PastelColors.mutedBlack,
    height: 1.4,
  );
  
  // Hindi text support
  static TextStyle hindiText = GoogleFonts.notoSansDevanagari(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: PastelColors.mutedBlack,
    height: 1.5,
  );
  
  static TextStyle hindiTitle = GoogleFonts.notoSansDevanagari(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: PastelColors.mutedBlack,
    height: 1.4,
  );
  
  // Mixed script (for "Creatinine (क्रिएटिनिन)" style text)
  static TextStyle mixedScript = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: PastelColors.mutedBlack,
    height: 1.4,
  );
  
  // Button text
  static TextStyle buttonText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: PastelColors.mutedBlack,
  );
  
  static TextStyle buttonTextLight = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: PastelColors.softWhite,
  );
  
  // Number display (for keypad, vital values)
  static TextStyle numberDisplay = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: PastelColors.mutedBlack,
  );
  
  static TextStyle smallNumber = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: PastelColors.mutedBlack,
  );
  
  // AI tips and recommendations
  static TextStyle aiTip = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: PastelColors.mutedBlack,
    height: 1.4,
  );
  
  static TextStyle aiTipHighlight = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: PastelColors.warmSaffron.withOpacity(0.8),
    height: 1.4,
  );
}
