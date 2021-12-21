import 'package:flutter/material.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';
import 'package:pedalbrain/screens/pedal_ui_screen.dart';

class PedalListItem extends StatelessWidget {
  final PedalData pedalData;
  final Function onLeave;

  const PedalListItem({
    Key? key,
    required this.pedalData,
    required this.onLeave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pedalData.position = Position(x: 0, y: 0);
    pedalData.isListPreview = true;
    return Container(
      height: 145,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          pedalData.isListPreview = false;
          pedalData.position = Position(x: 100, y: 50);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PedalUIScreen(
                pedalData: pedalData,
                onLeave: onLeave,
              ),
            ),
          );
        },
        child: Stack(children: [
          Positioned(
            height: 120,
            width: MediaQuery.of(context).size.width + 10,
            child: PedalListItemGradient(
              pedalData: pedalData,
            ),
          ),
          Pedal(
            initPedalData: pedalData,
            scale: .35,
          ),
        ]),
      ),
    );
  }
}

class PedalListItemGradient extends StatelessWidget {
  final PedalData pedalData;

  const PedalListItemGradient({Key? key, required this.pedalData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(1, 0.0),
          colors: <Color>[
            Colors.transparent,
            pedalData.color.tertiary,
          ],
          tileMode: TileMode.repeated,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        pedalData.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
          color: Colors.white,
        ),
      ),
    );
  }
}
