import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/board/board.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Pedalbrain'),
          ),
          body: Board()),
    );
  }
}
