import 'dart:async';

import 'package:pedalbrain/models/knob_data.dart';

class KnobState {
  KnobData knobData = KnobData(
    label: "lel",
    options: KnobOptions(),
  );

  final _stateController = StreamController<KnobData>.broadcast();

  StreamSink<KnobData> get sink => _stateController.sink;
  Stream<KnobData> get stream => _stateController.stream;

  dissolve() => _stateController.close();
}
