import 'package:flutter/material.dart';
import '../widgets/top_header.dart';
import '../NavBar/navbar.dart';
import '../Home page/home_page.dart';
import 'new_password_page.dart';

/// ForgetPasswordPage - allows users to reset their password
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _machineIdController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _otpController = TextEditingController();

  bool _otpSent = false;
  bool _isLoadingOtp = false;

  @override
  void dispose() {
    _machineIdController.dispose();
    _mobileNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _handleGetOTP() async {
    // Validate machine ID and mobile number before sending OTP
    if (_machineIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your machine id first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_mobileNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your mobile number'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_mobileNumberController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid mobile number'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoadingOtp = true;
    });

    // Simulate API call to send OTP
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoadingOtp = false;
      _otpSent = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP sent to ${_mobileNumberController.text}'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _handleDone() {
    if (_formKey.currentState!.validate()) {
      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Forget Password'),
            content: const Text(
              'Are you sure you want to reset your password?',
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

                  // Implement actual password reset logic
                  try {
                    // Here you would typically:
                    // 1. Verify Machine ID with backend
                    // 2. Verify mobile number
                    // 3. Verify OTP
                    // 4. Navigate to new password page

                    // Simulating API call delay
                    await Future.delayed(const Duration(seconds: 1));

                    if (!mounted) return;

                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('OTP verified successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Navigate to New Password Page
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => const NewPasswordPage(),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Error verifying OTP: $e'),
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

                              // Machine Id field
                              const Text(
                                'Machine Id',
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
                                  controller: _machineIdController,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 13 : 14,
                                    color: const Color(0xFF000000),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter machine id',
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
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your machine id';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Mobile Number field with Get OTP button
                              const Text(
                                'Mobile Number',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final isVerySmallScreen =
                                      constraints.maxWidth < 320;
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: isVerySmallScreen ? 2 : 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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
                                            controller: _mobileNumberController,
                                            keyboardType: TextInputType.phone,
                                            style: TextStyle(
                                              fontSize: isSmallScreen ? 13 : 14,
                                              color: const Color(0xFF000000),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Enter mobile number',
                                              hintStyle: TextStyle(
                                                fontSize: isSmallScreen
                                                    ? 13
                                                    : 14,
                                                color: const Color(0xFFAAAAAA),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: isSmallScreen
                                                        ? 12
                                                        : 16,
                                                    vertical: isSmallScreen
                                                        ? 14
                                                        : 16,
                                                  ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Enter mobile number';
                                              }
                                              if (value.length < 10) {
                                                return 'Invalid number';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: isSmallScreen ? 8 : 12),
                                      SizedBox(
                                        height: isSmallScreen ? 48 : 52,
                                        child: ElevatedButton(
                                          onPressed: _isLoadingOtp
                                              ? null
                                              : _handleGetOTP,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: _otpSent
                                                ? Colors.green
                                                : const Color(0xFF1976D2),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            elevation: 2,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: isVerySmallScreen
                                                  ? 12
                                                  : (isSmallScreen ? 16 : 20),
                                            ),
                                          ),
                                          child: _isLoadingOtp
                                              ? SizedBox(
                                                  width: isSmallScreen
                                                      ? 18
                                                      : 20,
                                                  height: isSmallScreen
                                                      ? 18
                                                      : 20,
                                                  child:
                                                      const CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                )
                                              : FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    _otpSent
                                                        ? 'Resend'
                                                        : 'Get OTP',
                                                    style: TextStyle(
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              const SizedBox(height: 20),

                              // OTP field
                              const Text(
                                'OTP',
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
                                  controller: _otpController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 13 : 14,
                                    color: const Color(0xFF000000),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter OTP',
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
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter OTP';
                                    }
                                    if (value.length < 4) {
                                      return 'Please enter a valid OTP';
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
