import 'package:flutter/material.dart';

/// Reusable top header used by HomePage and HistoryPage.
/// Shows avatar, name, id pill and a notification icon on the right.
class TopHeader extends StatelessWidget {
  const TopHeader({
    super.key,
    required this.name,
    required this.idText,
    this.avatarAsset,
    this.isMessagePage = false,
    this.padding = const EdgeInsets.fromLTRB(16, 32, 16, 12),
  });

  final String name;
  final String idText;
  final String? avatarAsset;
  final bool isMessagePage;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: profile icon
          SizedBox(
            width: 64,
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  // Navigate to Settings page when user taps avatar/profile area
                  Navigator.pushNamed(context, '/settings');
                },
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x1A000000),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: avatarAsset == null
                        ? const Icon(
                            Icons.person,
                            color: Color(0xFF006CC7),
                            size: 30,
                          )
                        : ClipOval(
                            child: Image.asset(
                              avatarAsset!,
                              fit: BoxFit.cover,
                              width: 46,
                              height: 46,
                              errorBuilder: (c, e, s) => const Icon(
                                Icons.person,
                                color: Color(0xFF006CC7),
                                size: 30,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),

          // Name + id left aligned
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x3368B6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    idText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF0B57A7),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right: notification icon (changes based on if we're on message page)
          SizedBox(
            width: 64,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: isMessagePage
                    ? null
                    : () {
                        // Navigate to Message page when user taps the bell icon
                        Navigator.pushNamed(context, '/messages');
                      },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  isMessagePage
                      ? Icons.notifications
                      : Icons.notifications_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
