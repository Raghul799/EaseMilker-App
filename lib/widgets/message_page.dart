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
  final int _selectedIndex = -1; // No tab selected initially since this is accessed via bell icon

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
      MaterialPageRoute(
        builder: (context) => HomePage(initialIndex: index),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.22;
    if (headerHeight < 110) headerHeight = 110;
    if (headerHeight > 180) headerHeight = 180;

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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Message title section
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Message',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // Message list
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              final message = _messages[index];
                              return _buildMessageCard(message);
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
  }

  Widget _buildMessageCard(Map<String, dynamic> message) {
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar with 'M' letter
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF2196F3),
                  width: 1.5,
                ),
              ),
              child: const Center(
                child: Text(
                  'M',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2196F3),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message['title'],
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        message['time'],
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 10,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message['subtitle'],
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: Color(0xFF757575),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Action buttons (check and close) for unread messages
            if (message['hasActions']) ...[
              const SizedBox(width: 8),
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
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Close button
                  InkWell(
                    onTap: () {
                      // Delete action
                      setState(() {
                        _messages.remove(message);
                        // If all notifications are cleared, exit the message page
                        if (_messages.isEmpty) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF44336),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Done button with delete icon for read messages
            if (!message['hasActions'] && message['isRead']) ...[
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Done button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2196F3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Delete icon
                  InkWell(
                    onTap: () {
                      // Delete action for read messages
                      setState(() {
                        _messages.remove(message);
                        // If all notifications are cleared, exit the message page
                        if (_messages.isEmpty) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF44336).withAlpha(230),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 18,
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
