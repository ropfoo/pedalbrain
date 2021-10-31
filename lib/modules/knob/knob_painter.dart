import 'package:flutter/material.dart';

class KnobPainter extends CustomPainter {
  final double rotation;
  final double radius;

  KnobPainter({
    required this.rotation,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.rotate(rotation);

    canvas.drawCircle(
      const Offset(0, 0),
      radius,
      Paint(),
    );

    final linePaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = radius / 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 0), Offset(0, radius - 7), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != rotation;
  }
}
