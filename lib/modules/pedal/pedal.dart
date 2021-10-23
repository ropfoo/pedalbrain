import 'package:flutter/material.dart';
import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_bloc.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_event.dart';

class Pedal extends StatelessWidget {
  final _pedalBloc = PedalBloc();

  Pedal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _pedalBloc.state.stream,
      builder: (constex, snapshot) {
        double currXPos = _pedalBloc.state.pedalData.position.x;
        double currYPos = _pedalBloc.state.pedalData.position.y;
        double currWidth = _pedalBloc.state.pedalData.dimensions.width;
        double currHeight = _pedalBloc.state.pedalData.dimensions.height;

        final List<Knob> _knobs = [
          Knob(
            radius: 20,
            label: 'Bass',
            parentDimensions: Dimensions(width: 300, height: 400),
          ),
          Knob(
              radius: 20,
              label: 'Gain',
              parentDimensions: Dimensions(width: 300, height: 400)),
          Knob(
              radius: 20,
              label: 'Treble',
              parentDimensions: Dimensions(width: 300, height: 400))
        ];
        return Positioned(
          left: currXPos,
          top: currYPos,
          child: Column(
            children: [
              GestureDetector(
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber),
                  width: _pedalBloc.state.pedalData.dimensions.width,
                  height: _pedalBloc.state.pedalData.dimensions.height,
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: _knobs,
                  ),
                ),
              ),
              GestureDetector(
                onPanUpdate: (tapInfo) {
                  _pedalBloc.event.sink.add(
                    PedalEventType(
                      action: PedalAction.updateDimesnions,
                      payload: PedalPayload(
                        newDimensions: Dimensions(
                          width: currWidth + tapInfo.delta.dx,
                          height: currHeight + tapInfo.delta.dy,
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
