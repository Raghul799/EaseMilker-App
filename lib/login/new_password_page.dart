import 'package:flutter/material.dart';
import '../widgets/top_header.dart';
import '../NavBar/navbar.dart';
import '../Home page/home_page.dart';
import '../widgets/done_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// NewPasswordPage - allows users to set a new password after verification
class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleDone() {
    if (_formKey.currentState!.validate()) {
      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change Password'),
            content: const Text(
              'Are you sure you want to change your password?',
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () async {
                  // Capture context and navigator before async operations
                  final navigator = Navigator.of(context);
                  final scaffoldMessenger = ScaffoldMessenger.of(context);

                  // Close dialog
                  navigator.pop();

                  // Implement actual password change logic
                  try {
                    // Here you would typically:
                    // 1. Send new password to backend
                    // 2. Handle the response

                    // For now, simulating with SharedPreferences
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                      'user_password',
                      _newPasswordController.text,
                    );

                    if (!mounted) return;

                    // Navigate to Done page
                    navigator.pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => DonePage(
                          message: 'Done!',
                          onComplete: () {
                            // Navigate back to home after done page
                            Navigator.of(ctx).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage(initialIndex: 4),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Error changing password: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Color(0xFF0B57A7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final horizontalPadding = isSmallScreen ? 16.0 : 20.0;

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
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          isSmallScreen ? 16 : 20,
                          horizontalPadding,
                          0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                'Change Password',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 22 : 26,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF000000),
                                ),
                              ),

                              SizedBox(height: isSmallScreen ? 18 : 24),

                              // New password field
                              const Text(
                                'new Password',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFDDDDDD),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.06,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: _newPasswordController,
                                  obscureText: _obscureNewPassword,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 13 : 14,
                                    color: const Color(0xFF000000),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter new password',
                                    hintStyle: TextStyle(
                                      fontSize: isSmallScreen ? 13 : 14,
                                      color: const Color(0xFFAAAAAA),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 12 : 16,
                                      vertical: isSmallScreen ? 14 : 16,
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: IconButton(
                                        icon: Icon(
                                          _obscureNewPassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: const Color(0xFF9E9E9E),
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureNewPassword =
                                                !_obscureNewPassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a new password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Confirm password field
                              const Text(
                                'Confirm Password',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFDDDDDD),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.06,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: _obscureConfirmPassword,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 13 : 14,
                                    color: const Color(0xFF000000),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Re-enter new password',
                                    hintStyle: TextStyle(
                                      fontSize: isSmallScreen ? 13 : 14,
                                      color: const Color(0xFFAAAAAA),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 12 : 16,
                                      vertical: isSmallScreen ? 14 : 16,
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: IconButton(
                                        icon: Icon(
                                          _obscureConfirmPassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: const Color(0xFF9E9E9E),
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword =
                                                !_obscureConfirmPassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your new password';
                                    }
                                    if (value != _newPasswordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Done button
                              SizedBox(
                                width: double.infinity,
                                height: isSmallScreen ? 48 : 52,
                                child: ElevatedButton(
                                  onPressed: _handleDone,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1976D2),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 15 : 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: isSmallScreen ? 12 : 16),

                              // Confirmation message
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 16.0 : 24.0,
                                  ),
                                  child: Text(
                                    '"Are you sure you want to change your password?" If yes remain it',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 11 : 12,
                                      color: Colors.grey[600],
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
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
}
