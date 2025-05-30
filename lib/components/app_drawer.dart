import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Function(BuildContext)? onSelectLanguage;
  final VoidCallback? onHomeTap;  // Add callback for Home tap

  const AppDrawer({super.key, this.onSelectLanguage, this.onHomeTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade800!, Colors.green.shade500!],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/logo/logo.jpg', height: 60),
                const SizedBox(height: 10),
                const Text(
                  'SamadhanSaathi ⛅',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          _drawerItem(Icons.home, 'Home', onTap: () {
            // If a callback is provided, call it
            if (onHomeTap != null) {
              onHomeTap!();
            } else {
              // Otherwise, default navigation to home page (replace with your route)
              Navigator.of(context).pushReplacementNamed('/home');
            }
          }),
          _drawerItem(Icons.person, 'User Profile'),
          _drawerItem(Icons.contact_mail, 'Contact'),
          _drawerItem(Icons.info, 'About Us'),
          _drawerItem(Icons.settings, 'Settings', onTap: () {
            if (onSelectLanguage != null) onSelectLanguage!(context);
          }),
          _drawerItem(Icons.logout, 'Log Out'),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[800]),
      title: Text(title),
      onTap: onTap ?? () {},
    );
  }
}
