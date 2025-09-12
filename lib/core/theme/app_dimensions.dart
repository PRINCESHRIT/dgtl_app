// Spacing and dimension system for DGTL Kidney Care
// Consistent spacing for touch targets and accessibility
import 'package:flutter/material.dart';

class AppDimensions {
  // Base spacing unit (8dp grid system)
  static const double baseUnit = 8.0;
  
  // Spacing system
  static const double spacingXS = baseUnit * 0.5;  // 4dp
  static const double spacingS = baseUnit;         // 8dp
  static const double spacingM = baseUnit * 2;     // 16dp
  static const double spacingL = baseUnit * 3;     // 24dp
  static const double spacingXL = baseUnit * 4;    // 32dp
  static const double spacingXXL = baseUnit * 6;   // 48dp
  
  // Component dimensions
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double inputHeight = 56.0;
  static const double cardHeight = 120.0;
  static const double appBarHeight = 56.0;
  
  // Touch targets (minimum 44dp for accessibility)
  static const double minTouchTarget = 44.0;
  static const double iconTouchTarget = 48.0;
  
  // Border radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusCircle = 999.0;
  
  // Icon sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  
  // Elevation levels
  static const double elevationNone = 0.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 12.0;
  
  // Screen margins and padding
  static const EdgeInsets screenPadding = EdgeInsets.all(spacingM);
  static const EdgeInsets cardPadding = EdgeInsets.all(spacingM);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: spacingL,
    vertical: spacingS,
  );
  
  // Medical specific dimensions
  static const double chartHeight = 200.0;
  static const double progressBarHeight = 8.0;
  static const double avatarSize = 56.0;
  static const double empathyCardHeight = 140.0;
  
  // Layout breakpoints for responsive design
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
}
