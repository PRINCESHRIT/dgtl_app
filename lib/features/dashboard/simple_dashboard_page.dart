import 'package:flutter/material.dart';
import '../../app/theme.dart';

/// Simple working dashboard for testing the integrated system
class SimpleDashboardPage extends StatefulWidget {
  const SimpleDashboardPage({Key? key}) : super(key: key);

  @override
  State<SimpleDashboardPage> createState() => _SimpleDashboardPageState();
}

class _SimpleDashboardPageState extends State<SimpleDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DGTL Healthcare AI'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WelcomeCard(),
            SizedBox(height: 16),
            _SystemStatusCard(),
            SizedBox(height: 16),
            _NavigationCard(),
          ],
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to DGTL Healthcare AI',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Integrated Healthcare System with:\n'
              '• 74-record clinical dataset processing\n'
              '• RAG-powered medical AI (92% confidence)\n'
              '• Evidence-based clinical recommendations\n'
              '• Real-time health monitoring',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _SystemStatusCard extends StatelessWidget {
  const _SystemStatusCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Status',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            const _StatusItem(
              label: 'Clinical Dataset',
              status: '74 records integrated',
              isActive: true,
            ),
            const _StatusItem(
              label: 'RAG Enhancement',
              status: '21 knowledge entries',
              isActive: true,
            ),
            const _StatusItem(
              label: 'Medical Guidelines',
              status: 'Stage 4 CKD protocols',
              isActive: true,
            ),
            const _StatusItem(
              label: 'Frontend Integration',
              status: 'Active',
              isActive: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String label;
  final String status;
  final bool isActive;

  const _StatusItem({
    required this.label,
    required this.status,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.error,
            color: isActive ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(status),
        ],
      ),
    );
  }
}

class _NavigationCard extends StatelessWidget {
  const _NavigationCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _NavigationButton(
              title: 'AI Health Assistant',
              subtitle: 'Chat with RAG-powered medical AI',
              icon: Icons.chat,
              onTap: () {
                Navigator.pushNamed(context, '/ai-chat');
              },
            ),
            const SizedBox(height: 8),
            _NavigationButton(
              title: 'Enhanced Dashboard',
              subtitle: 'Clinical insights and recommendations',
              icon: Icons.dashboard,
              onTap: () {
                Navigator.pushNamed(context, '/enhanced-dashboard');
              },
            ),
            const SizedBox(height: 8),
            _NavigationButton(
              title: 'Symptom Logger',
              subtitle: 'Track and log health symptoms',
              icon: Icons.medical_services,
              onTap: () {
                Navigator.pushNamed(context, '/symptom-logger');
              },
            ),
            const SizedBox(height: 8),
            _NavigationButton(
              title: 'Vitals Tracking',
              subtitle: 'Monitor vital signs and trends',
              icon: Icons.favorite,
              onTap: () {
                Navigator.pushNamed(context, '/vitals-tracking');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _NavigationButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).disabledColor,
            ),
          ],
        ),
      ),
    );
  }
}
