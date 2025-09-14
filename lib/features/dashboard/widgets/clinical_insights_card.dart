import 'package:flutter/material.dart';

class ClinicalInsightsCard extends StatelessWidget {
  final Map<String, dynamic>? patientContext;
  final Map<String, dynamic>? insights;

  const ClinicalInsightsCard({
    super.key,
    this.patientContext,
    this.insights,
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
                Icon(Icons.psychology, color: Color(0xFF2E8B57), size: 24),
                SizedBox(width: 12),
                Text(
                  'AI Clinical Insights',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (insights != null) ..._buildInsightsList(),
            
            if (insights == null)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Loading clinical insights...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInsightsList() {
    final insightsList = insights!['insights'] as List<dynamic>? ?? [];
    
    if (insightsList.isEmpty) {
      return [
        const Center(
          child: Text(
            'No insights available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ];
    }

    return insightsList.take(3).map((insight) => _buildInsightItem(insight)).toList();
  }

  Widget _buildInsightItem(Map<String, dynamic> insight) {
    final type = insight['type'] as String? ?? 'general';
    final title = insight['title'] as String? ?? 'Clinical Insight';
    final content = insight['insight'] as String? ?? 'No insight available';
    final confidence = (insight['confidence'] as double? ?? 0.0) * 100;
    
    IconData icon;
    Color color;
    
    switch (type) {
      case 'disease_progression':
        icon = Icons.trending_up;
        color = const Color(0xFF2E8B57);
        break;
      case 'medication_effectiveness':
        icon = Icons.medication;
        color = const Color(0xFF1976D2);
        break;
      case 'risk_prediction':
        icon = Icons.warning_amber;
        color = const Color(0xFFFF7043);
        break;
      case 'monitoring_optimization':
        icon = Icons.monitor_heart;
        color = const Color(0xFF8E24AA);
        break;
      default:
        icon = Icons.info_outline;
        color = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: color,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${confidence.toInt()}%',
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
