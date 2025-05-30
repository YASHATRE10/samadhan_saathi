import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? onHomeTap;

  const AppDrawer({super.key, this.onHomeTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade800, Colors.green.shade500],
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
          _drawerItem(Icons.home, 'home'.tr(), onTap: () {
            if (onHomeTap != null) {
              onHomeTap!();
            } else {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          }),
          _drawerItem(Icons.person, 'user_profile'.tr()),
          _drawerItem(Icons.contact_mail, 'contact'.tr()),
          _drawerItem(Icons.info, 'about_us'.tr()),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('select_language'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('English'),
            onTap: () {
              context.setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('हिन्दी'),
            onTap: () {
              context.setLocale(const Locale('hi'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('मराठी'),
            onTap: () {
              context.setLocale(const Locale('mr'));
              Navigator.pop(context);
            },
          ),
          const Divider(),
          _drawerItem(
  Icons.settings,
  'settings'.tr(),
  onTap: () {
    Navigator.pop(context); // Close drawer first
    Navigator.pushNamed(context, '/settings');
  },
),
_drawerItem(
  Icons.logout,
  'log_out'.tr(),
  onTap: () {
    Navigator.pop(context); // Close drawer first
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  },
),
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
