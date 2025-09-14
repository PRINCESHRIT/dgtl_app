import 'package:flutter/material.dart';

class MonitoringAlertsCard extends StatelessWidget {
  final Map<String, dynamic>? patientContext;

  const MonitoringAlertsCard({
    super.key,
    this.patientContext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.notifications_active, color: Color(0xFFFF7043), size: 24),
                SizedBox(width: 12),
                Text(
                  'Monitoring Alerts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (patientContext != null) ..._buildAlertsList(),
            
            if (patientContext == null)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Loading monitoring alerts...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAlertsList() {
    final alerts = <Widget>[];
    
    // Check eGFR alert
    final egfrData = patientContext!['latest_egfr'] as Map<String, dynamic>?;
    if (egfrData != null) {
      final egfr = egfrData['value'] as double?;
      if (egfr != null && egfr < 15) {
        alerts.add(_buildAlertItem(
          'Critical eGFR',
          'eGFR $egfr ml/min - Dialysis preparation needed',
          const Color(0xFFE53E3E),
          Icons.warning,
        ));
      } else if (egfr != null && egfr < 30) {
        alerts.add(_buildAlertItem(
          'Low eGFR',
          'eGFR $egfr ml/min - Monitor closely',
          const Color(0xFFFF7043),
          Icons.monitor_heart,
        ));
      }
    }
    
    // Check for missing recent labs
    final dataRange = patientContext!['data_range'] as Map<String, dynamic>?;
    if (dataRange != null) {
      final lastUpdate = DateTime.tryParse(dataRange['end'] ?? '');
      if (lastUpdate != null) {
        final daysSinceUpdate = DateTime.now().difference(lastUpdate).inDays;
        if (daysSinceUpdate > 90) {
          alerts.add(_buildAlertItem(
            'Lab Update Needed',
            'Last labs: ${daysSinceUpdate} days ago - Schedule follow-up',
            const Color(0xFFFF7043),
            Icons.schedule,
          ));
        }
      }
    }
    
    // Check medication monitoring
    final medications = patientContext!['medications'] as List<dynamic>?;
    if (medications != null && medications.isEmpty) {
      alerts.add(_buildAlertItem(
        'Medication Review',
        'No medications documented - Verify with provider',
        const Color(0xFF8E24AA),
        Icons.medication,
      ));
    }
    
    // Positive monitoring message if no alerts
    if (alerts.isEmpty) {
      alerts.add(_buildPositiveAlert());
    }
    
    return alerts;
  }

  Widget _buildAlertItem(String title, String message, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: color,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositiveAlert() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2E8B57).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2E8B57).withOpacity(0.2)),
      ),
      padding: const EdgeInsets.all(16),
      child: const Row(
        children: [
          Icon(Icons.check_circle, color: Color(0xFF2E8B57), size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monitoring Status Good',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E8B57),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'No critical alerts at this time. Continue regular monitoring.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
