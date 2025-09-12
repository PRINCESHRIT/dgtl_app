// Hindi-optimized typography system for DGTL Kidney Care
// Supports Devanagari script with proper spacing and readability
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Font family supporting Hindi Devanagari
  static const String fontFamily = 'Poppins';
  
  // Headers (Hindi-optimized with proper line height)
  static const TextStyle headerLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );
  
  static const TextStyle headerMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: AppColors.textPrimary,
    letterSpacing: 0.25,
  );
  
  static const TextStyle headerSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
    letterSpacing: 0.15,
  );
  
  // Body Text (optimized for Hindi readability)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textSecondary,
    letterSpacing: 0.05,
  );
  
  // Special Styles for empathy-driven components
  static const TextStyle empathyText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textPrimary,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.1,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.surfaceWhite,
    letterSpacing: 0.5,
  );
  
  // Medical data styles
  static const TextStyle medicalValue = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.0,
    color: AppColors.primaryRed,
    letterSpacing: 0.25,
  );
  
  static const TextStyle medicalLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );
  
  // Chat message styles
  static const TextStyle chatUser = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.surfaceWhite,
    letterSpacing: 0.1,
  );
  
  static const TextStyle chatAI = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );
  
  static const TextStyle chatTimestamp = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: AppColors.textHint,
    letterSpacing: 0.05,
  );
}
