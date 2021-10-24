import 'dart:async';

import 'dart:math';

import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/position.dart';

class KnobData {
  double rotation = pi;
  String label = 'unnamed';
  Position? position;
  Dimensions? dimensions;
}

class KnobState {
  KnobData knobData = KnobData();

  final _stateController = StreamController<KnobData>.broadcast();

  StreamSink<KnobData> get sink => _stateController.sink;
  Stream<KnobData> get stream => _stateController.stream;

  dissolve() => _stateController.close();
}
