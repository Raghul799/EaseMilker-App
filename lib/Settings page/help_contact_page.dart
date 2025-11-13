import 'package:flutter/material.dart';
import '../widgets/top_header.dart';
import '../NavBar/navbar.dart';
import '../Home page/home_page.dart';

/// HelpContactPage - displays help and support information
class HelpContactPage extends StatelessWidget {
  const HelpContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.22;
    if (headerHeight < 110) headerHeight = 110;
    if (headerHeight > 180) headerHeight = 180;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.2, -0.98),
                end: Alignment(-0.2, 0.98),
                colors: [Color(0xFF006CC7), Color(0xFF68B6FF)],
                stops: [0.0246, 0.3688],
              ),
            ),
          ),

          // Main column
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: SizedBox(
                  height: headerHeight,
                  child: const Align(
                    alignment: Alignment.center,
                    child: TopHeader(
                      name: 'Dhanush Kumar S',
                      idText: 'EM0214KI',
                      avatarAsset: 'assets/images/Frame 298.png',
                    ),
                  ),
                ),
              ),

              // White rounded content
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: 90 + MediaQuery.of(context).padding.bottom,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Help? title
                            const Text(
                              'Help?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF212121),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Search bar
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search Question here',
                                  hintStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFAAAAAA),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xFF9E9E9E),
                                    size: 24,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // COMMON ASK QUESTION? section
                            const Text(
                              'COMMON ASK QUESTION?',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFAAAAAA),
                                letterSpacing: 0.8,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Question list
                            _buildQuestionItem('How to get account back?'),
                            _buildDivider(),
                            _buildQuestionItem('How to get password back?'),
                            _buildDivider(),
                            _buildQuestionItem('How can I order the item'),

                            const SizedBox(height: 16),

                            // View more button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  // Add view more functionality
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'View more',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF0B57A7),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Get your Answer section
                            const Text(
                              'Get your Answer By Entering Your Question?',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF212121),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Question input field
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                              ),
                              child: const TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Enter you question here',
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFAAAAAA),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Submit button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add submit functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0B57A7),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AppNavBar(
              selectedIndex: 4, // Settings tab selected
              onTap: (index) {
                if (index == 4) {
                  // Already on settings-related page, go back to settings
                  Navigator.pop(context);
                } else {
                  // Navigate to HomePage with the selected tab index
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(initialIndex: index),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionItem(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        question,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF212121),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: const Color(0xFFE0E0E0));
  }
}
