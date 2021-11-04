import 'dart:async';

import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';

class PedalState {
  PedalData pedalData = PedalData(
    dimensions: Dimensions(height: 300, width: 500),
    knobs: [],
    position: Position(x: 0, y: 0),
  );

  final _stateController = StreamController<PedalData>.broadcast();

  StreamSink<PedalData> get sink => _stateController.sink;
  Stream<PedalData> get stream => _stateController.stream;

  dissolve() => _stateController.close();
}
