import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/board/board.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Pedalbrain'),
          ),
          body: Board()),
    );
  }
}
