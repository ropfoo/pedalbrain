import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        double currXPos = _knobBloc.state.knobData.position.xPos;
        double currYPos = _knobBloc.state.knobData.position.yPos;
        return Positioned(
            left: currXPos,
            top: currYPos,
            child: GestureDetector(
              onPanUpdate: (tapInfo) {
                _knobBloc.event.sink.add(
                  KnobEventType(
                    action: KnobAction.updatePos,
                    payload: KnobPayload(
                      newPos: Pos(
                        xPos: currXPos + tapInfo.delta.dx,
                        yPos: currYPos + tapInfo.delta.dy,
                      ),
                    ),
                  ),
                );
              },
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
            ));
      },
    );
  }
}
