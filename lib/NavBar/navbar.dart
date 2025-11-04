import 'package:flutter/material.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int _selectedIndex = 0;

  final List<IconData> _icons = const [
    Icons.home,
    Icons.history,
    Icons.location_on,
    Icons.shopping_cart,
    Icons.settings,
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: LayoutBuilder(builder: (context, outer) {
        // Fixed navbar height that works across all mobile screens
        const navBarHeight = 56.0;

        // Icon size is fixed and appropriate for mobile
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
                final isSelected = index == _selectedIndex;
                return Expanded(
                  child: InkWell(
                    onTap: () => _onTap(index),
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
