import 'dart:math';

import 'package:pedalbrain/models/position.dart';

import 'dimensions.dart';

class KnobData {
  double rotation = pi;
  String label;
  Position? position;
  Dimensions? dimensions;
  KnobOptions options;

  KnobData({
    required this.label,
    this.position,
    required this.options,
  });
}

class KnobOptions {
  final bool isEditable;
  final bool showLabel;
  final double radius;

  KnobOptions({
    this.showLabel = true,
    this.isEditable = false,
    this.radius = 25,
  });
}
