import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/bloc/knob_event.dart';
import 'package:pedalbrain/widgets/circle_painter.dart';

import 'bloc/knob_bloc.dart';
import 'knob_label.dart';
import 'knob_painter.dart';

class Knob extends StatelessWidget {
  KnobBloc _knobBloc = KnobBloc(initKnobData: KnobData());
  final String label;
  final KnobOptions options;
  final double radius;
  final KnobData initialKnobData;

  Knob({
    Key? key,
    required this.label,
    required this.options,
    required this.radius,
    required this.initialKnobData,
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
    _knobBloc = KnobBloc(initKnobData: initialKnobData);
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
              if (options.isEditable) {
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
              // color: Colors.red,
              child: Column(
                children: [
                  GestureDetector(
                    onPanUpdate: (dragUpdateDetails) => {
                      if (options.isEditable)
                        _knobBloc.handlePan(
                          dragUpdateDetails,
                          radius,
                        ),
                    },
                    child: Center(
                      child: Container(
                        width: radius * 2,
                        height: radius * 2,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        constraints: BoxConstraints(maxWidth: radius * 2),
                        child: Center(
                          child: RepaintBoundary(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  child: RepaintBoundary(
                                    child: CustomPaint(
                                      painter: CirclePainter(
                                          radius: radius + .5,
                                          offset: const Offset(0, 5),
                                          color: Colors.black54),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: RepaintBoundary(
                                    child: CustomPaint(
                                      painter: KnobPainter(
                                        rotation:
                                            _knobBloc.state.knobData.rotation,
                                        radius: radius,
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
                  ),
                  if (options.showLabel)
                    KnobLabel(
                      key: key,
                      text: label,
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
