import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';

class Board extends StatelessWidget {
  Board({Key? key}) : super(key: key);

  final TransformationController _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    _controller.value = Matrix4.identity();

    return InteractiveViewer(
      transformationController: _controller,
      minScale: .5,
      maxScale: 5,
      constrained: false,
      clipBehavior: Clip.none,
      child: Container(
        color: Colors.black,
        width: 1000,
        height: 2000,
        child: Stack(
            // children: [Pedal()],
            ),
      ),
    );
  }
}
