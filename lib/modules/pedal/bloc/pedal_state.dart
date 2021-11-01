import 'dart:async';

import 'package:pedalbrain/models/pedal_data.dart';

class PedalState {
  PedalData pedalData = PedalData();

  final _stateController = StreamController<PedalData>.broadcast();

  StreamSink<PedalData> get sink => _stateController.sink;
  Stream<PedalData> get stream => _stateController.stream;

  dissolve() => _stateController.close();
}
