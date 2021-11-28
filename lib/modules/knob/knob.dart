import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/bloc/knob_event.dart';
import 'package:pedalbrain/widgets/circle_painter.dart';

import 'bloc/knob_bloc.dart';
import 'knob_label.dart';
import 'knob_painter.dart';

class Knob extends StatelessWidget {
  KnobBloc _knobBloc = KnobBloc(
    initKnobData: KnobData(
      label: "unnamed",
      options: KnobOptions(),
    ),
  );
  final KnobData knobData;

  Knob({
    Key? key,
    required this.knobData,
  }) : super(key: key);

  Position getPosition() {
    return _knobBloc.state.knobData.position ?? Position(x: 0, y: 0);
  }

  void updatePosition(Position newPosition) {
    _knobBloc.event.sink.add(
      KnobEventType(
        action: KnobAction.updatePos,
        payload: KnobPayload(
          newPos: newPosition,
        ),
      ),
    );
  }

  void setRadius(double newRadius) {
    _knobBloc.event.sink.add(
      KnobEventType(
        action: KnobAction.updateOptions,
        payload: KnobPayload(
          newOptions: KnobOptions(
            isEditable: _knobBloc.state.knobData.options.isEditable,
            showLabel: _knobBloc.state.knobData.options.showLabel,
            radius: newRadius,
          ),
        ),
      ),
    );
  }

  void setLabel(String newLabel) {
    _knobBloc.event.sink.add(
      KnobEventType(
        action: KnobAction.setLabel,
        payload: KnobPayload(
          newLabel: newLabel,
        ),
      ),
    );
  }

  void updateOptions(KnobOptions newKnobOptions) {
    _knobBloc.event.sink.add(
      KnobEventType(
        action: KnobAction.updateOptions,
        payload: KnobPayload(
          newOptions: newKnobOptions,
        ),
      ),
    );
  }

  void toggleEditMode() {
    _knobBloc.event.sink.add(
      KnobEventType(
        action: KnobAction.updateOptions,
        payload: KnobPayload(
          newOptions: KnobOptions(
            isEditable: !_knobBloc.state.knobData.options.isEditable,
            radius: _knobBloc.state.knobData.options.radius,
          ),
        ),
      ),
    );
  }

  Dimensions getDimensions() {
    return _knobBloc.state.knobData.dimensions ??
        Dimensions(width: 100, height: 100);
  }

  void _setDimensions(Dimensions newDimensions) {
    _knobBloc.event.sink.add(
      KnobEventType(
        action: KnobAction.setDimensions,
        payload: KnobPayload(newDimensions: newDimensions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool shouldRepaint = false;
    double distance = 0;
    _knobBloc = KnobBloc(initKnobData: knobData);
    return StreamBuilder(
      key: key,
      stream: _knobBloc.state.stream,
      builder: (context, snapshot) {
        double currXPos = _knobBloc.state.knobData.position?.x ?? 0;
        double currYPos = _knobBloc.state.knobData.position?.y ?? 0;

        updatePosition(Position(x: currXPos, y: currYPos));

        return Positioned(
          left: currXPos,
          top: currYPos,
          child: GestureDetector(
            onPanUpdate: (tapInfo) {
              if (_knobBloc.state.knobData.options.isEditable) {
                double parentWidth =
                    context.findAncestorStateOfType()?.context.size?.width ?? 0;

                double parentHeight =
                    context.findAncestorStateOfType()?.context.size?.height ??
                        0;

                Dimensions parentDimensions =
                    Dimensions(width: parentWidth, height: parentHeight);

                double currWidth = context.size?.width ?? 0;
                double currHeight = context.size?.height ?? 0;
                _setDimensions(
                  Dimensions(
                    width: currWidth,
                    height: currHeight,
                  ),
                );

                bool validYPos = currYPos + tapInfo.delta.dy > 0 &&
                    currYPos + tapInfo.delta.dy <
                        parentDimensions.height - currHeight - 10;

                bool validXPos = currXPos + tapInfo.delta.dx > 0 &&
                    currXPos + tapInfo.delta.dx <
                        parentDimensions.width - currWidth - 20;

                if ((validYPos && validXPos) ||
                    _knobBloc.state.knobData.position == null) {
                  updatePosition(
                    Position(
                      x: currXPos + tapInfo.delta.dx.round(),
                      y: currYPos + tapInfo.delta.dy.round(),
                    ),
                  );
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: _knobBloc.state.knobData.options.isEditable
                    ? Colors.white60
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onPanUpdate: (dragUpdateDetails) {
                      if (_knobBloc.state.knobData.options.isEditable) {
                        _knobBloc.handlePan(
                          dragUpdateDetails,
                          _knobBloc.state.knobData.options.radius,
                        );
                        shouldRepaint =
                            dragUpdateDetails.delta.distance != distance;
                        distance = dragUpdateDetails.delta.distance;
                      }
                    },
                    onPanEnd: (dragUpdateDetails) {
                      shouldRepaint = false;
                    },
                    child: Center(
                      child: Container(
                        width: _knobBloc.state.knobData.options.radius * 2,
                        height: _knobBloc.state.knobData.options.radius * 2,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        constraints: BoxConstraints(
                            maxWidth:
                                _knobBloc.state.knobData.options.radius * 2),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                child: RepaintBoundary(
                                  child: CustomPaint(
                                    painter: CirclePainter(
                                        radius: _knobBloc
                                                .state.knobData.options.radius +
                                            .5,
                                        offset: const Offset(0, 5),
                                        color: Colors.black54),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: RepaintBoundary(
                                  child: CustomPaint(
                                    painter: KnobPainter(
                                      isEditable: shouldRepaint,
                                      rotation:
                                          _knobBloc.state.knobData.rotation,
                                      radius: _knobBloc
                                          .state.knobData.options.radius,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_knobBloc.state.knobData.options.showLabel)
                    KnobLabel(
                      key: key,
                      text: knobData.label,
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
