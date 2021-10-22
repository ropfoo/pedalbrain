import 'dart:async';

import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

class PedalData {
  List<Knob>? knobs;
  Position position = Position(x: 0, y: 0);
}

class PedalState {
  PedalData pedalData = PedalData();

  final _stateController = StreamController<PedalData>.broadcast();

  StreamSink<PedalData> get sink => _stateController.sink;
  Stream<PedalData> get stream => _stateController.stream;

  dissolve() => _stateController.close();
}
