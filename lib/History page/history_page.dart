import 'package:flutter/material.dart';
import '../widgets/top_header.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _refreshController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  void _refreshData() {
    _refreshController?.repeat();
    setState(() {
      // Refresh logic here - this will rebuild the widget
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _refreshController?.stop();
        _refreshController?.reset();
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data refreshed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _refreshController ??= AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.2, -0.98),
            end: Alignment(-0.2, 0.98),
            colors: [Color(0xFF006CC7), Color(0xFF68B6FF)],
            stops: [0.0246, 0.3688],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Use default TopHeader widget with increased top and bottom padding
              const TopHeader(
                name: 'Dhanush Kumar S',
                idText: 'EM0214KI',
                avatarAsset: 'assets/images/Frame 298.png',
                padding: EdgeInsets.fromLTRB(16, 71, 16, 41),
              ),

              // Main Content Area
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F8FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HISTORY Title
                          const Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 18),
                            child: Text(
                              'HISTORY',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Search Bar
                          Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 16,
                                  color: Color(0xFF8C8C8C),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Search By Machine Id',
                                  style: TextStyle(
                                    color: Color(0xFF8C8C8C),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Summary Card - Using home_page.dart structure
                          _buildTotalMilkingCard(
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height,
                          ),

                          const SizedBox(height: 24),

                          // Easemilker 1 Section
                          const Text(
                            'Easemilker 1',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Easemilker 1 Table - Horizontal Scroll
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: index == 0 ? 12 : 0,
                                  ),
                                  child: _buildMachineTable('Dec-2024'),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Easemilker 2 Section
                          const Text(
                            'Easemilker 2',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Easemilker 2 Table - Horizontal Scroll - NO OVERFLOW
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: index == 0 ? 12 : 0,
                                  ),
                                  child: _buildMachineTable('Dec-2024'),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMachineTable(String month) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Make table width responsive - use parent constraints or default
        double tableWidth = constraints.maxWidth > 0
            ? constraints.maxWidth.clamp(240.0, 280.0)
            : 250.0;
        double fontSize = (tableWidth * 0.048).clamp(10.0, 14.0);
        double smallFontSize = (tableWidth * 0.042).clamp(9.0, 12.0);

        return Container(
          width: tableWidth,
          constraints: const BoxConstraints(maxHeight: 230),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Month Header with Download Icon
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: tableWidth * 0.048,
                  vertical: tableWidth * 0.032,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      month,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fontSize,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.file_download_outlined,
                      size: tableWidth * 0.064,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),

              // Table Header
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: tableWidth * 0.048,
                  vertical: tableWidth * 0.032,
                ),
                decoration: const BoxDecoration(color: Color(0xFFD8D8F5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize * 0.93,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Milk liter',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize * 0.93,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Table Rows - Wrapped in Expanded for proper constraint handling
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTableRow(
                        date: '10/10/2024',
                        liters: '13.5 litres',
                        fontSize: smallFontSize,
                        tableWidth: tableWidth,
                      ),
                      _buildTableRow(
                        date: '11/10/2024',
                        liters: '14.2 litres',
                        fontSize: smallFontSize,
                        tableWidth: tableWidth,
                      ),
                      _buildTableRow(
                        date: '12/10/2024',
                        liters: '15.8 litres',
                        fontSize: smallFontSize,
                        tableWidth: tableWidth,
                      ),
                      _buildTableRow(
                        date: '13/10/2024',
                        liters: '16.5 litres',
                        isLast: true,
                        fontSize: smallFontSize,
                        tableWidth: tableWidth,
                      ),
                    ],
                  ),
                ),
              ),

              // Total Row
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: tableWidth * 0.048,
                  vertical: tableWidth * 0.032,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: smallFontSize,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        '150 litres',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: smallFontSize,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTableRow({
    String date = '10/10/2024',
    String liters = '13.5 litres',
    bool isLast = false,
    double fontSize = 12.0,
    double tableWidth = 250.0,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: tableWidth * 0.056,
        vertical: tableWidth * 0.048,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(width: 0.5, color: Color(0xFFE0E0E0)),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              date,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              liters,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalMilkingCard(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.025),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.025),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.87,
              color: Colors.black.withValues(alpha: 0.28),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Milk tank image
                Container(
                  width: screenWidth * 0.20,
                  height: screenWidth * 0.26,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/image 198.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.03),

                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          'Total Milking :384 litres',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'December Month',
                        style: TextStyle(
                          color: const Color(0xFF8C8C8C),
                          fontSize: screenWidth * 0.026,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Machine order :',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.026,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Machine Pills
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            _buildMachinePill(
                              'easemilker :1',
                              '78 litres milk',
                              const Color(0xFF8DC201),
                              screenWidth,
                              screenHeight,
                            ),
                            const SizedBox(width: 3),
                            _buildMachinePill(
                              'easemilker :2',
                              '78 litres milk',
                              const Color(0xFFC2E760),
                              screenWidth,
                              screenHeight,
                            ),
                            const SizedBox(width: 3),
                            _buildMachinePill(
                              'easemilker :3',
                              '78 litres milk',
                              const Color(0xFFDEE5E7),
                              screenWidth,
                              screenHeight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Refresh Icon - Positioned at top right corner
            Positioned(
              top: -5,
              right: -5,
              child: GestureDetector(
                onTap: _refreshData,
                child: Container(
                  width: screenWidth * 0.11, // increased hit area
                  height: screenWidth * 0.11, // increased hit area
                  color: Colors.transparent,
                  child: Center(
                    child: _refreshController != null
                        ? RotationTransition(
                            turns: _refreshController!,
                            child: Icon(
                              Icons.autorenew_rounded,
                              color: const Color(0xFF00A3FF),
                              size: screenWidth * 0.065, // larger icon
                            ),
                          )
                        : Icon(
                            Icons.autorenew_rounded,
                            color: const Color(0xFF00A3FF),
                            size: screenWidth * 0.065, // larger icon
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMachinePill(
    String label,
    String value,
    Color bgColor,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: bgColor.computeLuminance() > 0.5
                  ? const Color(0xFF656565)
                  : Colors.white,
              fontSize: screenWidth * 0.016,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w300,
              height: 1.2,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.022,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
