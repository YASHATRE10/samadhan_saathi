import 'package:flutter/material.dart';
import 'package:samadhan_saathi/screens/splash.dart';
import 'package:samadhan_saathi/screens/login_selection.dart';
import 'package:samadhan_saathi/screens/register.dart';
import 'package:samadhan_saathi/screens/home.dart';
import 'package:samadhan_saathi/screens/tahasildar_login.dart';
import 'package:samadhan_saathi/screens/user_login.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => SplashScreen(),
  '/login': (context) => LoginSelectionPage(),
  '/register': (context) => RegisterPage(),
  '/home': (context) => HomePage(),
  '/userLogin': (context) => UserLoginPage(),
  '/tahasildarLogin': (context) => TahasildarLoginPage(),
};
