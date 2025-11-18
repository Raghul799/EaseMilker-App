import 'package:flutter/material.dart';
import '../NavBar/navbar.dart';
import '../History page/history_page.dart';
import '../Shop page/shop_page.dart';
import '../Settings page/settings_page.dart';
import '../Premium page/premium_page.dart';
import '../widgets/top_header.dart';
import 'control_easemilker_dialog.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late int _selectedIndex;
  final TextEditingController _searchController = TextEditingController();
  AnimationController? _refreshController;

  @override
  bool get wantKeepAlive => true;
  
  // Machine states
  final Map<String, bool> _machineStates = {
    'Easemilker 1': true,
    'Easemilker 2 (1)': false,
    'Easemilker 2 (2)': false,
  };

  // Alert sound and disconnect states for each machine
  final Map<String, bool> _alertSoundStates = {
    'Easemilker 1': true,
    'Easemilker 2 (1)': true,
    'Easemilker 2 (2)': true,
  };

  final Map<String, bool> _disconnectStates = {
    'Easemilker 1': false,
    'Easemilker 2 (1)': false,
    'Easemilker 2 (2)': false,
  };

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController?.dispose();
    super.dispose();
  }

  void _refreshData() {
    _refreshController?.repeat();
    setState(() {
      // Refresh logic here
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

  void _toggleMachine(String machineName) {
    setState(() {
      _machineStates[machineName] = !(_machineStates[machineName] ?? false);
    });
  }

  void _showControlDialog(String machineName) {
    showControlEasemilkerDialog(
      context,
      currentAlertSound: _alertSoundStates[machineName] ?? true,
      currentDisconnect: _disconnectStates[machineName] ?? false,
      onAlertSoundChanged: (value) {
        setState(() {
          _alertSoundStates[machineName] = value;
        });
      },
      onDisconnectChanged: (value) {
        setState(() {
          _disconnectStates[machineName] = value;
        });
      },
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
    double headerHeight = size.height * 0.15;
    if (headerHeight < 80) headerHeight = 80;
    if (headerHeight > 140) headerHeight = 140;

    return Stack(
      children: [
        // Blue gradient background
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

        Column(
          children: [
            // Custom header with user info
            SafeArea(
              bottom: false,
              child: TopHeader(
                name: 'Dhanush Kumar S',
                idText: 'EM0214KI',
                avatarAsset: 'assets/images/Frame 298.png',
              ),
            ),

            // White content area with card overlap
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // White background container
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: screenHeight * 0.15),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.50, -0.00),
                        end: Alignment(0.50, 1.10),
                        colors: [Colors.white, Color(0xFFB7DCFF)],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Space for the overlapping card
                        SizedBox(height: screenHeight * 0.13),
                        
                        // Scrollable content
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.055,
                                vertical: 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Your Machine Section
                                  const Text(
                                'Your Machine',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.015),

                              // Search Bar
                              Container(
                                width: double.infinity,
                                height: 45,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText: 'Search By Machine Id',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF8C8C8C),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 20,
                                      color: Color(0xFF8C8C8C),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),

                                  SizedBox(height: screenHeight * 0.02),

                                  // Machine Cards
                                      _buildMachineCard(
                                    screenWidth,
                                    screenHeight,
                                    'Easemilker 1',
                                    'em0214ki- Connected',
                                    'Milk : 15 litres',
                                    _machineStates['Easemilker 1'] ?? true,
                                    'Easemilker 1',
                                  ),

                                  SizedBox(height: screenHeight * 0.014),

                                  _buildMachineCard(
                                    screenWidth,
                                    screenHeight,
                                    'Easemilker 2',
                                    'em0214ki- Disconnected',
                                    'Milk : 0 litre',
                                    _machineStates['Easemilker 2 (1)'] ?? false,
                                    'Easemilker 2 (1)',
                                  ),

                                  SizedBox(height: screenHeight * 0.014),

                                  _buildMachineCard(
                                    screenWidth,
                                    screenHeight,
                                    'Easemilker 3',
                                    'em0214ki- Connected',
                                    'Milk : 15 litres',
                                    _machineStates['Easemilker 2 (2)'] ?? false,
                                    'Easemilker 2 (2)',
                                  ),

                                  // Bottom padding for navbar
                                  SizedBox(height: 100 + MediaQuery.of(context).padding.bottom),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Overlapping Total Milking Card
                  Positioned(
                    top: screenHeight * 0.05,
                    left: screenWidth * 0.055,
                    right: screenWidth * 0.055,
                    child: _buildTotalMilkingCard(screenWidth, screenHeight),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalMilkingCard(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.024,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.015,
              vertical: screenHeight * 0.015,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(0, 0, 0, 0.30),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Milk tank image
                Container(
                  width: screenWidth * 0.26,
                  height: screenHeight * 0.13,
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/image 198.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.025),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total Milking ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.038,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ': 84 litres',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.040,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.001),
                      Text(
                        '19/10/2025',
                        style: TextStyle(
                          color: const Color(0xFF8C8C8C),
                          fontSize: screenWidth * 0.030,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Machine Status :',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.030,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.08,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.006),
                      Wrap(
                        spacing: screenWidth * 0.012,
                        runSpacing: screenHeight * 0.005,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.022,
                              vertical: screenHeight * 0.008,
                            ),
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xFFD4E57E), Color(0xFF8DC201)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Milking: 2',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.026,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.022,
                              vertical: screenHeight * 0.008,
                            ),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE8E6E6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'ready : 1',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.026,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.022,
                              vertical: screenHeight * 0.008,
                            ),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFD9D9D9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'rest : 1',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.026,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
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
          // Reload button (increased size)
          Positioned(
            top: screenHeight * 0.001,
            right: screenWidth * 0.001,
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
    );
  }

  Widget _buildMachineCard(
    double screenWidth,
    double screenHeight,
    String title,
    String subtitle,
    String milkText,
    bool isOn,
    String machineName,
  ) {
    
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: isOn
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFF4FFE1), Color(0xFFCAE57E), Color(0xFF9BC53D)],
                stops: [0.0, 0.6, 1.0],
              )
            : const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white, Colors.white],
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.018,
        ),
        child: Row(
          children: [
            // Milk tank icon
            Container(
              width: screenWidth * 0.16,
              height: screenWidth * 0.16,
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image 198.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            SizedBox(width: screenWidth * 0.03),

            // Machine details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.042,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        isOn ? Icons.wifi : Icons.wifi_off,
                        size: 16,
                        color: isOn 
                            ? Colors.grey[400] 
                            : Colors.grey[400],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.004),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: const Color(0xFF615F5F),
                      fontSize: screenWidth * 0.022,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    milkText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.038,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Status and menu
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _showControlDialog(machineName),
                  child: Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                Row(
                  children: [
                    Text(
                      isOn ? 'ON' : 'OFF',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.038,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _toggleMachine(machineName),
                      child: Container(
                        width: 48,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isOn ? const Color(0xFF8DC201) : const Color(0xFFD9D9D9),
                        ),
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            width: 22,
                            height: 22,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
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
          ],
        ),
      ),
    );
  }
}
