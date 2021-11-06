import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference pedals = FirebaseFirestore.instance
      .collection('users')
      .doc('So6Y0xYBudc4jDDEjGNM')
      .collection('pedals');

  Future<List<dynamic>> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await pedals.get();

    // Get data from docs and convert map to List
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  List<PedalListItem> getPedalListItems(List<dynamic> list) {
    List<PedalListItem> pedalListItems = [];
    for (var item in list) {
      var pedalData = PedalData.createFromSnapshot(item);
      var resizeFactor = 2.8;
      pedalData.dimensions = Dimensions(
          width: pedalData.dimensions.width / resizeFactor,
          height: pedalData.dimensions.height / resizeFactor);
      pedalData.position = Position(x: 0, y: 20);
      pedalListItems.add(PedalListItem(
        pedalData: pedalData,
      ));
    }
    return pedalListItems;
  }

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
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: getPedalListItems(snapshot.data),
                  );
                }

                return const Text('loading');
              },
            ),
          )
        ],
      ),
    );
  }
}

class PedalListItem extends StatelessWidget {
  final PedalData pedalData;

  const PedalListItem({Key? key, required this.pedalData}) : super(key: key);

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
            child: Text(
              pedalData.name,
              style: const TextStyle(
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
                initPedalData: pedalData,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
