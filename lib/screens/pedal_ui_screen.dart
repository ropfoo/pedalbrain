import 'package:flutter/material.dart';
import 'package:pedalbrain/models/pedal_data.dart';

import 'package:pedalbrain/modules/pedal_ui/pedal_ui.dart';

class PedalUIScreen extends StatelessWidget {
  final PedalData pedalData;
  const PedalUIScreen({
    Key? key,
    required this.pedalData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PedalUI(
        initPedalData: pedalData,
      ),
    );
  }
}
