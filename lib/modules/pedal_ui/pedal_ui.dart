import 'package:flutter/material.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';
import 'package:pedalbrain/modules/pedal_ui/bloc/pedal_ui_bloc.dart';
import 'package:pedalbrain/modules/pedal_ui/knob_selection_menu.dart';
import 'package:pedalbrain/modules/pedal_ui/knob_selection.dart';
import 'package:pedalbrain/widgets/name_change_modal.dart';

class PedalUI extends StatelessWidget {
  final PedalData initPedalData;
  late PedalUIBloc _pedalUIBloc;
  final Function onLeave;
  final NameChangeModal nameChangeModal = NameChangeModal();

  PedalUI({
    Key? key,
    required this.initPedalData,
    required this.onLeave,
  }) : super(key: key);

  Future<bool> _navigateBack(BuildContext context) async {
    Navigator.of(context).pop(true);
    onLeave(
      _pedalUIBloc.updatePedalData,
      _pedalUIBloc.addPedalData,
    );
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

  void _onSelectedMain(
      dynamic choice, BuildContext context, PedalUIBloc pedalUIBloc) {
    switch (choice) {
      case "rename":
        return nameChangeModal.show(
            context: context,
            initialName: pedalUIBloc.state.pedalData!.name,
            onChanged: (value) => pedalUIBloc.renamePedal(value));
      case "addKnob":
        return _pedalUIBloc.addKnob();
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    _pedalUIBloc = PedalUIBloc(initPedalData);
    initPedalData.position = Position(x: 50, y: 50);
    return WillPopScope(
      onWillPop: () => _navigateBack(context),
      child: StreamBuilder(
        stream: _pedalUIBloc.stream,
        builder: (context, snapshot) {
          if (_pedalUIBloc.state.pedalData != null) {
            return Column(
              children: [
                Container(
                  width: 500,
                  height: 500,
                  color: const Color(0xFF040013),
                  child: Stack(
                    children: [
                      Pedal(
                        initPedalData: _pedalUIBloc.state.pedalData!,
                        scale: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xff97A1FF),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                PopupMenuButton(
                                  onSelected: (choice) => _onSelectedMain(
                                      choice, context, _pedalUIBloc),
                                  color: const Color(0xff615EFF),
                                  itemBuilder: (ctx) => [
                                    const PopupMenuItem(
                                      value: "rename",
                                      child: Text(
                                        'Rename',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: "color",
                                      child: Text(
                                        'Color',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: "addKnob",
                                      child: Text(
                                        'Add Knob',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                )
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
