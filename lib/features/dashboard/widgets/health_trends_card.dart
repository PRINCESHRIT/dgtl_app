import 'package:flutter/material.dart';

class HealthTrendsCard extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>>? trends;

  const HealthTrendsCard({
    super.key,
    this.trends,
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
                Icon(Icons.show_chart, color: Color(0xFF1976D2), size: 24),
                SizedBox(width: 12),
                Text(
                  'Health Trends',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (trends != null) ..._buildTrendsList(),
            
            if (trends == null)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Loading health trends...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTrendsList() {
    final trendWidgets = <Widget>[];
    
    trends!.forEach((testType, data) {
      if (data.isNotEmpty) {
        trendWidgets.add(_buildTrendItem(testType, data));
      }
    });
    
    if (trendWidgets.isEmpty) {
      return [
        const Center(
          child: Text(
            'No trend data available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ];
    }

    return trendWidgets;
  }

  Widget _buildTrendItem(String testType, List<Map<String, dynamic>> data) {
    final latestValue = data.isNotEmpty ? data.last : null;
    final firstValue = data.length > 1 ? data.first : null;
    
    String displayName;
    String unit;
    Color trendColor;
    IconData trendIcon;
    String trendText;
    
    switch (testType) {
      case 'creatinine':
        displayName = 'Creatinine';
        unit = 'mg/dl';
        break;
      case 'egfr':
        displayName = 'eGFR';
        unit = 'ml/min';
        break;
      case 'hemoglobin':
        displayName = 'Hemoglobin';
        unit = 'g/dl';
        break;
      case 'pth':
        displayName = 'PTH';
        unit = 'pg/ml';
        break;
      default:
        displayName = testType;
        unit = '';
    }

    // Calculate trend
    if (latestValue != null && firstValue != null) {
      final latest = latestValue['value'] as double;
      final first = firstValue['value'] as double;
      final change = ((latest - first) / first * 100).abs();
      
      if (testType == 'egfr') {
        // For eGFR, decreasing is bad
        if (latest < first) {
          trendColor = const Color(0xFFE53E3E);
          trendIcon = Icons.trending_down;
          trendText = 'Declining';
        } else {
          trendColor = const Color(0xFF2E8B57);
          trendIcon = Icons.trending_up;
          trendText = 'Stable/Improving';
        }
      } else {
        // For creatinine, PTH - increasing is generally concerning
        if (latest > first) {
          trendColor = const Color(0xFFE53E3E);
          trendIcon = Icons.trending_up;
          trendText = 'Increasing';
        } else {
          trendColor = const Color(0xFF2E8B57);
          trendIcon = Icons.trending_down;
          trendText = 'Decreasing';
        }
      }
    } else {
      trendColor = Colors.grey;
      trendIcon = Icons.horizontal_rule;
      trendText = 'Insufficient data';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (latestValue != null)
                    Text(
                      '${latestValue['value']} $unit',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Icon(trendIcon, color: trendColor, size: 20),
                  const SizedBox(height: 4),
                  Text(
                    trendText,
                    style: TextStyle(
                      color: trendColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    '${data.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'readings',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
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
}
