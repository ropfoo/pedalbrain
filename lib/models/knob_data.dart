import 'dart:math';

import 'package:pedalbrain/models/position.dart';

import 'dimensions.dart';

class KnobData {
  double rotation = pi;
  String label = 'unnamed';
  Position? position;
  Dimensions? dimensions;
  KnobOptions options;

  KnobData({this.position, required this.options});
}

class KnobOptions {
  final bool isEditable;
  final bool showLabel;
  final double resizeFactor;

  KnobOptions({
    this.showLabel = true,
    this.isEditable = false,
    this.resizeFactor = 1,
  });
}
