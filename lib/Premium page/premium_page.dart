import 'package:flutter/material.dart';
import '../widgets/top_header.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        double headerHeight = size.height * 0.22;
        if (headerHeight < 110) headerHeight = 110;
        if (headerHeight > 180) headerHeight = 180;

        return Stack(
          children: [
            // Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.2, -0.98),
                  end: Alignment(-0.2, 0.98),
                  colors: [
                    Color(0xFF006CC7),
                    Color(0xFF68B6FF),
                  ],
                  stops: [0.0246, 0.3688],
                ),
              ),
            ),

            // Column with header and content
            Column(
              children: [
                // Header area with TopHeader
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

                // Content area (white rounded) fills remaining space
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),

                              // Premium Variant Cards
                              _buildVariantCard(
                                context,
                                variantName: 'High Varient',
                                description: 'This is page is access by high varient milking machine',
                                isAccessible: true,
                              ),

                              const SizedBox(height: 16),

                              _buildVariantCard(
                                context,
                                variantName: 'Low Varient',
                                description: 'This is page is access by low varient milking machine',
                                isAccessible: false,
                              ),

                              const SizedBox(height: 16),

                              _buildVariantCard(
                                context,
                                variantName: 'Medium Varient',
                                description: 'This is page is access by medium varient milking machine',
                                isAccessible: false,
                              ),

                              SizedBox(height: 80 + MediaQuery.of(context).padding.bottom),
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
      },
    );
  }

  Widget _buildVariantCard(
    BuildContext context, {
    required String variantName,
    required String description,
    required bool isAccessible,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with variant name and close icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                variantName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Ease Milker Logo
          Center(
            child: Image.asset(
              'assets/images/Group 24.png',
              width: 200,
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 200,
                  height: 100,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Description with icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isAccessible 
                  ? const Color(0xFFFFF4E6) 
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: isAccessible 
                      ? const Color(0xFFFF9800) 
                      : const Color(0xFF666666),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: isAccessible 
                          ? const Color(0xFFE65100) 
                          : const Color(0xFF666666),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
