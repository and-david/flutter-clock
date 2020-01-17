import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class DrawnBackground extends StatelessWidget {
  final Color color;
  final Color backgroundColor;

  const DrawnBackground({
    @required this.color,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _BackgroundPainter(
            color: color,
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter({
    @required this.color,
    @required this.backgroundColor,
  })  : assert(color != null),
        assert(backgroundColor != null);

  Color color;
  Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final radius = size.shortestSide * 0.5;
    final circlePaint = Paint()..color = backgroundColor;

    for (int i = 10; i >= 4; i--) {
      canvas.drawCircle(center, radius * i / 10.0, circlePaint);
    }

    for (int i = 0; i < 60; i++) {
      final angle = i * radians(360 / 60) - math.pi / 2.0;
      final length = i % 5 == 0 ? radius * 0.9 : radius * 0.95;
      final p1 = center + Offset(math.cos(angle), math.sin(angle)) * length;
      final p2 = center + Offset(math.cos(angle), math.sin(angle)) * radius;
      final linePaint = Paint()
        ..color = color
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(p1, p2, linePaint);
    }
  }

  @override
  bool shouldRepaint(_BackgroundPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
