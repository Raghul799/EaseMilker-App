import 'package:flutter/material.dart';
import 'user_top_header.dart';
import 'user_navbar.dart';
import 'user_home_page.dart';

/// CartPage - displays the user's shopping cart
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    
    // Responsive header height
    double headerHeight = screenHeight * 0.22;
    if (headerHeight < 110) headerHeight = 110;
    if (headerHeight > 180) headerHeight = 180;

    // Responsive padding
    double horizontalPadding = screenWidth * 0.06;
    if (horizontalPadding < 16) horizontalPadding = 16;
    if (horizontalPadding > 24) horizontalPadding = 24;

    // Responsive vertical spacing
    double verticalPadding = screenHeight * 0.03;
    if (verticalPadding < 20) verticalPadding = 20;
    if (verticalPadding > 24) verticalPadding = 24;

    // Responsive border radius
    double borderRadius = screenWidth * 0.075;
    if (borderRadius < 24) borderRadius = 24;
    if (borderRadius > 30) borderRadius = 30;

    // Responsive card padding
    double cardPadding = screenWidth * 0.04;
    if (cardPadding < 12) cardPadding = 12;
    if (cardPadding > 16) cardPadding = 16;

    // Responsive image size
    double imageSize = screenWidth * 0.28;
    if (imageSize < 100) imageSize = 100;
    if (imageSize > 120) imageSize = 120;

    // Responsive font sizes
    double titleFontSize = screenWidth * 0.05;
    if (titleFontSize < 18) titleFontSize = 18;
    if (titleFontSize > 20) titleFontSize = 20;

    double productNameFontSize = screenWidth * 0.042;
    if (productNameFontSize < 15) productNameFontSize = 15;
    if (productNameFontSize > 17) productNameFontSize = 17;

    double priceFontSize = screenWidth * 0.045;
    if (priceFontSize < 16) priceFontSize = 16;
    if (priceFontSize > 18) priceFontSize = 18;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadius),
                        topRight: Radius.circular(borderRadius),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: 90 + MediaQuery.of(context).padding.bottom,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // My Cart title
                            Text(
                              'My Cart',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF212121),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            // Product Card
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(20),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(cardPadding),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product image
                                    Container(
                                      width: imageSize,
                                      height: imageSize,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          'assets/images/machine.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Center(
                                              child: Icon(
                                                Icons.image_not_supported,
                                                size: imageSize * 0.33,
                                                color: const Color(0xFF9E9E9E),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: screenWidth * 0.04),

                                    // Product details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Product name
                                          Text(
                                            'EaseMilker',
                                            style: TextStyle(
                                              fontSize: productNameFontSize,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF212121),
                                            ),
                                          ),

                                          SizedBox(height: screenHeight * 0.005),

                                          // Product subtitle
                                          Text(
                                            'milking machine',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.03,
                                              color: const Color(0xFF757575),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),

                                          SizedBox(height: screenHeight * 0.01),

                                          // Star rating
                                          Row(
                                            children: [
                                              ...List.generate(4, (index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: screenWidth * 0.038,
                                                  color: const Color(0xFFFFC107),
                                                );
                                              }),
                                              Icon(
                                                Icons.star_border,
                                                size: screenWidth * 0.038,
                                                color: const Color(0xFFFFC107),
                                              ),
                                              SizedBox(width: screenWidth * 0.02),
                                              Text(
                                                '4.5',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.03,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xFF212121),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: screenHeight * 0.015),

                                          // Price and Buy button
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Price
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '₹30000',
                                                      style: TextStyle(
                                                        fontSize: priceFontSize,
                                                        fontWeight: FontWeight.w700,
                                                        color: const Color(0xFF212121),
                                                      ),
                                                    ),
                                                    Text(
                                                      '₹75000',
                                                      style: TextStyle(
                                                        fontSize: screenWidth * 0.032,
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xFF9E9E9E),
                                                        decoration: TextDecoration.lineThrough,
                                                        decorationColor: const Color(0xFF9E9E9E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Buy button
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Handle buy action
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFF1976D2),
                                                  foregroundColor: Colors.white,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: screenWidth * 0.07,
                                                    vertical: screenHeight * 0.01,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  elevation: 0,
                                                ),
                                                child: Text(
                                                  'Buy',
                                                  style: TextStyle(
                                                    fontSize: screenWidth * 0.04,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),
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
      bottomNavigationBar: AppNavBar(
        selectedIndex: -1,
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserHomePage(initialIndex: index),
            ),
          );
        },
      ),
    );
  }
}
