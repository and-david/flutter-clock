import 'package:flutter/material.dart';

class DrawnWeather extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String temperature;
  final String temperatureLow;
  final String temperatureHigh;
  final String condition;

  const DrawnWeather({
    @required this.color,
    @required this.backgroundColor,
    @required this.temperature,
    @required this.temperatureLow,
    @required this.temperatureHigh,
    @required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _WeatherPainter(
            color: color,
            backgroundColor: backgroundColor,
            temperature: temperature,
            temperatureLow: temperatureLow,
            temperatureHigh: temperatureHigh,
            condition: condition,
          ),
        ),
      ),
    );
  }
}

class _WeatherPainter extends CustomPainter {
  _WeatherPainter({
    @required this.color,
    @required this.backgroundColor,
    @required this.temperature,
    @required this.temperatureLow,
    @required this.temperatureHigh,
    @required this.condition,
  });

  Color color;
  Color backgroundColor;
  final String temperature;
  final String temperatureLow;
  final String temperatureHigh;
  final String condition;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide * 0.5;
    final center = (Offset.zero & size).center;

    _drawnSection1(canvas, center, radius);
    _drawnSection2(canvas, center, radius);
  }

  _drawnSection1(Canvas canvas, Offset center, double radius) {
    final newCenter = center - Offset(0, radius * 2 / 3);
    final circlePaint = Paint()..color = backgroundColor.withOpacity(0.2);

    for (int i = 10; i >= 6; i--) {
      canvas.drawCircle(newCenter, radius / 4 * i / 10, circlePaint);
    }

    _drawnText(canvas, newCenter, radius / 4, temperature, 14.0, 0.5);
    _drawnText(canvas, newCenter - Offset(0, 18.0), radius / 4, temperatureHigh,
        12.0, 0.4);
    _drawnText(canvas, newCenter + Offset(0, 18.0), radius / 4, temperatureLow,
        12.0, 0.4);
  }

  _drawnSection2(Canvas canvas, Offset center, double radius) {
    final newCenter = center + Offset(0, radius * 2 / 3);
    final paint = Paint()..color = backgroundColor.withOpacity(0.2);

    for (int i = 10; i >= 6; i--) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: newCenter,
            width: radius * 0.8 * i / 10,
            height: radius / 6 * i / 10,
          ),
          Radius.circular(12.0),
        ),
        paint,
      );
    }

    _drawnText(
        canvas, newCenter, radius * 0.8, condition.toUpperCase(), 16.0, 0.5);
  }

  _drawnText(Canvas canvas, Offset center, double width, String text,
      double fontSize, double opacity) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: color.withOpacity(opacity),
        ),
      )
      ..maxLines = 1
      ..textAlign = TextAlign.center
      ..layout(
        maxWidth: width,
      );
    final offset =
        center - Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_WeatherPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.temperature != temperature ||
        oldDelegate.temperatureLow != temperatureLow ||
        oldDelegate.temperatureHigh != temperatureHigh ||
        oldDelegate.condition != condition;
  }
}
