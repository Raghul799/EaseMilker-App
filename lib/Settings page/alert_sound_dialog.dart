import 'package:flutter/material.dart';

/// AlertSoundDialog - popup dialog for controlling alert sound settings
class AlertSoundDialog extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onChanged;

  const AlertSoundDialog({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<AlertSoundDialog> createState() => _AlertSoundDialogState();
}

class _AlertSoundDialogState extends State<AlertSoundDialog> {
  late bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with title and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Alert Sound',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFF212121),
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

            const SizedBox(height: 24),

            // Ease Milker Logo
            Image.asset(
              'assets/images/Group 24.png',
              width: 180,
              height: 60,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 180,
                  height: 60,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.image, size: 30)),
                );
              },
            ),

            const SizedBox(height: 24),

            // On/Off toggle buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton('on', true),
                const SizedBox(width: 16),
                _buildToggleButton('off', false),
              ],
            ),

            const SizedBox(height: 20),

            // Info message
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFB74D), width: 1),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFFF9800),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This is plugin to access our high-volume milking machine',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[800],
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool value) {
    final bool isSelected = isEnabled == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          isEnabled = value;
        });
        widget.onChanged(value);
      },
      child: Container(
        width: 80,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0B57A7) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0B57A7)
                : const Color(0xFFE0E0E0),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF9E9E9E),
            ),
          ),
        ),
      ),
    );
  }
}

/// Function to show the alert sound dialog
Future<void> showAlertSoundDialog(
  BuildContext context, {
  required bool currentValue,
  required Function(bool) onChanged,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertSoundDialog(initialValue: currentValue, onChanged: onChanged);
    },
  );
}
