import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DonePage - Success confirmation page with animated checkmark
class DonePage extends StatefulWidget {
  final String message;
  final VoidCallback? onComplete;
  final Duration displayDuration;

  const DonePage({
    super.key,
    this.message = 'Done!',
    this.onComplete,
    this.displayDuration = const Duration(seconds: 2),
  });

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _checkmarkAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Scale animation for the gear icon
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    // Fade animation for the text
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    // Checkmark drawing animation
    _checkmarkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    // Rotation animation for the gear
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Start the animation
    _controller.forward();

    // Navigate back or call callback after display duration
    Future.delayed(widget.displayDuration + const Duration(milliseconds: 1200),
        () {
      if (mounted) {
        if (widget.onComplete != null) {
          widget.onComplete!();
        } else {
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF0F3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated gear icon with checkmark
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: CustomPaint(
                      size: const Size(120, 120),
                      painter: GearIconPainter(
                        checkmarkProgress: _checkmarkAnimation.value,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Animated "Done!" text
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1976D2),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the gear icon with checkmark
class GearIconPainter extends CustomPainter {
  final double checkmarkProgress;

  GearIconPainter({required this.checkmarkProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw gear shape
    final gearPaint = Paint()
      ..color = const Color(0xFF1976D2)
      ..style = PaintingStyle.fill;

    final gearPath = Path();
    const toothCount = 8;
    const toothDepth = 0.15;

    for (int i = 0; i < toothCount * 2; i++) {
      final angle = (i * math.pi / toothCount);
      final r = i.isEven ? radius : radius * (1 - toothDepth);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);

      if (i == 0) {
        gearPath.moveTo(x, y);
      } else {
        gearPath.lineTo(x, y);
      }
    }
    gearPath.close();

    canvas.drawPath(gearPath, gearPaint);

    // Draw inner circle (gear center)
    final innerCirclePaint = Paint()
      ..color = const Color(0xFF1976D2)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.65, innerCirclePaint);

    // Draw white background circle for checkmark
    final whiteBgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.5, whiteBgPaint);

    // Draw checkmark
    if (checkmarkProgress > 0) {
      final checkPaint = Paint()
        ..color = const Color(0xFF1976D2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final checkPath = Path();
      
      // Checkmark coordinates
      final startX = center.dx - radius * 0.25;
      final startY = center.dy;
      final midX = center.dx - radius * 0.05;
      final midY = center.dy + radius * 0.2;
      final endX = center.dx + radius * 0.3;
      final endY = center.dy - radius * 0.25;

      // Draw checkmark with animation
      if (checkmarkProgress <= 0.5) {
        // First part of checkmark
        final progress = checkmarkProgress * 2;
        checkPath.moveTo(startX, startY);
        checkPath.lineTo(
          startX + (midX - startX) * progress,
          startY + (midY - startY) * progress,
        );
      } else {
        // Complete first part and draw second part
        final progress = (checkmarkProgress - 0.5) * 2;
        checkPath.moveTo(startX, startY);
        checkPath.lineTo(midX, midY);
        checkPath.lineTo(
          midX + (endX - midX) * progress,
          midY + (endY - midY) * progress,
        );
      }

      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(GearIconPainter oldDelegate) {
    return oldDelegate.checkmarkProgress != checkmarkProgress;
  }
}
