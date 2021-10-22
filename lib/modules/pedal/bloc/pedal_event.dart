import 'dart:async';

import 'package:pedalbrain/models/position.dart';

enum PedalAction { upatePos }

class PedalPayload {
  Position? newPos;

  PedalPayload({this.newPos});
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
