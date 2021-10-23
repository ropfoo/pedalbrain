import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/bloc/knob_event.dart';

import 'bloc/knob_bloc.dart';
import 'knob_label.dart';
import 'knob_painter.dart';

class Knob extends StatelessWidget {
  final _knobBloc = KnobBloc();
  final double radius;
  final String label;

  Knob({
    Key? key,
    required this.radius,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: key,
      stream: _knobBloc.state.stream,
      builder: (context, snapshot) {
        double currXPos = _knobBloc.state.knobData.position?.x ?? 0;
        double currYPos = _knobBloc.state.knobData.position?.y ?? 0;

        return Positioned(
          left: currXPos,
          top: currYPos,
          child: GestureDetector(
            onPanUpdate: (tapInfo) {
              double parentWidth =
                  context.findAncestorStateOfType()?.context.size?.width ?? 0;
              double parentHeight =
                  context.findAncestorStateOfType()?.context.size?.height ?? 0;
              Dimensions parentDimensions =
                  Dimensions(width: parentWidth, height: parentHeight);
              double currWidth = context.size?.width ?? 0;
              double currHeight = context.size?.height ?? 0;
              bool validYPos = currYPos + tapInfo.delta.dy > 0 &&
                  currYPos + tapInfo.delta.dy <
                      parentDimensions.height - currHeight - 10;
              bool validXPos = currXPos + tapInfo.delta.dx > 0 &&
                  currXPos + tapInfo.delta.dx <
                      parentDimensions.width - currWidth - 20;

              if ((validYPos && validXPos) ||
                  _knobBloc.state.knobData.position == null) {
                _knobBloc.event.sink.add(
                  KnobEventType(
                    action: KnobAction.updatePos,
                    payload: KnobPayload(
                      newPos: Position(
                        x: currXPos + tapInfo.delta.dx.round(),
                        y: currYPos + tapInfo.delta.dy.round(),
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(
              // color: Colors.red,
              child: Column(
                children: [
                  GestureDetector(
                    onPanUpdate: (dragUpdateDetails) =>
                        _knobBloc.handlePan(dragUpdateDetails, radius),
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
                          child: CustomPaint(
                            painter: KnobPainter(
                              rotation: _knobBloc.state.knobData.rotation,
                              radius: radius,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
