import 'dart:async';

import 'package:pedalbrain/models/position.dart';

enum KnobAction { turn, updatePos }

class KnobPayload {
  double? rotation;
  Position? newPos;
  KnobPayload({this.rotation, this.newPos});
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
