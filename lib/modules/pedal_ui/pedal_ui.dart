import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';
import 'package:pedalbrain/modules/pedal_ui/bloc/pedal_ui_bloc.dart';

class PedalUI extends StatelessWidget {
  PedalUI({Key? key}) : super(key: key);

  final PedalUIBloc _pedalUIBloc = PedalUIBloc();

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
                  color: Colors.red,
                  child: Text(_pedalUIBloc.state.pedalData!.name),
                )
              ],
            );
          }
          return const Text('no data');
        });
  }
}
