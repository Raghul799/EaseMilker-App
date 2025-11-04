import 'package:flutter/material.dart';
import '../NavBar/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use LayoutBuilder + MediaQuery for responsive sizing
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = MediaQuery.of(context).size;
          // Header height adapts to screen height but stays within sensible bounds
          // Reduce header vertical footprint further: smaller multiplier and tighter min/max
          double headerHeight = size.height * 0.22;
          if (headerHeight < 110) headerHeight = 110;
          if (headerHeight > 180) headerHeight = 180;

          return Stack(
            children: [
              // Background Gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF006CC7),
                      Color(0xFF68B6FF),
                    ],
                  ),
                ),
              ),

              // Column with header and content so positions scale with screen
              Column(
                children: [
                  // Header area
                  SafeArea(
                    bottom: false,
                    child: SizedBox(
                      height: headerHeight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Transform.translate(
                          // lift the header content slightly; smaller lift increases top gap
                          offset: const Offset(0, -4),
                          child: Row(
                            // center vertically so profile block and bell icon sit on same line
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left: logo + name/ID
                              Row(
                                children: [
                                  // Profile / Logo (uses provided asset 'Frame 298.png')
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(12),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/Frame 298.png',
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Center(
                                              child: Icon(
                                                Icons.image,
                                                color: Color(0xFF2874F0),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 8),
                                  // Name and ID
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Dhanush Kumar S',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                        fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(20),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          'EM0214KI',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 11,
                                            color: Colors.white,
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.white,
                                            decorationThickness: 1.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Right: bell icon (no outline)
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Content area (white rounded) fills remaining space
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),

                              // Welcome Section
                              const Text(
                                'Welcome Farmer!',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Get your details day by day by easemilker app',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Color(0xFFA6A6A6),
                                ),
                              ),

                              const SizedBox(height: 22),

                              // Milk Liters Section
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Milk Liters',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2874F0),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2874F0),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.wifi,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Connected',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Milk Liters Box - uses full width
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(20),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Today Milk Liter',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 12,
                                        color: Color(0xFFA6A6A6),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '14 litres',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE3F2FD),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: const Color(0xFF2874F0),
                                          width: 1,
                                        ),
                                      ),
                                      child: const Text(
                                        'This month milk you have get 320 litres',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 11,
                                          color: Color(0xFF2874F0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Milking off Section
                              const Text(
                                'Milking off',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2874F0),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Milking off Box
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(20),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '0.0 litre ...',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE0E0E0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            size: 14,
                                            color: Color(0xFF666666),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Machine have been in rest state',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 10,
                                              color: Color(0xFF666666),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Farmer Image - responsive height
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/F980721.jpg',
                                        width: double.infinity,
                                        height: size.height * 0.18 > 200 ? 200 : size.height * 0.18,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: double.infinity,
                                            height: size.height * 0.18 > 200 ? 200 : size.height * 0.18,
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

                                    const SizedBox(height: 12),

                                    // Machine working status
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Machine working',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            const Text(
                                              'easemilker',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 10,
                                                color: Color(0xFFA6A6A6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF2874F0),
                                                foregroundColor: Colors.white,
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 8,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                elevation: 0,
                                              ),
                                              child: const Text(
                                                'on',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            OutlinedButton(
                                              onPressed: () {},
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: const Color(0xFFA6A6A6),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 8,
                                                ),
                                                side: const BorderSide(
                                                  color: Color(0xFFE0E0E0),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: const Text(
                                                'off',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
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

                              // Space for bottom nav
                              SizedBox(height: 80 + MediaQuery.of(context).padding.bottom),
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
        },
      ),

  // Bottom Navigation Bar (moved to its own widget in lib/NavBar/navbar.dart)
  bottomNavigationBar: AppNavBar(),
    );
  }
}
