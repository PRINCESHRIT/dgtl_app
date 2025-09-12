import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/dashboard/demo_dashboard.dart';
import 'shared/design_system/pastel_colors.dart';

/// Demo app to showcase the enhanced pastel dashboard with bubble analytics
/// This bypasses complex dependencies while demonstrating the design system
void main() {
  runApp(const DGTLDemoApp());
}

class DGTLDemoApp extends StatelessWidget {
  const DGTLDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DGTL Pastel Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: PastelColors.peachCream,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
        useMaterial3: true,
      ),
      home: const DemoDashboard(),
    );
  }
}
