import 'package:flutter/material.dart';

/// Pastel Minimalist Color System for DGTL
/// Consistent emotion mapping across all UI elements
class PastelColors {
  // Base pastel system
  static const Color peachCream = Color(0xFFFFF2E7);      // Background
  static const Color softWhite = Color(0xFFFAFAFA);       // Cards
  static const Color pastelMint = Color(0xFFE8F5E8);      // Success/Good
  static const Color mutedBlack = Color(0xFF2C2C2C);      // Text
  
  // Emotion mapping (consistent across all UI)
  static const Color calmBlue = Color(0xFFE3F2FD);        // Calm, medical info
  static const Color hopefulGreen = Color(0xFFE8F5E8);    // Positive, improving
  static const Color worriedYellow = Color(0xFFFFF9C4);   // Caution, attention needed
  static const Color anxiousRose = Color(0xFFFFEBEE);     // Concern, high values
  
  // Cultural accents
  static const Color warmSaffron = Color(0xFFFFE0B2);     // Important highlights
  static const Color gentleRose = Color(0xFFFCE4EC);      // Gentle pink accents
  
  // Additional neutral colors
  static const Color neutralGray = Color(0xFFF5F5F5);     // Subtle backgrounds
  static const Color charcoalGray = Color(0xFF424242);    // Secondary text
  
  // Gradients for bubble effects
  static const LinearGradient bubbleGradient = LinearGradient(
    colors: [softWhite, peachCream],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [softWhite, Color(0xFFF8F8F8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Color mapping helper for emotions and medical states
class EmotionColorMap {
  static Color getColorForEmotion(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'calm':
      case 'peaceful':
      case 'stable':
        return PastelColors.calmBlue;
      case 'happy':
      case 'hopeful':
      case 'improving':
        return PastelColors.hopefulGreen;
      case 'worried':
      case 'concerned':
      case 'caution':
        return PastelColors.worriedYellow;
      case 'anxious':
      case 'stressed':
      case 'high':
        return PastelColors.anxiousRose;
      default:
        return PastelColors.softWhite;
    }
  }
  
  static Color getColorForVitalValue(double value, double normalMin, double normalMax) {
    if (value < normalMin || value > normalMax) {
      return PastelColors.anxiousRose; // Abnormal values
    } else if (value >= normalMin * 0.9 && value <= normalMax * 1.1) {
      return PastelColors.hopefulGreen; // Good range
    } else {
      return PastelColors.worriedYellow; // Borderline
    }
  }
}
