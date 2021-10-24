import 'dart:async';

import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/position.dart';

enum KnobAction { turn, updatePos, setDimensions }

class KnobPayload {
  double? rotation;
  Position? newPos;
  Dimensions? newDimensions;
  KnobPayload({this.rotation, this.newPos, this.newDimensions});
}

class KnobEventType {
  KnobPayload? payload;
  final KnobAction action;

  KnobEventType({this.payload, required this.action});
}

class KnobEvent {
  final _eventController = StreamController<KnobEventType>.broadcast();

  StreamSink<KnobEventType> get sink => _eventController.sink;
  Stream<KnobEventType> get stream => _eventController.stream;

  void dissolve() => _eventController.close();
}
