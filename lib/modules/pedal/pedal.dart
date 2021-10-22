import 'package:flutter/material.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_bloc.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_event.dart';

class Pedal extends StatelessWidget {
  final _pedalBloc = PedalBloc();

  final List<Knob> _knobs = [
    Knob(radius: 40, label: 'Bass'),
    Knob(radius: 40, label: 'Gain'),
    Knob(radius: 40, label: 'Treble')
  ];

  Pedal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _pedalBloc.state.stream,
      builder: (constex, snapshot) {
        double currXPos = _pedalBloc.state.pedalData.position.x;
        double currYPos = _pedalBloc.state.pedalData.position.y;
        return Positioned(
          left: currXPos,
          top: currYPos,
          child: GestureDetector(
            onPanUpdate: (tapInfo) {
              _pedalBloc.event.sink.add(
                PedalEventType(
                  action: PedalAction.upatePos,
                  payload: PedalPayload(
                    newPos: Position(
                      x: currXPos + tapInfo.delta.dx,
                      y: currYPos + tapInfo.delta.dy,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.amber,
              width: 300,
              height: 200,
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: _knobs,
              ),
            ),
          ),
        );
      },
    );
  }
}
