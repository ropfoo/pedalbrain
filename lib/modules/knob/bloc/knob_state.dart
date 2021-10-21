import 'dart:async';

import 'dart:math';

import 'package:pedalbrain/modules/knob/bloc/knob_event.dart';

class KnobData {
  double rotation = pi;
  String label = 'unnamed';
  Pos position = Pos(xPos: 0, yPos: 0);
}

class KnobState {
  KnobData knobData = KnobData();

  final _stateController = StreamController<KnobData>.broadcast();

  StreamSink<KnobData> get sink => _stateController.sink;
  Stream<KnobData> get stream => _stateController.stream;

  dissolve() => _stateController.close();
}
