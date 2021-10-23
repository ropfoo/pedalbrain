import 'dart:async';

import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/position.dart';

enum PedalAction { upatePos, updateDimesnions }

class PedalPayload {
  Position? newPos;
  Dimensions? newDimensions;

  PedalPayload({this.newPos, this.newDimensions});
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
