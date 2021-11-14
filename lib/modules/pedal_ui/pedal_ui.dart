import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';
import 'package:pedalbrain/modules/pedal_ui/bloc/pedal_ui_bloc.dart';
import 'package:pedalbrain/modules/pedal_ui/pedal_ui_knob_selection.dart';
import 'package:pedalbrain/widgets/arrow_button.dart';

class PedalUI extends StatelessWidget {
  PedalUI({Key? key}) : super(key: key);

  final PedalUIBloc _pedalUIBloc = PedalUIBloc();

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
    );
  }
}

class KnobSelectionMenu extends StatefulWidget {
  final bool isVisible;
  final Knob? selection;

  const KnobSelectionMenu({
    Key? key,
    required this.isVisible,
    required this.selection,
  }) : super(key: key);

  @override
  State<KnobSelectionMenu> createState() => _KnobSelectionMenuState();
}

class _KnobSelectionMenuState extends State<KnobSelectionMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVisible) {
      _controller.forward();
    }

    return SlideTransition(
      position: _offsetAnimation,
      child: widget.selection != null
          ? Container(
              width: 500,
              height: 250,
              color: const Color(0xff000913),
              child: Column(
                children: [
                  Row(
                    children: [
                      ArrowButton(
                        onPressed: () {
                          _controller.reverse();
                          widget.selection!.toggleEditMode();
                        },
                      ),
                      Text(
                        widget.selection!.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
