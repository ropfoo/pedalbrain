import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';
import 'package:pedalbrain/modules/pedal_ui/bloc/pedal_ui_bloc.dart';

class PedalUI extends StatelessWidget {
  PedalUI({Key? key}) : super(key: key);

  final PedalUIBloc _pedalUIBloc = PedalUIBloc();

  List<KnobSelection> getKnobOptions(List<Knob> knobs) {
    List<KnobSelection> knobOptions = [];
    for (var knob in knobs) {
      knobOptions.add(KnobSelection(knob: knob));
    }
    return knobOptions;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _pedalUIBloc.stream,
      builder: (context, snapshot) {
        if (_pedalUIBloc.state.pedalData != null) {
          return Column(
            children: [
              Container(
                width: 500,
                height: 500,
                color: const Color(0xFF0B0B0B),
                child: Stack(
                  children: [
                    Pedal(
                      initPedalData: _pedalUIBloc.state.pedalData!,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 0,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            _pedalUIBloc.state.pedalData!.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        children: [
                          ...getKnobOptions(
                              _pedalUIBloc.state.pedalData!.knobs),
                          ...getKnobOptions(
                              _pedalUIBloc.state.pedalData!.knobs),
                          ...getKnobOptions(
                              _pedalUIBloc.state.pedalData!.knobs),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
        return const Text('no data');
      },
    );
  }
}

class KnobSelection extends StatelessWidget {
  final Knob knob;

  KnobSelection({Key? key, required this.knob}) : super(key: key);

  final Widget knobSVG = SvgPicture.asset(
    'assets/icons/knob.svg',
    semanticsLabel: 'Acme Logo',
    width: 35,
    height: 35,
  );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => knob.toggleEditMode(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 25,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            bottomLeft: Radius.circular(35),
          ),
          color: Color(0xFF161616),
        ),
        child: Row(
          children: [
            knobSVG,
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                knob.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
