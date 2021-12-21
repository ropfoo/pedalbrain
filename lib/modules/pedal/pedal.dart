import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_bloc.dart';
import 'package:pedalbrain/widgets/circle_button.dart';

class Pedal extends StatelessWidget {
  final PedalData initPedalData;
  final double scale;

  Pedal({Key? key, required this.initPedalData, required this.scale})
      : super(key: key);

  final Widget resizeSVG = SvgPicture.asset(
    'assets/icons/resize.svg',
    semanticsLabel: 'reseize icon',
    color: Colors.white,
    width: 25,
    height: 25,
  );

  @override
  Widget build(BuildContext context) {
    final _pedalBloc = PedalBloc(initPedalData: initPedalData);

    return StreamBuilder(
      stream: _pedalBloc.stream,
      builder: (constex, snapshot) {
        double currXPos = _pedalBloc.state.pedalData.position.x;
        double currYPos = _pedalBloc.state.pedalData.position.y;
        double currWidth = _pedalBloc.state.pedalData.dimensions.width;
        double currHeight = _pedalBloc.state.pedalData.dimensions.height;
        bool isListPreview = _pedalBloc.state.pedalData.isListPreview;

        return Positioned(
          left: isListPreview ? null : currXPos,
          top: currYPos,
          right: isListPreview ? 10 : null,
          child: Transform.scale(
            alignment: isListPreview ? Alignment.topRight : null,
            origin: isListPreview ? const Offset(0, 20) : null,
            scale: scale,
            child: Column(
              children: [
                GestureDetector(
                  onPanUpdate: (tapInfo) {
                    if (_pedalBloc.state.pedalData.isEditable) {
                      _pedalBloc.updatePos(
                        Position(
                          x: currXPos + tapInfo.delta.dx,
                          y: currYPos + tapInfo.delta.dy,
                        ),
                      );
                    }
                  },
                  onTap: () => _pedalBloc.toggleEditable(),
                  child: Stack(
                    children: [
                      if (_pedalBloc.state.pedalData.isEditable)
                        Positioned(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            width: _pedalBloc.state.pedalData.dimensions.width +
                                10,
                            height:
                                _pedalBloc.state.pedalData.dimensions.height +
                                    0.13 *
                                        _pedalBloc
                                            .state.pedalData.dimensions.height +
                                    10,
                          ),
                        ),
                      Positioned(
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _pedalBloc.state.pedalData.color.secondary,
                          ),
                          width: _pedalBloc.state.pedalData.dimensions.width,
                          height: _pedalBloc.state.pedalData.dimensions.height +
                              0.13 *
                                  _pedalBloc.state.pedalData.dimensions.height,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _pedalBloc.state.pedalData.color.primary,
                          ),
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
                  child: _pedalBloc.state.pedalData.isEditable
                      ? GestureDetector(
                          onPanUpdate: (tapInfo) {
                            _pedalBloc.updateDimensions(
                              Dimensions(
                                width: currWidth + tapInfo.delta.dx,
                                height: currHeight + tapInfo.delta.dy,
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
          ),
        );
      },
    );
  }
}
