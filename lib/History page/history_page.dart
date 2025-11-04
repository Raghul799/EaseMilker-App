import 'package:flutter/material.dart';
import '../widgets/top_header.dart';

// HistoryPage: This page intentionally omits any embedded bottom navigation bar.
// The app's root or the navigation host (e.g., `HomePage`) should provide the shared
// `AppNavBar` (as used in `lib/Home page/home_page.dart`).

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Header height matches HomePage logic so the visual language is consistent
    double headerHeight = size.height * 0.22;
    if (headerHeight < 110) headerHeight = 110;
    if (headerHeight > 180) headerHeight = 180;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // Use the exact alignment/stops and colors used in the design file
          gradient: LinearGradient(
            begin: Alignment(0.2, -0.98), // angle matching the design
            end: Alignment(-0.2, 0.98),
            colors: [
              Color(0xFF006CC7), // rgba(0,108,199,1)
              Color(0xFF68B6FF), // rgba(104,182,255,1)
            ],
            stops: [0.0246, 0.3688],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top App Bar area sized to match HomePage header height
              SizedBox(
                height: headerHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: _buildTopAppBar(),
                ),
              ),
              const SizedBox(height: 8),

              // White sheet content area with rounded top corners
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'HISTORY',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Scrollable cards
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: const [
                              _HistoryCard(),
                              SizedBox(height: 16),
                              _HistoryCard(),
                              SizedBox(height: 90), // breathing room above nav
                            ],
                          ),
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
      // Bottom navigation is provided by the root scaffold
      // to allow sharing between pages.
      // bottomNavigationBar intentionally omitted.
    );
  }

  Widget _buildTopAppBar() {
    return const TopHeader(
      name: 'Dhanush Kumar S',
      idText: 'EM0214KI',
      avatarAsset: 'assets/images/Frame 298.png',
    );
  }

}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: const Offset(0, 3),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dec-2024',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Icon(
                  Icons.download_outlined,
                  color: Colors.black87,
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Table
            _buildDataTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E0E0), // Light gray border
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE8E6FA), // #E8E6FA light lavender
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Milk liter',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Table Rows
          _buildTableRow('10/10/2024', '13.5 litres', showBorder: true),
          _buildTableRow('10/10/2024', '13.5 litres', showBorder: true),
          _buildTableRow('10/10/2024', '13.5 litres', showBorder: true),
          _buildTableRow('10/10/2024', '13.5 litres', showBorder: false),

          // Total Row
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE6E6E6), // #E6E6E6 light gray
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '150 litres',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String date, String milk, {required bool showBorder}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: showBorder
            ? const Border(
                bottom: BorderSide(
                  color: Color(0xFFE0E0E0), // Light gray separator
                  width: 1,
                ),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            milk,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
