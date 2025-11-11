import 'package:flutter/material.dart';
import 'dart:async';
import '../Home page/home_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to home page after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  // Top spacer
                  const Spacer(flex: 3),
                  
                  // Center content (Cow + Logo)
                  Flexible(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Cow Image
                        Flexible(
                          flex: 7,
                          child: Image.asset(
                            'assets/images/Group 18.png',
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.35,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.012),
                        // Ease Milker Logo (smaller)
                        Flexible(
                          flex: 3,
                          child: Image.asset(
                            'assets/images/Group 24.png',
                            width: screenWidth * 0.48,
                            height: screenHeight * 0.08,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Bottom spacer
                  const Spacer(flex: 4),
                  
                  // Bottom Text (2 lines only)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.08,
                      0,
                      screenWidth * 0.08,
                      screenHeight * 0.04,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: screenWidth * 0.036,
                          color: Colors.grey[800],
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(text: 'welcome to easemilker app the automated milking\n'),
                          TextSpan(text: 'machine monitoring'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
