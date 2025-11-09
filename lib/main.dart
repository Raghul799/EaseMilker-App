import 'package:flutter/material.dart';
import 'Settings page/settings_page.dart';
import 'loading page/loading_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoadingPage(),
      routes: {
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
