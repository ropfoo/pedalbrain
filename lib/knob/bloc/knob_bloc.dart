import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:pedalbrain/knob/bloc/knob_event.dart';
import 'package:pedalbrain/knob/bloc/knob_state.dart';

class KnobBloc {
  final state = KnobState();
  final event = KnobEvent();

  KnobBloc() {
    event.stream.listen((event) {
      switch (event.action) {
        case KnobAction.turn:
          state.rotation = event.rotation;
          break;
        default:
          state.rotation = pi;
      }
      state.sink.add(state.rotation);
    });
  }

  void handlePan(DragUpdateDetails dragUpdateDetails, double radius) {
    /// Pan location on the wheel
    bool onTop = dragUpdateDetails.localPosition.dy <= radius;
    bool onLeftSide = dragUpdateDetails.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    /// Pan movements
    bool panUp = dragUpdateDetails.delta.dy <= 0.0;
    bool panLeft = dragUpdateDetails.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    /// Absoulte change on axis

    double yChange = dragUpdateDetails.delta.dy.abs();
    double xChange = dragUpdateDetails.delta.dx.abs();

    /// Directional change on wheel
    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
        ? yChange
        : yChange * -1;

    double horizontalRotation =
        (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

    // Total computed change
    double rotationalChange = verticalRotation + horizontalRotation;

    double rotation = state.rotation + rotationalChange / 100;

    event.sink.add(KnobEventType(rotation: rotation, action: KnobAction.turn));
  }
}
