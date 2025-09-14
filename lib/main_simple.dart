import 'package:flutter/material.dart';

void main() {
  runApp(const DgtlHealthcareApp());
}

class DgtlHealthcareApp extends StatelessWidget {
  const DgtlHealthcareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DGTL Healthcare',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const HealthcareDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HealthcareDashboard extends StatefulWidget {
  const HealthcareDashboard({super.key});

  @override
  State<HealthcareDashboard> createState() => _HealthcareDashboardState();
}

class _HealthcareDashboardState extends State<HealthcareDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardHome(),
    const VitalsScreen(),
    const BPTrackingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DGTL Healthcare',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('स्वास्थ्य अलर्ट - सभी सामान्य')),
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'डैशबोर्ड',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'बायोमार्कर',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: 'रक्तचाप',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'प्रोफाइल',
          ),
        ],
      ),
    );
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.health_and_safety,
                    size: 48,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'स्वास्थ्य स्थिति',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'सभी पैरामीटर सामान्य',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'आज के रीडिंग',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildHealthCard(
                  'रक्तचाप',
                  '120/80 mmHg',
                  Icons.monitor_heart,
                  Colors.blue,
                ),
                _buildHealthCard(
                  'क्रिएटिनिन',
                  '1.0 mg/dL',
                  Icons.water_drop,
                  Colors.orange,
                ),
                _buildHealthCard(
                  'eGFR',
                  '90 mL/min',
                  Icons.speed,
                  Colors.green,
                ),
                _buildHealthCard(
                  'HbA1c',
                  '6.5%',
                  Icons.bloodtype,
                  Colors.red,
                ),
                _buildHealthCard(
                  'हीमोग्लोबिन',
                  '13.5 g/dL',
                  Icons.favorite,
                  Colors.pink,
                ),
                _buildHealthCard(
                  'वजन',
                  '70 kg',
                  Icons.scale,
                  Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class VitalsScreen extends StatelessWidget {
  const VitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CKD बिग 7 बायोमार्कर',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildVitalCard('क्रिएटिनिन', '1.0 mg/dL', 'सामान्य', Colors.green),
                _buildVitalCard('eGFR', '90 mL/min/1.73m²', 'सामान्य', Colors.green),
                _buildVitalCard('HbA1c', '6.5%', 'नियंत्रित', Colors.orange),
                _buildVitalCard('एल्ब्यूमिन', '4.0 g/dL', 'सामान्य', Colors.green),
                _buildVitalCard('हीमोग्लोबिन', '13.5 g/dL', 'सामान्य', Colors.green),
                _buildVitalCard('फॉस्फोरस', '3.5 mg/dL', 'सामान्य', Colors.green),
                _buildVitalCard('पैराथाइरॉइड हार्मोन', '45 pg/mL', 'सामान्य', Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(String name, String value, String status, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(Icons.favorite, color: color),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(value),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class BPTrackingScreen extends StatelessWidget {
  const BPTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'रक्तचाप ट्रैकिंग',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '120',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600],
                            ),
                          ),
                          const Text('सिस्टोलिक'),
                        ],
                      ),
                      const Text(
                        '/',
                        style: TextStyle(fontSize: 32),
                      ),
                      Column(
                        children: [
                          Text(
                            '80',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600],
                            ),
                          ),
                          const Text('डायास्टोलिक'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'सामान्य रक्तचाप',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showBPInputDialog(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('नया रीडिंग जोड़ें'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'हाल की रीडिंग',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                _buildBPHistoryItem('120/80', 'आज 10:30 AM', Colors.green),
                _buildBPHistoryItem('118/75', 'कल 10:15 AM', Colors.green),
                _buildBPHistoryItem('125/82', '2 दिन पहले', Colors.orange),
                _buildBPHistoryItem('122/79', '3 दिन पहले', Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBPHistoryItem(String bp, String time, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(Icons.monitor_heart, color: color),
        ),
        title: Text(
          bp,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(time),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      ),
    );
  }

  void _showBPInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('नया रक्तचाप रीडिंग'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'सिस्टोलिक (mmHg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'डायास्टोलिक (mmHg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('रद्द करें'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('रीडिंग सफलतापूर्वक सेव की गई')),
              );
            },
            child: const Text('सेव करें'),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'राहुल शर्मा',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '45 वर्ष • CKD स्टेज 2',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _buildProfileItem(
                  Icons.medical_information,
                  'मेडिकल हिस्ट्री',
                  'डायबिटीज, हाइपरटेंशन',
                ),
                _buildProfileItem(
                  Icons.medication,
                  'दवाइयां',
                  'मेटफॉर्मिन, लिसिनोप्रिल',
                ),
                _buildProfileItem(
                  Icons.phone,
                  'फोन नंबर',
                  '+91 98765 43210',
                ),
                _buildProfileItem(
                  Icons.email,
                  'ईमेल',
                  'rahul.sharma@example.com',
                ),
                _buildProfileItem(
                  Icons.location_on,
                  'पता',
                  'नई दिल्ली, भारत',
                ),
                _buildProfileItem(
                  Icons.emergency,
                  'आपातकालीन संपर्क',
                  'प्रिया शर्मा - 98765 43211',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[600]),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(value),
      ),
    );
  }
}
