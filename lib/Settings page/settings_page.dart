import 'package:flutter/material.dart';
import '../widgets/top_header.dart';
import '../Home page/home_page.dart';

/// SettingsPage - implements the app settings UI similar to the provided design.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _buildTile(
    BuildContext context,
    Widget iconWidget,
    String title,
    String? subtitle, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF6FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: iconWidget),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
            ),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFF9E9E9E)),
      onTap:
          onTap ??
          () {
            // placeholder: later you can wire each tile to real actions
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.22;
    if (headerHeight < 110) headerHeight = 110;
    if (headerHeight > 180) headerHeight = 180;

    return Scaffold(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),

                            // Manage Account card
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(25),
                                    blurRadius: 15,
                                    offset: const Offset(0, 3),
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      14,
                                      16,
                                      6,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Manage Account',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildTile(
                                    context,
                                    const Icon(
                                      Icons.volume_up_outlined,
                                      color: Color(0xFF0B57A7),
                                      size: 22,
                                    ),
                                    'Alert Sound',
                                    null,
                                  ),
                                  _buildTile(
                                    context,
                                    const Icon(
                                      Icons.language,
                                      color: Color(0xFF0B57A7),
                                      size: 22,
                                    ),
                                    'Change Language',
                                    null,
                                  ),
                                  _buildTile(
                                    context,
                                    const Icon(
                                      Icons.lock_outline,
                                      color: Color(0xFF0B57A7),
                                      size: 22,
                                    ),
                                    'Change password',
                                    null,
                                  ),
                                  _buildTile(
                                    context,
                                    const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Color(0xFF0B57A7),
                                      size: 22,
                                    ),
                                    'Shop',
                                    null,
                                    onTap: () {
                                      // Navigate to HomePage and open the Shop tab (index 3)
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(initialIndex: 3),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                  ),
                                  _buildTile(
                                    context,
                                    const Icon(
                                      Icons.event_note_outlined,
                                      color: Color(0xFF0B57A7),
                                      size: 22,
                                    ),
                                    'My Booking',
                                    null,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Issues and Information card
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(25),
                                    blurRadius: 15,
                                    offset: const Offset(0, 3),
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      14,
                                      16,
                                      6,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Issues and Information',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildTile(
                                    context,
                                    const Icon(
                                      Icons.help_outline,
                                      color: Color(0xFF0B57A7),
                                      size: 22,
                                    ),
                                    'Help & Contact',
                                    'Apply & Ask if issue you face in the app',
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/help-contact',
                                      );
                                    },
                                  ),
                                  _buildTile(
                                    context,
                                    const Icon(
                                      Icons.business_outlined,
                                      color: Color(0xFF0B57A7),
                                      size: 22,
                                    ),
                                    'About us',
                                    'get details and know what we provide',
                                    onTap: () {
                                      Navigator.pushNamed(context, '/about-us');
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 22),

                            // Logout button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // add logout logic
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Color(0xFF0B57A7),
                                ),
                                label: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  child: Center(
                                    child: Text(
                                      'LOGOUT',
                                      style: TextStyle(
                                        color: Color(0xFF0B57A7),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF0B57A7),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size.fromHeight(48),
                                ),
                              ),
                            ),

                            SizedBox(
                              height:
                                  32 + MediaQuery.of(context).padding.bottom,
                            ),
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
      ),
    );
  }
}
