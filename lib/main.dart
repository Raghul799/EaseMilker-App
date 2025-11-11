import 'package:flutter/material.dart';
import 'Settings page/settings_page.dart';
import 'Settings page/about_us_page.dart';
import 'Settings page/help_contact_page.dart';
import 'loading page/loading_page.dart';
import 'widgets/message_page.dart';

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
        '/about-us': (context) => const AboutUsPage(),
        '/help-contact': (context) => const HelpContactPage(),
        '/messages': (context) => const MessagePage(),
      },
    );
  }
}
