import 'package:flutter/material.dart';
import 'Home page/home_page.dart';
import 'Settings page/settings_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
