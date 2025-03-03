import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  final double widthPercentage;
  final double heightPercentage;
  final double gapPercentage;

  ScannerOverlay({
    this.widthPercentage = 0.7,
    this.heightPercentage = 0.74,
    this.gapPercentage = 0.05,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OverlayPainter(
        widthPercentage: widthPercentage,
        heightPercentage: heightPercentage,
        gapPercentage: gapPercentage,
      ),
      child: SizedBox.expand(),
    );
  }
}

class _OverlayPainter extends CustomPainter {
  final double widthPercentage;
  final double heightPercentage;
  final double gapPercentage;

  _OverlayPainter({
    required this.widthPercentage,
    required this.heightPercentage,
    required this.gapPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.25),
      width: size.width * widthPercentage,
      height: size.width * heightPercentage,
    );

    final borderRadius = BorderRadius.circular(20);
    final path = Path()..addRRect(borderRadius.toRRect(rect));

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.transparent
        ..style = PaintingStyle.fill,
    );

    final maskPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    maskPath.addPath(path.computeMetrics().first.extractPath(0.0, path.computeMetrics().first.length), Offset.zero);
    maskPath.fillType = PathFillType.evenOdd;

    canvas.drawPath(
      maskPath,
      Paint()
        ..color = Colors.black.withOpacity(0.5)
        ..style = PaintingStyle.fill,
    );

    final cornerSize = 40.0;
    final cornerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final curveRadius = 10.0;

    // Calculate gap in pixels
    final gap = cornerSize * gapPercentage/2;

    // Top-left
    Path topLeftPath = Path();
    topLeftPath.moveTo(rect.topLeft.dx + gap, rect.topLeft.dy + curveRadius + gap);
    topLeftPath.quadraticBezierTo(
        rect.topLeft.dx + gap, rect.topLeft.dy + gap, rect.topLeft.dx + curveRadius + gap, rect.topLeft.dy + gap);
    topLeftPath.lineTo(rect.topLeft.dx + cornerSize, rect.topLeft.dy + gap);

    Path topLeftPath2 = Path();
    topLeftPath2.moveTo(rect.topLeft.dx + curveRadius + gap, rect.topLeft.dy + gap);
    topLeftPath2.quadraticBezierTo(
        rect.topLeft.dx + gap, rect.topLeft.dy + gap, rect.topLeft.dx + gap, rect.topLeft.dy + curveRadius + gap);
    topLeftPath2.lineTo(rect.topLeft.dx + gap, rect.topLeft.dy + cornerSize);

    canvas.drawPath(topLeftPath, cornerPaint..color = Colors.orange);
    canvas.drawPath(topLeftPath2, cornerPaint..color = Colors.orange);

    // Top-right
    // ... (similar adjustments for other corners)
    Path topRightPath = Path();
    topRightPath.moveTo(rect.topRight.dx - gap, rect.topRight.dy + curveRadius + gap);
    topRightPath.quadraticBezierTo(rect.topRight.dx - gap, rect.topRight.dy + gap,
        rect.topRight.dx - curveRadius - gap, rect.topRight.dy + gap);
    topRightPath.lineTo(rect.topRight.dx - cornerSize, rect.topRight.dy + gap);

    Path topRightPath2 = Path();
    topRightPath2.moveTo(rect.topRight.dx - curveRadius - gap, rect.topRight.dy + gap);
    topRightPath2.quadraticBezierTo(rect.topRight.dx - gap, rect.topRight.dy + gap,
        rect.topRight.dx - gap, rect.topRight.dy + curveRadius + gap);
    topRightPath2.lineTo(rect.topRight.dx - gap, rect.topRight.dy + cornerSize);

    canvas.drawPath(topRightPath, cornerPaint..color = Colors.orange);
    canvas.drawPath(topRightPath2, cornerPaint..color = Colors.orange);

    // Bottom-left
    Path bottomLeftPath = Path();
    bottomLeftPath.moveTo(rect.bottomLeft.dx + gap, rect.bottomLeft.dy - curveRadius - gap);
    bottomLeftPath.quadraticBezierTo(rect.bottomLeft.dx + gap, rect.bottomLeft.dy - gap,
        rect.bottomLeft.dx + curveRadius + gap, rect.bottomLeft.dy - gap);
    bottomLeftPath.lineTo(rect.bottomLeft.dx + cornerSize, rect.bottomLeft.dy - gap);

    Path bottomLeftPath2 = Path();
    bottomLeftPath2.moveTo(rect.bottomLeft.dx + curveRadius + gap, rect.bottomLeft.dy - gap);
    bottomLeftPath2.quadraticBezierTo(rect.bottomLeft.dx + gap, rect.bottomLeft.dy - gap,
        rect.bottomLeft.dx + gap, rect.bottomLeft.dy - curveRadius - gap);
    bottomLeftPath2.lineTo(rect.bottomLeft.dx + gap, rect.bottomLeft.dy - cornerSize);

    canvas.drawPath(bottomLeftPath, cornerPaint..color = Colors.green);
    canvas.drawPath(bottomLeftPath2, cornerPaint..color = Colors.green);

    // Bottom-right
    Path bottomRightPath = Path();
    bottomRightPath.moveTo(rect.bottomRight.dx - gap, rect.bottomRight.dy - curveRadius - gap);
    bottomRightPath.quadraticBezierTo(rect.bottomRight.dx - gap, rect.bottomRight.dy - gap,
        rect.bottomRight.dx - curveRadius - gap, rect.bottomRight.dy - gap);
    bottomRightPath.lineTo(rect.bottomRight.dx - cornerSize, rect.bottomRight.dy - gap);

    Path bottomRightPath2 = Path();
    bottomRightPath2.moveTo(rect.bottomRight.dx - curveRadius - gap, rect.bottomRight.dy - gap);
    bottomRightPath2.quadraticBezierTo(rect.bottomRight.dx - gap, rect.bottomRight.dy - gap,
        rect.bottomRight.dx - gap, rect.bottomRight.dy - curveRadius - gap);
    bottomRightPath2.lineTo(rect.bottomRight.dx - gap, rect.bottomRight.dy - cornerSize);

    canvas.drawPath(bottomRightPath, cornerPaint..color = Colors.blue);
    canvas.drawPath(bottomRightPath2, cornerPaint..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}