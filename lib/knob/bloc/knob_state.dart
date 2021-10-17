import 'dart:async';

import 'dart:math';

class KnobState {
  double rotation = pi;

  final _stateController = StreamController<double>.broadcast();

  StreamSink<double> get sink => _stateController.sink;
  Stream<double> get stream => _stateController.stream;

  dissolve() => _stateController.close();
}
