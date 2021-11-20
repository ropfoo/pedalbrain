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

  KnobOptions({
    this.showLabel = true,
    this.isEditable = false,
  });
}
