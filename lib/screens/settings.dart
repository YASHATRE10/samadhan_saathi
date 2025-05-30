import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  void _changeLanguage(Locale locale) {
    context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        backgroundColor: Colors.green[800],
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (val) {
              setState(() {
                _notificationsEnabled = val;
              });
            },
            secondary: Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _darkModeEnabled,
            onChanged: (val) {
              setState(() {
                _darkModeEnabled = val;
              });
            },
            secondary: Icon(Icons.dark_mode),
          ),
          const Divider(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Change Language',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: const Text('English'),
            onTap: () => _changeLanguage(const Locale('en')),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: const Text('हिन्दी'),
            onTap: () => _changeLanguage(const Locale('hi')),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: const Text('मराठी'),
            onTap: () => _changeLanguage(const Locale('mr')),
          ),
        ],
      ),
    );
  }
}
