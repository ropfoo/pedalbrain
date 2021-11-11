import 'dart:async';

import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

enum PedalAction {
  upatePos,
  updateDimesnions,
  setKnobs,
  toggleEditable,
}

class PedalPayload {
  Position? newPos;
  Dimensions? newDimensions;
  List<Knob>? newKnobs;
  bool? editable;

  PedalPayload({
    this.newPos,
    this.newDimensions,
    this.newKnobs,
    this.editable,
  });
}

class PedalEventType {
  PedalPayload? payload;
  final PedalAction action;

  PedalEventType({this.payload, required this.action});
}

class PedalEvent {
  final _eventController = StreamController<PedalEventType>.broadcast();

  StreamSink<PedalEventType> get sink => _eventController.sink;
  Stream<PedalEventType> get stream => _eventController.stream;
}
