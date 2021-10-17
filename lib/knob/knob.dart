import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pedalbrain/knob/bloc/knob_bloc.dart';

import 'knob_painter.dart';

class Knob extends StatelessWidget {
  final _knobBloc = KnobBloc();
  final double radius;

  Knob({Key? key, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: key,
      stream: _knobBloc.state.stream,
      builder: (context, snapshot) {
        return GestureDetector(
          onPanUpdate: (dragUpdateDetails) =>
              _knobBloc.handlePan(dragUpdateDetails, radius),
          child: Container(
            width: radius * 2,
            height: radius * 2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Center(
              child: CustomPaint(
                painter: KnobPainter(
                  rotation: _knobBloc.state.rotation,
                  radius: radius,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
