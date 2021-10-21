import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

class Pedal extends StatelessWidget {
  final List<Knob> _knobs = [
    Knob(radius: 40, label: 'Bass'),
    Knob(radius: 40, label: 'Gain'),
    Knob(radius: 40, label: 'Treble')
  ];

  Pedal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _knobs,
    );
  }
}
