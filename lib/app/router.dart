import 'package:flutter/material.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/ai_chat/ai_chat_page.dart';
import '../features/symptom_logger/symptom_logger_page.dart';
import '../features/vitals_tracking/vitals_tracking_page.dart';
import '../features/lab_scheduler/lab_scheduler_page.dart';

/// App router configuration for DGTL
/// Handles navigation between different features
class AppRouter {
  static const String dashboard = '/';
  static const String aiChat = '/ai-chat';
  static const String symptomLogger = '/symptom-logger';
  static const String vitalsTracking = '/vitals-tracking';
  static const String labScheduler = '/lab-scheduler';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case aiChat:
        return MaterialPageRoute(builder: (_) => const AiChatPage());
      case symptomLogger:
        return MaterialPageRoute(builder: (_) => const SymptomLoggerPage());
      case vitalsTracking:
        return MaterialPageRoute(builder: (_) => const VitalsTrackingPage());
      case labScheduler:
        return MaterialPageRoute(builder: (_) => const LabSchedulerPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
