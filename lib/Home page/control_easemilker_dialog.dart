import 'package:flutter/material.dart';

/// ControlEasemilkerDialog - popup dialog for controlling Easemilker settings
class ControlEasemilkerDialog extends StatefulWidget {
  final bool initialAlertSound;
  final bool initialDisconnect;
  final Function(bool) onAlertSoundChanged;
  final Function(bool) onDisconnectChanged;

  const ControlEasemilkerDialog({
    super.key,
    required this.initialAlertSound,
    required this.initialDisconnect,
    required this.onAlertSoundChanged,
    required this.onDisconnectChanged,
  });

  @override
  State<ControlEasemilkerDialog> createState() => _ControlEasemilkerDialogState();
}

class _ControlEasemilkerDialogState extends State<ControlEasemilkerDialog> {
  late bool alertSoundEnabled;
  late bool disconnectEnabled;

  @override
  void initState() {
    super.initState();
    alertSoundEnabled = widget.initialAlertSound;
    disconnectEnabled = widget.initialDisconnect;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenWidth * 0.05,
        ),
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
                Text(
                  'Control Easemilker',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Container(
                    width: screenWidth * 0.07,
                    height: screenWidth * 0.07,
                    decoration: const BoxDecoration(
                      color: Color(0xFF212121),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: screenWidth * 0.045,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenWidth * 0.04),

            // Alert Sound Toggle
            _buildToggleRow(
              icon: Icons.volume_up,
              label: 'Alert Sound',
              value: alertSoundEnabled,
              onChanged: (value) {
                setState(() {
                  alertSoundEnabled = value;
                });
                widget.onAlertSoundChanged(value);
              },
              screenWidth: screenWidth,
            ),

            SizedBox(height: screenWidth * 0.03),

            // Disconnect With Machine Toggle
            _buildToggleRow(
              icon: Icons.wifi_off,
              label: 'Disconnect With Machine',
              value: disconnectEnabled,
              onChanged: (value) {
                setState(() {
                  disconnectEnabled = value;
                });
                widget.onDisconnectChanged(value);
              },
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow({
    required IconData icon,
    required String label,
    required bool value,
    required Function(bool) onChanged,
    required double screenWidth,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.035,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF0B57A7),
            size: screenWidth * 0.06,
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: const Color(0xFF212121),
              ),
            ),
          ),
          // Custom toggle switch
          GestureDetector(
            onTap: () => onChanged(!value),
            child: Container(
              width: screenWidth * 0.13,
              height: screenWidth * 0.065,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: value ? const Color(0xFF8DC201) : const Color(0xFFD9D9D9),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: screenWidth * 0.055,
                  height: screenWidth * 0.055,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
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
    );
  }
}

/// Function to show the control easemilker dialog
Future<void> showControlEasemilkerDialog(
  BuildContext context, {
  required bool currentAlertSound,
  required bool currentDisconnect,
  required Function(bool) onAlertSoundChanged,
  required Function(bool) onDisconnectChanged,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return ControlEasemilkerDialog(
        initialAlertSound: currentAlertSound,
        initialDisconnect: currentDisconnect,
        onAlertSoundChanged: onAlertSoundChanged,
        onDisconnectChanged: onDisconnectChanged,
      );
    },
  );
}
