import 'package:flutter/material.dart';
import '../widgets/user_top_header.dart';
import '../NavBar/user_navbar.dart';
import '../Settings page/user_settings.dart';
import '../Shop page/user_shop_page.dart';

/// UserHomePage - displays About Us information for regular users
class UserHomePage extends StatefulWidget {
  final int initialIndex;

  const UserHomePage({super.key, this.initialIndex = 0});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildAboutUsContent(context),
          const UserShopPage(),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: AppNavBar(
        selectedIndex: _selectedIndex,
        onTap: (i) {
          setState(() => _selectedIndex = i);
        },
      ),
    );
  }

  Widget _buildAboutUsContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.22;
    if (headerHeight < 110) headerHeight = 110;
    if (headerHeight > 180) headerHeight = 180;

    return Stack(
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
                child: Align(
                  alignment: Alignment.center,
                  child: UserTopHeader(
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
                      padding: EdgeInsets.fromLTRB(
                        size.width * 0.06,
                        size.height * 0.02,
                        size.width * 0.06,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.015),

                          // Logo
                          Center(
                            child: Image.asset(
                              'assets/images/Group 24.png',
                              width: size.width * 0.45,
                              height: size.height * 0.08,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: size.width * 0.45,
                                  height: size.height * 0.08,
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: Icon(Icons.image,
                                        size: size.width * 0.1),
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: size.height * 0.025),

                          // Name section
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: size.width * 0.033,
                              color: const Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.006),
                          Text(
                            'Easemilker',
                            style: TextStyle(
                              fontSize: size.width * 0.043,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF212121),
                            ),
                          ),

                          SizedBox(height: size.height * 0.012),

                          // Email section
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: size.width * 0.033,
                              color: const Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.006),
                          Text(
                            'Azhizensolutions@azhizen.com',
                            style: TextStyle(
                              fontSize: size.width * 0.043,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF212121),
                            ),
                          ),

                          SizedBox(height: size.height * 0.012),

                          // Details section
                          Text(
                            'Details',
                            style: TextStyle(
                              fontSize: size.width * 0.033,
                              color: const Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.006),
                          Text(
                            'EaseMilker is a smart and efficient milking device designed to simplify the dairy process for farmers. It helps in extracting milk from cows safely, hygienically, and quickly without causing discomfort to the animal.',
                            style: TextStyle(
                              fontSize: size.width * 0.040,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF212121),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),

                          SizedBox(height: size.height * 0.022),

                          // Divider with Send button
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 1,
                                color: const Color(0xFFE0E0E0),
                              ),
                              Container(
                                width: size.width * 0.115,
                                height: size.width * 0.115,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 81, 165, 255),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Add send/share functionality
                                  },
                                  padding: EdgeInsets.zero,
                                  icon: Transform.rotate(
                                    angle: -0.785398, // -45 degrees in radians
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: size.width * 0.055,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.025),

                          // Follow Us section
                          Center(
                            child: Text(
                              'Follow Us',
                              style: TextStyle(
                                fontSize: size.width * 0.038,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF9E9E9E),
                              ),
                            ),
                          ),

                          SizedBox(height: size.height * 0.022),

                          // Social media icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    // Add Twitter/X link
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding: EdgeInsets.all(size.width * 0.01),
                                    child: Image.asset(
                                      'assets/images/X.png',
                                      width: size.width * 0.08,
                                      height: size.width * 0.08,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(
                                              Icons.error,
                                              size: size.width * 0.08,
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.04),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    // Add Instagram link
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding: EdgeInsets.all(size.width * 0.01),
                                    child: Image.asset(
                                      'assets/images/insta.png',
                                      width: size.width * 0.08,
                                      height: size.width * 0.08,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(
                                              Icons.error,
                                              size: size.width * 0.08,
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.04),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    // Add Facebook link
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding: EdgeInsets.all(size.width * 0.01),
                                    child: Image.asset(
                                      'assets/images/facebook.png',
                                      width: size.width * 0.08,
                                      height: size.width * 0.08,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(
                                              Icons.error,
                                              size: size.width * 0.08,
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height:0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
