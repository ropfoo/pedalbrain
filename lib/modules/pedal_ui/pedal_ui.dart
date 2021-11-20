import 'package:flutter/material.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';
import 'package:pedalbrain/modules/pedal_ui/bloc/pedal_ui_bloc.dart';
import 'package:pedalbrain/modules/pedal_ui/knob_selection_menu.dart';
import 'package:pedalbrain/modules/pedal_ui/knob_selection.dart';

class PedalUI extends StatelessWidget {
  final PedalData initPedalData;
  late PedalUIBloc _pedalUIBloc;
  final Function onLeave;

  PedalUI({
    Key? key,
    required this.initPedalData,
    required this.onLeave,
  }) : super(key: key);

  Future<bool> _navigateBack(BuildContext context) async {
    print('sdsd');
    Navigator.of(context).pop(true);
    _pedalUIBloc.updatePedalData();
    onLeave();
    return false;
  }

  List<KnobSelection> getKnobOptions(List<Knob> knobs) {
    List<KnobSelection> knobOptions = [];
    for (var knob in knobs) {
      knobOptions.add(
        KnobSelection(
          knob: knob,
          onPress: () {
            _pedalUIBloc.setOverlay(true);
            _pedalUIBloc.selectOption(knob);
          },
        ),
      );
    }
    return knobOptions;
  }

  @override
  Widget build(BuildContext context) {
    _pedalUIBloc = PedalUIBloc(initPedalData);
    return WillPopScope(
      onWillPop: () => _navigateBack(context),
      child: StreamBuilder<Object>(
        stream: _pedalUIBloc.stream,
        builder: (context, snapshot) {
          if (_pedalUIBloc.state.pedalData != null) {
            return Column(
              children: [
                Container(
                  width: 500,
                  height: 500,
                  color: const Color(0xFF0B0B0B),
                  child: Hero(
                    tag: 1,
                    child: Stack(
                      children: [
                        Pedal(
                          initPedalData: _pedalUIBloc.state.pedalData!,
                          scale: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xff383838),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 30,
                                    left: 20,
                                    right: 0,
                                  ),
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
                                children: getKnobOptions(
                                    _pedalUIBloc.state.pedalData!.knobs),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        child: KnobSelectionMenu(
                          isVisible: _pedalUIBloc.state.showOverlay ?? false,
                          selection: _pedalUIBloc.state.activeSelection,
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
      ),
    );
  }
}
