import 'dart:async';

enum KnobAction { turn }

class KnobEventType {
  final double rotation;
  final KnobAction action;

  KnobEventType({required this.rotation, required this.action});
}

class KnobEvent {
  final _eventController = StreamController<KnobEventType>.broadcast();

  StreamSink<KnobEventType> get sink => _eventController.sink;
  Stream<KnobEventType> get stream => _eventController.stream;

  void dissolve() => _eventController.close();
}
