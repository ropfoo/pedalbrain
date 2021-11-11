import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double radius;
  final Offset? offset;
  final Color? color;

  CirclePainter({required this.radius, this.offset, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      offset ?? const Offset(0, 0),
      radius + .5,
      Paint()..color = color ?? Colors.blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
