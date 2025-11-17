import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Pages
import 'Settings page/settings_page.dart';
import 'Settings page/about_us_page.dart';
import 'Settings page/help_contact_page.dart';
import 'login/change_password_page.dart';
import 'loading page/loading_page.dart';
import 'widgets/message_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase before app launch
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ease Milker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoadingPage(),
      routes: {
        '/settings': (context) => const SettingsPage(),
        '/about-us': (context) => const AboutUsPage(),
        '/help-contact': (context) => const HelpContactPage(),
        '/change-password': (context) => const ChangePasswordPage(),
        '/messages': (context) => const MessagePage(),
      },
    );
  }
}
