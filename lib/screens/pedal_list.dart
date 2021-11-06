import 'package:flutter/material.dart';
import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';

class PedalList extends StatefulWidget {
  const PedalList({Key? key}) : super(key: key);

  @override
  _PedalListState createState() => _PedalListState();
}

class _PedalListState extends State<PedalList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            alignment: Alignment.topLeft,
            child: const Text(
              'Pedals',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
            ),
          ),
          SizedBox(
            height: 600,
            child: ListView(
              children: const [
                PedalListItem(),
                PedalListItem(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PedalListItem extends StatelessWidget {
  const PedalListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(children: [
        Positioned(
          height: 120,
          width: 500,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.0),
                colors: <Color>[Colors.transparent, Colors.amber],
                tileMode: TileMode.repeated,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: const Text(
              'This is a Pedal',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          width: 160,
          height: 140,
          right: 0,
          child: Stack(
            children: [
              Pedal(
                initPedalData: PedalData(
                  dimensions: Dimensions(height: 70, width: 80),
                  position: Position(x: 0, y: 30),
                  knobs: [],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
