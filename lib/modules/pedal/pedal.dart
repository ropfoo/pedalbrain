import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_bloc.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_event.dart';
import 'package:pedalbrain/widgets/circle_button.dart';

class Pedal extends StatelessWidget {
  final PedalData initPedalData;
  final bool isEditable;

  Pedal({Key? key, required this.initPedalData, this.isEditable = false})
      : super(key: key);

  final Widget resizeSVG = SvgPicture.asset(
    'assets/icons/resize.svg',
    semanticsLabel: 'Acme Logo',
    color: Colors.white,
    width: 25,
    height: 25,
  );

  @override
  Widget build(BuildContext context) {
    final _pedalBloc = PedalBloc(initPedalData: initPedalData);

    return StreamBuilder(
      stream: _pedalBloc.state.stream,
      builder: (constex, snapshot) {
        double currXPos = _pedalBloc.state.pedalData.position.x;
        double currYPos = _pedalBloc.state.pedalData.position.y;
        double currWidth = _pedalBloc.state.pedalData.dimensions.width;
        double currHeight = _pedalBloc.state.pedalData.dimensions.height;

        return Positioned(
          left: currXPos,
          top: currYPos,
          child: Column(
            children: [
              GestureDetector(
                onPanUpdate: (tapInfo) {
                  if (isEditable) {
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
                  }
                },
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber),
                        width: _pedalBloc.state.pedalData.dimensions.width,
                        height:
                            _pedalBloc.state.pedalData.dimensions.height + 40,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amberAccent),
                        width: _pedalBloc.state.pedalData.dimensions.width,
                        height: _pedalBloc.state.pedalData.dimensions.height,
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          children: _pedalBloc.state.pedalData.knobs,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                width: _pedalBloc.state.pedalData.dimensions.width + 100,
                child: isEditable
                    ? GestureDetector(
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

                          for (var knob in _pedalBloc.state.pedalData.knobs) {
                            if (_pedalBloc.state.pedalData.dimensions.height <
                                (knob.getPosition().y +
                                    knob.getDimensions().height)) {
                              knob.updatePosition(
                                Position(
                                  x: knob.getPosition().x,
                                  y: currHeight +
                                      tapInfo.delta.dy -
                                      knob.getDimensions().height,
                                ),
                              );
                            }

                            if (_pedalBloc.state.pedalData.dimensions.width <
                                (knob.getPosition().x +
                                    knob.getDimensions().width)) {
                              knob.updatePosition(
                                Position(
                                  x: currWidth +
                                      tapInfo.delta.dx -
                                      knob.getDimensions().width,
                                  y: knob.getPosition().y,
                                ),
                              );
                            }
                          }
                        },
                        child: CircleButton(
                          icon: resizeSVG,
                        ),
                      )
                    : Container(),
              )
            ],
          ),
        );
      },
    );
  }
}
