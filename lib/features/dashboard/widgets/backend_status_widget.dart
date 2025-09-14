import 'package:flutter/material.dart';
import '../../core/api/backend_controller.dart';

/// Backend Integration Status Widget
/// Shows real-time status of Database + AI/ML/RAG + Backend connection
class BackendStatusWidget extends StatefulWidget {
  const BackendStatusWidget({Key? key}) : super(key: key);

  @override
  State<BackendStatusWidget> createState() => _BackendStatusWidgetState();
}

class _BackendStatusWidgetState extends State<BackendStatusWidget> {
  Map<String, dynamic> _healthStatus = {};
  bool _isLoading = true;
  DateTime? _lastUpdate;

  @override
  void initState() {
    super.initState();
    _checkHealth();
  }

  /// Check backend health status
  Future<void> _checkHealth() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final health = await DgtlBackendController.healthCheck();
      setState(() {
        _healthStatus = health;
        _lastUpdate = DateTime.now();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _healthStatus = {
          'status': 'error',
          'error': e.toString(),
          'services': {},
        };
        _lastUpdate = DateTime.now();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.health_and_safety, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  'DGTL Healthcare System Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: _checkHealth,
                  icon: _isLoading 
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh),
                ),
              ],
            ),
            
            if (_lastUpdate != null) ...[
              Text(
                'Last updated: ${_lastUpdate!.hour}:${_lastUpdate!.minute.toString().padLeft(2, '0')}:${_lastUpdate!.second.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
            ],
            
            if (_isLoading) 
              const Center(child: CircularProgressIndicator())
            else
              _buildStatusDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDetails() {
    final services = _healthStatus['services'] as Map<String, dynamic>? ?? {};
    final overallStatus = _healthStatus['status'] as String? ?? 'unknown';
    
    return Column(
      children: [
        // Overall Status
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getStatusColor(overallStatus),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                _getStatusIcon(overallStatus),
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                'System Status: ${overallStatus.toUpperCase()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Service Details
        Row(
          children: [
            Expanded(
              child: _buildServiceCard(
                'Database',
                services['database'] ?? false,
                Icons.storage,
                _healthStatus['database_connected'] ?? false,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildServiceCard(
                'AI/ML/RAG',
                services['rag'] ?? false,
                Icons.psychology,
                _healthStatus['ai_ml_rag_connected'] ?? false,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        Row(
          children: [
            Expanded(
              child: _buildServiceCard(
                'Clinical Service',
                services['clinical'] ?? false,
                Icons.medical_services,
                true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildServiceCard(
                'Backend API',
                true,
                Icons.cloud,
                _healthStatus['backend_connected'] ?? false,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Additional Services
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildServiceChip('Embedding Service', services['embedding'] ?? false),
            _buildServiceChip('Vector Search', services['vector_search'] ?? false),
            _buildServiceChip('Medication Safety', services['medication'] ?? false),
          ],
        ),
        
        // API Endpoints
        if (_healthStatus['backend_connected'] == true) ...[
          const SizedBox(height: 16),
          const Text(
            'Available API Endpoints:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEndpointRow('Health Check', '/api/health', true),
                _buildEndpointRow('CKD Assessment', '/api/ckd/assess', true),
                _buildEndpointRow('AI Chat Query', '/api/chat/query', true),
                _buildEndpointRow('Symptom Analysis', '/api/symptoms/process', true),
                _buildEndpointRow('RAG Query', '/api/rag/query', true),
                _buildEndpointRow('Medication Safety', '/api/medication/safety', true),
                _buildEndpointRow('Lab Scheduling', '/api/lab/schedule', true),
                _buildEndpointRow('Vitals Tracking', '/api/vitals/track', true),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildServiceCard(String name, bool registered, IconData icon, bool connected) {
    final isHealthy = registered && connected;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHealthy ? Colors.green[50] : Colors.red[50],
        border: Border.all(
          color: isHealthy ? Colors.green[200]! : Colors.red[200]!,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isHealthy ? Colors.green[600] : Colors.red[600],
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isHealthy ? Colors.green[800] : Colors.red[800],
            ),
          ),
          Text(
            isHealthy ? 'Connected' : 'Offline',
            style: TextStyle(
              fontSize: 10,
              color: isHealthy ? Colors.green[600] : Colors.red[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChip(String name, bool status) {
    return Chip(
      label: Text(
        name,
        style: TextStyle(
          fontSize: 10,
          color: status ? Colors.green[800] : Colors.red[800],
        ),
      ),
      backgroundColor: status ? Colors.green[100] : Colors.red[100],
      side: BorderSide(
        color: status ? Colors.green[300]! : Colors.red[300]!,
      ),
    );
  }

  Widget _buildEndpointRow(String name, String endpoint, bool available) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: available ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            endpoint,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'healthy':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'error':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'healthy':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      default:
        return Icons.help;
    }
  }
}
