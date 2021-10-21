import 'dart:async';

import 'dart:math';

class KnobData {
  double rotation = pi;
  String label = 'unnamed';
}

class KnobState {
  KnobData knobData = KnobData();

  final _stateController = StreamController<KnobData>.broadcast();

  StreamSink<KnobData> get sink => _stateController.sink;
  Stream<KnobData> get stream => _stateController.stream;

  dissolve() => _stateController.close();
}
