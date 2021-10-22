import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:pedalbrain/models/position.dart';

import 'knob_event.dart';
import 'knob_state.dart';

class KnobBloc {
  final state = KnobState();
  final event = KnobEvent();

  KnobBloc() {
    event.stream.listen((event) {
      switch (event.action) {
        case KnobAction.turn:
          state.knobData.rotation = event.payload?.rotation ?? 0;
          break;

        case KnobAction.updatePos:
          state.knobData.position =
              event.payload?.newPos ?? Position(x: 0, y: 0);
          break;

        default:
          state.knobData.rotation = pi;
      }
      state.sink.add(state.knobData);
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

    double rotation = state.knobData.rotation + rotationalChange / 50;

    event.sink.add(KnobEventType(
        payload: KnobPayload(rotation: rotation), action: KnobAction.turn));
  }
}
