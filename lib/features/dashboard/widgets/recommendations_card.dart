import 'package:flutter/material.dart';

class RecommendationsCard extends StatelessWidget {
  final Map<String, dynamic>? recommendations;

  const RecommendationsCard({
    super.key,
    this.recommendations,
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
            Row(
              children: [
                const Icon(Icons.medical_services, color: Color(0xFFE53E3E), size: 24),
                const SizedBox(width: 12),
                const Text(
                  'Clinical Recommendations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (recommendations != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53E3E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${recommendations!['total_recommendations']} items',
                      style: const TextStyle(
                        color: Color(0xFFE53E3E),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (recommendations != null) ..._buildRecommendationsList(),
            
            if (recommendations == null)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Loading recommendations...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRecommendationsList() {
    final recList = recommendations!['recommendations'] as List<dynamic>? ?? [];
    
    if (recList.isEmpty) {
      return [
        const Center(
          child: Text(
            'No recommendations available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ];
    }

    // Sort by priority and show high priority items first
    final sortedRecs = List<Map<String, dynamic>>.from(recList);
    sortedRecs.sort((a, b) {
      final priorityOrder = {'high': 0, 'medium': 1, 'low': 2};
      final aPriority = priorityOrder[a['priority']] ?? 3;
      final bPriority = priorityOrder[b['priority']] ?? 3;
      return aPriority.compareTo(bPriority);
    });

    // Show top 4 recommendations
    return sortedRecs.take(4).map((rec) => _buildRecommendationItem(rec)).toList();
  }

  Widget _buildRecommendationItem(Map<String, dynamic> recommendation) {
    final category = recommendation['category'] as String? ?? 'Clinical Action';
    final priority = recommendation['priority'] as String? ?? 'medium';
    final content = recommendation['recommendation'] as String? ?? 'No recommendation available';
    final urgency = recommendation['urgency'] as String? ?? 'Standard timeline';
    final evidence = recommendation['evidence'] as String? ?? '';
    
    Color priorityColor;
    IconData priorityIcon;
    
    switch (priority) {
      case 'high':
        priorityColor = const Color(0xFFE53E3E);
        priorityIcon = Icons.priority_high;
        break;
      case 'medium':
        priorityColor = const Color(0xFFFF7043);
        priorityIcon = Icons.schedule;
        break;
      case 'low':
        priorityColor = const Color(0xFF2E8B57);
        priorityIcon = Icons.check_circle_outline;
        break;
      default:
        priorityColor = Colors.grey;
        priorityIcon = Icons.info_outline;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: priorityColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: priorityColor.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(priorityIcon, color: priorityColor, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: priorityColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    priority.toUpperCase(),
                    style: TextStyle(
                      color: priorityColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Recommendation content
            Text(
              content,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Timeline and evidence
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    urgency,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            
            if (evidence.isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.science, size: 14, color: Colors.blue[600]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      evidence,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
