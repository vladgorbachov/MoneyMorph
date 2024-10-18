import 'package:flutter/material.dart';
import 'dart:math' as math;

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFD0D0D0),
          Color(0xFFE8E8E8),
          Color(0xFFF5F5F5),
          Color(0xFFE8E8E8),
          Color(0xFFD0D0D0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Add some shimmering effect
    final shimmerPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 10; i++) {
      final xCenter = math.Random().nextDouble() * size.width;
      final yCenter = math.Random().nextDouble() * size.height;
      final radius = math.Random().nextDouble() * 50 + 25;

      canvas.drawCircle(Offset(xCenter, yCenter), radius, shimmerPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}