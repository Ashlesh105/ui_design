import 'dart:math';
import 'package:flutter/material.dart';

class RoundedPieChartPainter extends CustomPainter {
  final List<double> sections;
  final List<Color> colors;
  final double strokeWidth;
  final double spacingAngle;
  final double animationValue;

  RoundedPieChartPainter({
    required this.sections,
    required this.colors,
    required this.strokeWidth,
    this.spacingAngle = 0.05,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth / 2;
    var startAngle = -pi / 2;

    double total = sections.reduce((a, b) => a + b);

    for (int i = 0; i < sections.length; i++) {
      double sweepAngle = 2 * pi * (sections[i] / total) - spacingAngle;
      double animatedSweepAngle = sweepAngle * animationValue;

      final sectionColor = colors[i % colors.length];

      final paint = Paint()
        ..color = sectionColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startAngle, animatedSweepAngle, false, paint);

      startAngle += sweepAngle + spacingAngle; // Increment by the full sweepAngle, not the animated one.
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}