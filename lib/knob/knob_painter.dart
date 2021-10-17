import 'dart:math';

import 'package:flutter/material.dart';

class KnobPainter extends CustomPainter {
  final double rotation;
  final double radius;

  KnobPainter({required this.rotation, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.rotate(rotation);
    canvas.drawCircle(const Offset(0, 0), radius, Paint());

    final linePaint = Paint()
      ..color = Colors.blue.shade400
      ..strokeWidth = radius / 5;
    canvas.drawLine(const Offset(0, 0), Offset(0, radius), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != rotation;
  }
}
