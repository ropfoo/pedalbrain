import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/pedal_list/pedal_list_item.dart';

class PedalList extends StatelessWidget {
  PedalList({Key? key}) : super(key: key);

  final CollectionReference pedals = FirebaseFirestore.instance
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
      var pedalData = PedalData.createFromSnapshot(
        item,
        KnobOptions(
          isEditable: false,
          showLabel: false,
        ),
      );
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
