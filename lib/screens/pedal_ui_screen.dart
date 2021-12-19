import 'package:flutter/material.dart';
import 'package:pedalbrain/models/app_color.dart';
import 'package:pedalbrain/models/pedal_data.dart';

import 'package:pedalbrain/modules/pedal_ui/pedal_ui.dart';

class PedalUIScreen extends StatelessWidget {
  final PedalData pedalData;
  final Function onLeave;
  const PedalUIScreen({
    Key? key,
    required this.pedalData,
    required this.onLeave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
      ),
      backgroundColor: Colors.black87,
      body: PedalUI(
        initPedalData: pedalData,
        onLeave: onLeave,
      ),
    );
  }
}
