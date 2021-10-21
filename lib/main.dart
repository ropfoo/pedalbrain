import 'package:flutter/material.dart';

import 'modules/pedal/pedal.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Drag And drop Plugin'),
          ),
          body: Pedal()),
    );
  }
}
