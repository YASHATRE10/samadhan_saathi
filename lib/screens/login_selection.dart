import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; 

class LoginSelectionPage extends StatelessWidget {
  const LoginSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Login Selection'),
        backgroundColor: Colors.green[800],
        elevation: 4,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/selection.json', // Lottie file
                  height: 180,
                ),
                const SizedBox(height: 30),
                _buildLoginOption(
                  context,
                  title: 'User Login',
                  icon: Icons.person,
                  color: Colors.teal,
                  routeName: '/userLogin',
                ),
                const SizedBox(height: 20),
                _buildLoginOption(
                  context,
                  title: 'Tahasildar Login',
                  icon: Icons.admin_panel_settings,
                  color: Colors.deepOrange,
                  routeName: '/tahasildarLogin',
                ),
                const SizedBox(height: 20),
                _buildLoginOption(
                  context,
                  title: 'Register',
                  icon: Icons.app_registration,
                  color: Colors.indigo,
                  routeName: '/register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginOption(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required String routeName}) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Text(title, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        onPressed: () => Navigator.pushNamed(context, routeName),
      ),
    );
  }
}
