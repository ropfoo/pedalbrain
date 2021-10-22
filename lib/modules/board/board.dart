import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Stack(
        children: [Pedal(), Pedal()],
      ),
    );
  }
}
