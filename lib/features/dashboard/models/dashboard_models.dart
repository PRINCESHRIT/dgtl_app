// Data models for enhanced dashboard with empathy integration
import 'package:flutter/material.dart';

class MedicalCardData {
  final String id;
  final String label;
  final String value;
  final String unit;
  final String status;
  final String icon;
  final String empathyMessage;
  final DateTime lastUpdated;

  const MedicalCardData({
    required this.id,
    required this.label,
    required this.value,
    required this.unit,
    required this.status,
    required this.icon,
    required this.empathyMessage,
    required this.lastUpdated,
  });

  IconData get iconData {
    switch (icon) {
      case 'heart':
        return Icons.favorite;
      case 'glucose':
        return Icons.water_drop;
      case 'kidney':
        return Icons.analytics;
      case 'temperature':
        return Icons.thermostat;
      case 'weight':
        return Icons.monitor_weight;
      default:
        return Icons.health_and_safety;
    }
  }
}

class EmpathyGreeting {
  final String message;
  final String subtitle;
  final IconData icon;
  final Color color;

  const EmpathyGreeting({
    required this.message,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class MoodData {
  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;

  const MoodData({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    this.isSelected = false,
  });
}
