import 'package:flutter/material.dart';
import '../widgets/top_header.dart';
import '../NavBar/navbar.dart';
import '../Home page/home_page.dart';

/// AboutUsPage - displays information about Ease Milker
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),

                            // Logo
                            Center(
                              child: Image.asset(
                                'assets/images/Group 24.png',
                                width: 180,
                                height: 70,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 180,
                                    height: 70,
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(Icons.image, size: 40),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Name section
                            const Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF9E9E9E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Ease Milker',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF212121),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Email section
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF9E9E9E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Azhizensolutions@azhizen.com',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF212121),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Details section
                            const Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF9E9E9E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Ease Milker is a smart and efficient milking device designed to simplify the dairy process for farmers. It helps in extracting milk from cows safely, hygienically, and quickly without causing discomfort to the animal.',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF212121),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),

                            const SizedBox(height: 32),

                            // Divider with Send button
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  color: const Color(0xFFE0E0E0),
                                ),
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0B57A7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // Add send/share functionality
                                    },
                                    padding: EdgeInsets.zero,
                                    icon: Transform.rotate(
                                      angle:
                                          -0.785398, // -45 degrees in radians (matching the image angle)
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),

                            // Follow Us section
                            const Center(
                              child: Text(
                                'Follow Us',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Social media icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSocialIconWithCustom(
                                  child: const Text(
                                    '𝕏',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF212121),
                                    ),
                                  ),
                                  onTap: () {
                                    // Add Twitter/X link
                                  },
                                ),
                                const SizedBox(width: 28),
                                _buildSocialIconWithCustom(
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF212121),
                                        width: 2.5,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF212121),
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // Add Instagram link
                                  },
                                ),
                                const SizedBox(width: 28),
                                _buildSocialIconWithCustom(
                                  child: const Text(
                                    'f',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF212121),
                                      fontFamily: 'serif',
                                    ),
                                  ),
                                  onTap: () {
                                    // Add Facebook link
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),
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
                  // Already on settings-related page (About Us), go back to settings
                  Navigator.pop(context);
                } else {
                  // Navigate to HomePage with the selected tab index
                  // This will show the correct tab in the IndexedStack
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

  Widget _buildSocialIconWithCustom({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF212121), width: 1.8),
        ),
        child: Center(child: child),
      ),
    );
  }
}
