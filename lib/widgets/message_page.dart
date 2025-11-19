import 'package:flutter/material.dart';
import '../NavBar/navbar.dart';
import 'top_header.dart';
import '../Home page/home_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final int _selectedIndex =
      -1; // No tab selected initially since this is accessed via bell icon

  // Sample message data based on the image
  final List<Map<String, dynamic>> _messages = [
    {
      'title': 'Tank filled',
      'subtitle': 'tank have been filled 10...',
      'time': 'Today, 12:30 AM',
      'hasActions': true,
      'isRead': false,
    },
    {
      'title': 'Milk not coming',
      'subtitle': 'cow milk not com...',
      'time': 'Yesterday, 11:00 PM',
      'hasActions': false,
      'isRead': true,
    },
  ];

  void _onNavBarTap(int index) {
    // Navigate to the appropriate page based on selected tab
    // Use the same pattern as other pages - navigate to HomePage with the selected tab index
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage(initialIndex: index)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final screenWidth = size.width;
        final screenHeight = size.height;

        // Calculate responsive values based on screen dimensions
        // Support for various screen sizes: small (< 360), medium (360-400), large (> 400)

        // Responsive header height calculation
        double headerHeight = size.height * 0.22;
        if (headerHeight < 100) headerHeight = 100;
        if (headerHeight > 180) headerHeight = 180;

        // Responsive border radius based on screen width
        final borderRadius = screenWidth < 360
            ? 20.0
            : screenWidth < 400
            ? 25.0
            : 30.0;

        // Responsive horizontal padding
        final horizontalPadding = screenWidth < 360
            ? 12.0
            : screenWidth < 400
            ? 16.0
            : 20.0;

        // Responsive title font size
        final titleFontSize = screenWidth < 360
            ? 17.0
            : screenWidth < 400
            ? 19.0
            : 20.0;

        return Scaffold(
          body: Stack(
            children: [
              // Background Gradient
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

              // Main content
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
                          isMessagePage: true,
                        ),
                      ),
                    ),
                  ),

                  // Content area (white rounded) fills remaining space
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadius),
                        topRight: Radius.circular(borderRadius),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(borderRadius),
                            topRight: Radius.circular(borderRadius),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Message title section
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(
                                horizontalPadding,
                                screenHeight < 600 ? 16 : 20,
                                horizontalPadding,
                                screenHeight < 600 ? 12 : 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(borderRadius),
                                  topRight: Radius.circular(borderRadius),
                                ),
                              ),
                              child: Text(
                                'Message',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            // Message list
                            Expanded(
                              child: _messages.isEmpty
                                  ? Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: horizontalPadding,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.notifications_none,
                                              size: 64,
                                              color: Colors.grey[400],
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              'No notifications',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'You have no new messages',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[500],
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: horizontalPadding,
                                        vertical: screenHeight < 600 ? 4 : 8,
                                      ),
                                      itemCount: _messages.length,
                                      itemBuilder: (context, index) {
                                        final message = _messages[index];
                                        return _buildMessageCard(
                                          message,
                                          screenWidth,
                                          screenHeight,
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: AppNavBar(
            selectedIndex: _selectedIndex,
            onTap: _onNavBarTap,
          ),
        );
      },
    );
  }

  Widget _buildMessageCard(
    Map<String, dynamic> message,
    double screenWidth,
    double screenHeight,
  ) {
    // Comprehensive responsive sizing for all screen sizes
    // Breakpoints: Small (<360), Medium (360-400), Large (400-450), XLarge (>450)

    // Avatar sizing
    final avatarSize = screenWidth < 360
        ? 38.0
        : screenWidth < 400
        ? 42.0
        : screenWidth < 450
        ? 44.0
        : 46.0;

    // Card spacing
    final cardMargin = screenHeight < 600
        ? 6.0
        : screenHeight < 700
        ? 10.0
        : 12.0;

    final cardPadding = screenWidth < 360
        ? 10.0
        : screenWidth < 400
        ? 14.0
        : 16.0;

    final cardBorderRadius = screenWidth < 360
        ? 10.0
        : screenWidth < 400
        ? 11.0
        : 12.0;

    final avatarBorderWidth = screenWidth < 360 ? 1.0 : 1.5;

    // Font sizes based on screen width
    final titleFontSize = screenWidth < 360
        ? 13.5
        : screenWidth < 400
        ? 14.5
        : 15.0;

    final subtitleFontSize = screenWidth < 360
        ? 11.5
        : screenWidth < 400
        ? 12.5
        : 13.0;

    final timeFontSize = screenWidth < 360
        ? 9.0
        : screenWidth < 400
        ? 9.5
        : 10.0;

    final avatarFontSize = screenWidth < 360
        ? 16.0
        : screenWidth < 400
        ? 17.0
        : 18.0;

    final buttonTextSize = screenWidth < 360
        ? 10.5
        : screenWidth < 400
        ? 11.5
        : 12.0;

    // Spacing between elements
    final horizontalSpacing = screenWidth < 360
        ? 8.0
        : screenWidth < 400
        ? 10.0
        : 12.0;

    final verticalSpacing = screenHeight < 600 ? 3.0 : 4.0;

    final buttonSpacing = screenWidth < 360
        ? 5.0
        : screenWidth < 400
        ? 6.0
        : 8.0;

    // Action button sizes
    final actionButtonSize = screenWidth < 360
        ? 28.0
        : screenWidth < 400
        ? 30.0
        : 32.0;

    final actionIconSize = screenWidth < 360
        ? 15.0
        : screenWidth < 400
        ? 16.5
        : 18.0;

    // Done button padding
    final doneButtonHorizontalPadding = screenWidth < 360
        ? 10.0
        : screenWidth < 400
        ? 14.0
        : 16.0;

    final doneButtonVerticalPadding = screenWidth < 360
        ? 4.0
        : screenWidth < 400
        ? 5.0
        : 6.0;

    return InkWell(
      onTap: () {
        // When user clicks on notification, mark it as read
        if (message['hasActions']) {
          setState(() {
            message['isRead'] = true;
            message['hasActions'] = false;
          });
        }
      },
      borderRadius: BorderRadius.circular(cardBorderRadius),
      child: Container(
        margin: EdgeInsets.only(bottom: cardMargin),
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar with 'M' letter
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF2196F3),
                  width: avatarBorderWidth,
                ),
              ),
              child: Center(
                child: Text(
                  'M',
                  style: TextStyle(
                    fontSize: avatarFontSize,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2196F3),
                  ),
                ),
              ),
            ),

            SizedBox(width: horizontalSpacing),

            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title text
                  Text(
                    message['title'],
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: verticalSpacing),
                  // Subtitle and time row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message['subtitle'],
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: subtitleFontSize,
                            color: const Color(0xFF757575),
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: buttonSpacing),
                      Text(
                        message['time'],
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: timeFontSize,
                          color: const Color(0xFF9E9E9E),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action buttons (check and close) for unread messages
            if (message['hasActions']) ...[
              SizedBox(width: buttonSpacing),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Check button
                  InkWell(
                    onTap: () {
                      // Mark as read action
                      setState(() {
                        message['isRead'] = true;
                        message['hasActions'] = false;
                      });
                    },
                    borderRadius: BorderRadius.circular(actionButtonSize / 2),
                    child: Container(
                      width: actionButtonSize,
                      height: actionButtonSize,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: actionIconSize,
                      ),
                    ),
                  ),
                  SizedBox(width: buttonSpacing),
                  // Close button
                  InkWell(
                    onTap: () {
                      // Delete action
                      setState(() {
                        _messages.remove(message);
                      });
                    },
                    borderRadius: BorderRadius.circular(actionButtonSize / 2),
                    child: Container(
                      width: actionButtonSize,
                      height: actionButtonSize,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF44336),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: actionIconSize,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Done button with delete icon for read messages
            if (!message['hasActions'] && message['isRead']) ...[
              SizedBox(width: buttonSpacing),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Done button
                  InkWell(
                    onTap: () {
                      // Remove the notification when Done is clicked
                      setState(() {
                        _messages.remove(message);
                      });
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: doneButtonHorizontalPadding,
                        vertical: doneButtonVerticalPadding,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: buttonSpacing),
                  // Delete icon
                  InkWell(
                    onTap: () {
                      // Delete action for read messages
                      setState(() {
                        _messages.remove(message);
                      });
                    },
                    borderRadius: BorderRadius.circular(actionButtonSize / 2),
                    child: Container(
                      width: actionButtonSize,
                      height: actionButtonSize,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF44336).withAlpha(230),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: actionIconSize,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
