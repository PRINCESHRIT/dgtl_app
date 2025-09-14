import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/services/clinical_data_service.dart';
import 'widgets/clinical_insights_card.dart';
import 'widgets/health_trends_card.dart';
import 'widgets/recommendations_card.dart';
import 'widgets/monitoring_alerts_card.dart';

/// Enhanced Dashboard Page with Clinical Data Integration
class EnhancedDashboardPage extends StatefulWidget {
  const EnhancedDashboardPage({super.key});

  @override
  State<EnhancedDashboardPage> createState() => _EnhancedDashboardPageState();
}

class _EnhancedDashboardPageState extends State<EnhancedDashboardPage> {
  final ClinicalDataService _clinicalService = ClinicalDataService();
  
  Map<String, dynamic>? _patientContext;
  Map<String, dynamic>? _recommendations;
  Map<String, dynamic>? _insights;
  Map<String, List<Map<String, dynamic>>>? _trends;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    
    try {
      final results = await Future.wait([
        _clinicalService.getPatientContext('CLINICAL-P001'),
        _clinicalService.getClinicalRecommendations(),
        _clinicalService.getPersonalizedInsights(),
        _clinicalService.getHealthTrends(),
      ]);

      setState(() {
        _patientContext = results[0] as Map<String, dynamic>?;
        _recommendations = results[1] as Map<String, dynamic>?;
        _insights = results[2] as Map<String, dynamic>?;
        _trends = results[3] as Map<String, List<Map<String, dynamic>>>?;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Dashboard data loading error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadDashboardData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with patient context
                _buildPatientHeader()
                    .animate()
                    .fadeIn(delay: 100.ms)
                    .slideY(begin: -0.1),
                
                const SizedBox(height: 24),
                
                // Loading indicator
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E8B57)),
                      ),
                    ),
                  ),
                
                // Dashboard content
                if (!_isLoading) ...[
                  // Clinical Insights Overview
                  ClinicalInsightsCard(
                    patientContext: _patientContext,
                    insights: _insights,
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                  
                  const SizedBox(height: 16),
                  
                  // High-Priority Recommendations
                  RecommendationsCard(
                    recommendations: _recommendations,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                  
                  const SizedBox(height: 16),
                  
                  // Health Trends Charts
                  HealthTrendsCard(
                    trends: _trends,
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                  
                  const SizedBox(height: 16),
                  
                  // Monitoring Alerts
                  MonitoringAlertsCard(
                    patientContext: _patientContext,
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
                  
                  const SizedBox(height: 16),
                  
                  // Quick Actions
                  _buildQuickActions()
                      .animate()
                      .fadeIn(delay: 600.ms)
                      .slideY(begin: 0.1),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientHeader() {
    if (_patientContext == null) {
      return Card(
        elevation: 2,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: const Text(
            'Loading patient data...',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final egfr = _patientContext!['latest_egfr']?['value']?.toString() ?? 'N/A';
    final creatinine = _patientContext!['latest_creatinine']?['value']?.toString() ?? 'N/A';
    final stage = _patientContext!['ckd_stage']?.toString() ?? 'Unknown';
    final totalRecords = _patientContext!['total_records']?.toString() ?? '0';
    final dataRange = _patientContext!['data_range'] as Map<String, dynamic>?;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF2E8B57), Color(0xFF3CB371)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.person, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Text(
                  'Your Health Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Key metrics
            Row(
              children: [
                Expanded(
                  child: _buildMetricColumn('eGFR', egfr, 'ml/min', 
                      _getEGFRColor(double.tryParse(egfr) ?? 0)),
                ),
                Expanded(
                  child: _buildMetricColumn('Creatinine', creatinine, 'mg/dl', Colors.white70),
                ),
                Expanded(
                  child: _buildMetricColumn('CKD Stage', 
                      stage.replaceAll('Stage ', '').split(' ')[0], '', Colors.white70),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Data overview
            if (dataRange != null)
              Text(
                'Clinical data: $totalRecords records from ${dataRange['start']} to ${dataRange['end']}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getEGFRColor(double egfr) {
    if (egfr < 15) return Colors.red[300]!;
    if (egfr < 30) return Colors.orange[300]!;
    if (egfr < 60) return Colors.yellow[300]!;
    return Colors.green[300]!;
  }

  Widget _buildMetricColumn(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (unit.isNotEmpty)
          Text(
            unit,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 10,
            ),
          ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.chat,
                    label: 'Ask AI Assistant',
                    color: const Color(0xFF2E8B57),
                    onTap: () => Navigator.pushNamed(context, '/ai-chat'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.add,
                    label: 'Log Symptoms',
                    color: const Color(0xFF1976D2),
                    onTap: () => Navigator.pushNamed(context, '/symptom-logger'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.trending_up,
                    label: 'View Trends',
                    color: const Color(0xFFFF7043),
                    onTap: () => Navigator.pushNamed(context, '/vitals-tracking'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.schedule,
                    label: 'Appointments',
                    color: const Color(0xFF8E24AA),
                    onTap: () => Navigator.pushNamed(context, '/lab-scheduler'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
