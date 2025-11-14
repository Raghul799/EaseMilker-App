import 'package:flutter/material.dart';
import '../NavBar/navbar.dart';
import '../History page/history_page.dart';
import '../Shop page/shop_page.dart';
import '../widgets/top_header.dart';
import '../Settings page/settings_page.dart';
import '../Premium page/premium_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;
  // Default states as backend is not connected
  bool _isConnected = false; // Set to true to show connected state
  bool _isEaseMilkerOn = false;
  bool _isMachineWorking = true;
  String _machineId = '';

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isConnected = prefs.getBool('isConnected') ?? false;
      _machineId = prefs.getString('machineId') ?? '';
    });
    // Only show the machine connection dialog if Home tab is active and not connected.
    if (_selectedIndex == 0 && !_isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showMachineConnectionDialog();
      });
    }
  }

  void _showMachineConnectionDialog() {
    final TextEditingController machineIdController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Connect to Machine',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please enter the Machine ID to connect:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: machineIdController,
                decoration: InputDecoration(
                  labelText: 'Machine ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final enteredId = machineIdController.text.trim();
                if (enteredId.isNotEmpty) {
                  Navigator.of(context).pop(); // Close the input dialog
                  _showWifiLoadingDialog(enteredId);
                } else {
                  // Show error or do nothing
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid Machine ID'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Connect',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showWifiLoadingDialog(String machineId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Connecting to WiFi...',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Machine ID: $machineId',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    // Simulate connection delay
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        setState(() {
          _machineId = machineId;
          _isConnected = true;
          _isEaseMilkerOn = true; // Turn on Easemilker after connection
          _isMachineWorking = false; // Turn off machine working after connection
        });
        // Save connection state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isConnected', true);
        await prefs.setString('machineId', machineId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use an IndexedStack so we keep state for each tab and keep the
    // bottom navigation visible while switching pages.
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(context),
          const HistoryPage(),
          const PremiumPage(),
          const ShopPage(),
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

  Widget _buildHomeContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    
    // Responsive sizing
    double headerHeight = size.height * 0.20;
    if (headerHeight < 100) headerHeight = 100;
    if (headerHeight > 160) headerHeight = 160;
    
    double horizontalPadding = screenWidth * 0.045;
    if (horizontalPadding < 16) horizontalPadding = 16;
    if (horizontalPadding > 24) horizontalPadding = 24;

    return Stack(
      children: [
        // Blue gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1976D2), Color(0xFF64B5F6)],
            ),
          ),
        ),

        Column(
          children: [
            // Top header with user info
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

            // White content area
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome text
                        const Text(
                          'Welcome Farmer!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Get your details day by day by easemilker app',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Colors.grey[500],
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.025),

                        // Two cards row
                        Row(
                          children: [
                            // Today Milk Liter card
                            Expanded(
                              child: Container(
                                height: screenHeight * 0.18,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.08),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Today Milk Liter',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Milk tank image
                                    Image.asset(
                                      'assets/images/image 198.png',
                                      height: screenHeight * 0.07,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.local_drink,
                                          size: screenHeight * 0.07,
                                          color: Colors.grey[300],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '0 litres',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            SizedBox(width: screenWidth * 0.04),

                            // Easemilker card
                            Expanded(
                              child: Container(
                                height: screenHeight * 0.18,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.08),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Milk jug icon
                                        Image.asset(
                                          'assets/images/temaki_milk-jug.png',
                                          height: 24,
                                          width: 24,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.opacity,
                                              size: 24,
                                              color: Colors.black,
                                            );
                                          },
                                        ),
                                        // WiFi icon - shows connected or disconnected
                                        Icon(
                                          _isConnected ? Icons.wifi : Icons.wifi_off,
                                          size: 20,
                                          color: _isConnected ? Colors.black : Colors.grey[400],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Easemilker',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _isConnected ? '$_machineId- Connected' : 'em0214ki- Disconnected',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 9,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _isEaseMilkerOn ? 'ON' : 'OFF',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            // If turning OFF, show confirmation
                                            if (_isEaseMilkerOn) {
                                              final result = await showDialog<bool>(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  title: const Text(
                                                    'Turn Off Easemilker',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    'Do you want to turn off the Easemilker?',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context, false),
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.grey[600],
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () => Navigator.pop(context, true),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: const Color(0xFF2196F3),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Turn Off',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                              
                                              if (result == true) {
                                                setState(() {
                                                  _isEaseMilkerOn = false;
                                                  _isConnected = false; // Disconnect when turned off
                                                });
                                                // Save disconnection
                                                final prefs = await SharedPreferences.getInstance();
                                                await prefs.setBool('isConnected', false);
                                                await prefs.setString('machineId', '');
                                              }
                                            } else {
                                              // If turning ON, just toggle and connect
                                              setState(() {
                                                _isEaseMilkerOn = true;
                                                _isConnected = true; // Connect when turned on
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: 48,
                                            height: 26,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: _isEaseMilkerOn 
                                                ? const Color(0xFF4CAF50) 
                                                : Colors.grey[300],
                                            ),
                                            padding: const EdgeInsets.all(2),
                                            child: AnimatedAlign(
                                              duration: const Duration(milliseconds: 200),
                                              alignment: _isEaseMilkerOn 
                                                ? Alignment.centerRight 
                                                : Alignment.centerLeft,
                                              child: Container(
                                                width: 22,
                                                height: 22,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.025),

                        // Milking section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _isMachineWorking ? 'Milking On' : 'Milking off',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            // Refresh button
                            GestureDetector(
                              onTap: () {
                                // Refresh action
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2196F3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Milking off card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '0.0 litre ...',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Machine have been in rest state',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Cow milking image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/Frame 721.png',
                                  width: double.infinity,
                                  height: screenHeight * 0.20,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: double.infinity,
                                      height: screenHeight * 0.20,
                                      color: const Color(0xFF4CAF50),
                                      child: const Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Machine working',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'easemilker',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          // If machine is not working, show confirmation to turn on
                                          if (!_isMachineWorking) {
                                            final result = await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                title: const Text(
                                                  'Turn On Machine',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                content: const Text(
                                                  'Do you want to turn on the machine?',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () => Navigator.pop(context, true),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: const Color(0xFF4CAF50),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Turn On',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                            
                                            if (result == true) {
                                              setState(() {
                                                _isMachineWorking = true;
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _isMachineWorking
                                                ? const Color(0xFF4CAF50)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: _isMachineWorking
                                                  ? const Color(0xFF4CAF50)
                                                  : Colors.grey[300]!,
                                            ),
                                          ),
                                          child: Text(
                                            'on',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: _isMachineWorking
                                                  ? Colors.white
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: () async {
                                          // If machine is currently working, show confirmation
                                          if (_isMachineWorking) {
                                            final result = await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                title: const Text(
                                                  'Turn Off Machine',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                content: const Text(
                                                  'Do you want to turn off the machine?',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () => Navigator.pop(context, true),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.redAccent,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Turn Off',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                            
                                            if (result == true) {
                                              setState(() {
                                                _isMachineWorking = false;
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: !_isMachineWorking
                                                ? Colors.grey[300]
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: !_isMachineWorking
                                                  ? Colors.grey[400]!
                                                  : Colors.grey[300]!,
                                            ),
                                          ),
                                          child: Text(
                                            'off',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: !_isMachineWorking
                                                  ? Colors.grey[700]
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Bottom padding for navbar
                        SizedBox(height: 100 + MediaQuery.of(context).padding.bottom),
                      ],
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
