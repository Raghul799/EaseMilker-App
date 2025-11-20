import 'package:flutter/material.dart';
import 'user_top_header.dart';

class UserShopPage extends StatelessWidget {
  const UserShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.22;
    if (headerHeight < 110) headerHeight = 110;
    if (headerHeight > 180) headerHeight = 180;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

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
                child: const Align(
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
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    // Scrollable content
                    SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 110 + bottomPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gray background container for top section
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Product Details Header with cart icon
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.075,
                          size.height * 0.03,
                          size.width * 0.075,
                          0,
                        ),
                        child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Details',
                        style: TextStyle(
                          color: const Color(0xFF032A4A),
                          fontSize: size.width * 0.05,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: size.width * 0.085,
                        height: size.width * 0.085,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.5,
                            color: const Color(0xFF0274D4),
                          ),
                        ),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: size.width * 0.055,
                          color: const Color(0xFF0274D4),
                        ),
                      ),
                    ],
                  ),
                ),

                      SizedBox(height: size.height * 0.005),

                      // Product image (without white circle background)
                      Center(
                        child: Image.asset(
                          'assets/images/machine.png',
                          width: size.width * 0.725,
                          height: size.height * 0.27,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: size.width * 0.725,
                              height: size.height * 0.27,
                              color: Colors.grey[300],
                              child: Center(
                                  child: Icon(Icons.image,
                                      size: size.width * 0.125)),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: size.height * 0.01),
                    ],
                  ),
                ),

                // White section starts
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name, price and phone
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.075,
                          size.height * 0.015,
                          size.width * 0.075,
                          0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ease Milker',
                                  style: TextStyle(
                                    color: const Color(0xFF032A4A),
                                    fontSize: size.width * 0.05,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.004),
                                Text(
                                  '\$175.00',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 0.038,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: size.width * 0.083,
                              height: size.width * 0.083,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              child: Icon(
                                Icons.phone,
                                size: size.width * 0.055,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.012),

                      // Divider
                      Container(height: 1, color: const Color.fromARGB(255, 164, 164, 164)),

                      // Description section
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.075,
                          size.height * 0.016,
                          size.width * 0.075,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.043,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: size.height * 0.012),
                            Text(
                              'EaseMilker is an automated, portable milking system designed to make dairy farming easier, faster, and more hygienic. It ensures gentle milking, high milk yield, and animal comfort while reducing manual effort and contamination risks.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: size.width * 0.028,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.018),

                      // Product Highlights section
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.075,
                          0,
                          size.width * 0.075,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Highlights:',
                              style: TextStyle(
                                color: const Color(0xFF032A4A),
                                fontSize: size.width * 0.043,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: size.height * 0.018),
                            _ProductHighlight(
                              emoji: '💧',
                              title: 'Hygienic & Safe:',
                              description:
                                  'Made with food-grade materials ensuring clean, free milk',
                              screenWidth: size.width,
                            ),
                            SizedBox(height: size.height * 0.012),
                            _ProductHighlight(
                              emoji: '⚙️',
                              title: 'Efficient & Time-Saving:',
                              description:
                                  'Milks cows in just a few minutes with consistent suction flow.',
                              screenWidth: size.width,
                            ),
                            SizedBox(height: size.height * 0.012),
                            _ProductHighlight(
                              emoji: '🔋',
                              title: 'Energy-Efficient Design:',
                              description:
                                  'Low power consumption with long-lasting performance.',
                              screenWidth: size.width,
                            ),
                            SizedBox(height: size.height * 0.012),
                            _ProductHighlight(
                              emoji: '🚀',
                              title: 'Portable & Easy to Use:',
                              description:
                                  'Compact and lightweight — ideal for small and large dairy farms.',
                              screenWidth: size.width,
                            ),
                            SizedBox(height: size.height * 0.012),
                            _ProductHighlight(
                              emoji: '📲',
                              title: 'Smart Monitoring (optional):',
                              description:
                                  'Real-time tracking of milking volume and machine performance',
                              screenWidth: size.width,
                            ),
                            SizedBox(height: size.height * 0.012),
                            _ProductHighlight(
                              emoji: '🐮',
                              title: 'Animal-Friendly Operation:',
                              description:
                                  'Gentle suction mimics natural milking, preventing udder stress.',
                              screenWidth: size.width,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.024),

                      // Delivery info box
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.075),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(size.width * 0.025),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCAE5FD),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xFF0A4BD5),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/box.png',
                                width: size.width * 0.05,
                                height: size.width * 0.05,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.local_shipping,
                                    size: size.width * 0.05,
                                    color: Colors.black,
                                  );
                                },
                              ),
                              SizedBox(width: size.width * 0.02),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Azhizen offers',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.02,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 1.4,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' free delivery',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.02,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                          height: 1.4,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' across India, ensuring your orders reach you safely and on time. Get your products delivered within ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.02,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 1.4,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '3–10 business days',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.02,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                          height: 1.4,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ', with no extra shipping cost.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.02,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.005),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Fixed buttons only (navbar is managed by UserHomePage)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  size.width * 0.07,
                  size.height * 0.015,
                  size.width * 0.07,
                  size.height * 0.015,
                ),
                child: Row(
                  children: [
                    // Add to Cart button
                    Expanded(
                      child: Container(
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1.5,
                            color: const Color(0xFF0685F0),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Add to cart functionality
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Center(
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: const Color(0xFF0685F0),
                                  fontSize: size.width * 0.038,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.025),
                    // Call to book button
                    Expanded(
                      child: Container(
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0685F0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Call to book functionality
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Center(
                              child: Text(
                                'Call to book',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.038,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Product Highlight Widget
class _ProductHighlight extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final double screenWidth;

  const _ProductHighlight({
    required this.emoji,
    required this.title,
    required this.description,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: TextStyle(fontSize: screenWidth * 0.04)),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.033,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: screenWidth * 0.005),
              Text(
                description,
                style: TextStyle(
                  color: const Color(0xFF6B6B6B),
                  fontSize: screenWidth * 0.028,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
