import 'package:flutter/material.dart';
import '../NavBar/navbar.dart';
import '../History page/history_page.dart';
import '../Shop page/shop_page.dart';
import '../widgets/top_header.dart';
import '../Settings page/settings_page.dart';
import '../Premium page/premium_page.dart';
import '../Settings page/alert_sound_service.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;
  bool _alertSoundEnabled = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _loadAlertSoundState();
  }

  Future<void> _loadAlertSoundState() async {
    final service = AlertSoundService.instance;
    final enabled = await service.getAlertSoundEnabled();
    setState(() {
      _alertSoundEnabled = enabled;
    });
  }

  Future<void> _setAlertSoundState(bool enabled) async {
    final service = AlertSoundService.instance;
    await service.setAlertSoundEnabled(enabled);
    setState(() {
      _alertSoundEnabled = enabled;
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
    // Moved original HomePage body here so it can be shown as tab 0.
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        double headerHeight = size.height * 0.22;
        if (headerHeight < 110) headerHeight = 110;
        if (headerHeight > 180) headerHeight = 180;

        return Stack(
          children: [
            // Background Gradient (match HistoryPage exactly)
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

            // Column with header and content so positions scale with screen
            Column(
              children: [
                // Header area (shared TopHeader) - keep inside SafeArea to match HistoryPage
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),

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

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                              Stack(
                                clipBehavior: Clip.none,
                                children: [
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
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

                                        // image area (no refresh here) - fills the card width
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 160,
                                            child: Image.asset(
                                              'assets/images/Frame 721.png',
                                              width: double.infinity,
                                              height: 160,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Container(
                                                      width: double.infinity,
                                                      height: 160,
                                                      color: const Color(
                                                        0xFF4CAF50,
                                                      ),
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
                                        ),

                                        const SizedBox(height: 12),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                  onPressed: () {
                                                    _setAlertSoundState(true);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        _alertSoundEnabled
                                                        ? const Color(
                                                            0xFF2874F0,
                                                          )
                                                        : Colors.white,
                                                    foregroundColor:
                                                        _alertSoundEnabled
                                                        ? Colors.white
                                                        : const Color(
                                                            0xFFA6A6A6,
                                                          ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 24,
                                                          vertical: 8,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    side: _alertSoundEnabled
                                                        ? null
                                                        : const BorderSide(
                                                            color: Color(
                                                              0xFFE0E0E0,
                                                            ),
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
                                                  onPressed: () {
                                                    _setAlertSoundState(false);
                                                  },
                                                  style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        !_alertSoundEnabled
                                                        ? const Color(
                                                            0xFF2874F0,
                                                          )
                                                        : Colors.white,
                                                    foregroundColor:
                                                        !_alertSoundEnabled
                                                        ? Colors.white
                                                        : const Color(
                                                            0xFFA6A6A6,
                                                          ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 8,
                                                        ),
                                                    side: !_alertSoundEnabled
                                                        ? null
                                                        : const BorderSide(
                                                            color: Color(
                                                              0xFFE0E0E0,
                                                            ),
                                                          ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
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

                                  // refresh icon placed on the top-right corner of the white card
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: GestureDetector(
                                      onTap: () {
                                        // refresh action here
                                      },
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2874F0),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                0,
                                                0,
                                                0,
                                                0.15,
                                              ),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.sync,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height:
                                    80 + MediaQuery.of(context).padding.bottom,
                              ),
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
}
