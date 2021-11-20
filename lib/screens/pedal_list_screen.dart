import 'package:flutter/material.dart';

import 'package:pedalbrain/modules/pedal_list/pedal_list.dart';

class PedalListScreen extends StatelessWidget {
  const PedalListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040013),
      body: PedalList(),
    );
  }
}
