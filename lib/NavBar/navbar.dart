import 'package:flutter/material.dart';

/// Controlled AppNavBar: parent passes [selectedIndex] and [onTap].
class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const List<IconData> _icons = [
    Icons.home,
    Icons.history,
    Icons.location_on,
    Icons.shopping_cart,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: LayoutBuilder(builder: (context, outer) {
        const navBarHeight = 56.0;
        const iconSize = 24.0;

        return Container(
          height: navBarHeight + bottomPadding,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF0786F0),
                Color(0xFF044D8A),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(46),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_icons.length, (index) {
                final isSelected = index == selectedIndex;
                return Expanded(
                  child: InkWell(
                    onTap: () => onTap(index),
                    borderRadius: BorderRadius.circular(12),
                    splashColor: Colors.white24,
                    highlightColor: Colors.white10,
                    child: Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Icon(
                        _icons[index],
                        size: iconSize,
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withAlpha(153),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
