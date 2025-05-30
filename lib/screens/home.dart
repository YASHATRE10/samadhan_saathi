import 'package:flutter/material.dart';
import 'package:samadhan_saathi/screens/mini_sahyadri.dart';
import 'package:samadhan_saathi/screens/govt_scheme.dart';
import 'package:samadhan_saathi/components/app_drawer.dart'; 
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _selectLanguage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(title: const Text('English 🇬🇧'), onTap: () => Navigator.pop(context)),
            ListTile(title: const Text('Hindi 🇮🇳'), onTap: () => Navigator.pop(context)),
            ListTile(title: const Text('Marathi 🇮🇳'), onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(onSelectLanguage: _selectLanguage), 
      appBar: AppBar(
        title: const Text('SamadhanSaathi 🌾'),
        backgroundColor: Colors.green[800],
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/logo/logo.jpg', height: 100),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  _buildTile(context, 'File Complaint', Icons.report,
                      const [Colors.orange, Colors.deepOrange]),
                  _buildTile(context, 'Complaint History', Icons.history,
                      [Colors.green.shade600!, Colors.green.shade800!]),
                  _buildTile(context, 'Mini Sahyadri', Icons.article,
                      [Colors.green.shade400!, Colors.green.shade700!],
                      onTap: () => _navigateTo(context, const MiniSahyadriPage())),
                  _buildTile(context, 'Govt Schemes', Icons.account_balance,
                      const [Colors.teal, Colors.green],
                      onTap: () => _navigateTo(context, const GovtSchemesPage())),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Chat Bot feature coming soon!')),
                  );
                },
                label: const Text('Chat Bot 🤖'),
                icon: const Icon(Icons.chat),
                backgroundColor: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon,
      List<Color> gradientColors,
      {VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap ?? () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
