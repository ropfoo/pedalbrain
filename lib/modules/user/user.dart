import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';

class User extends StatelessWidget {
  CollectionReference pedals = FirebaseFirestore.instance
      .collection('users')
      .doc('So6Y0xYBudc4jDDEjGNM')
      .collection('pedals');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return FutureBuilder<dynamic>(
            future: pedals.doc('f4fkYjHnvVStEnMEllQ4').get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              var data = snapshot.data?.data() as Map<String, dynamic>;

              return Stack(
                children: [
                  Pedal(
                    initPedalData: PedalData.createFromSnapshot(data),
                  )
                ],
              );
            },
          );
        });
  }
}

class QuerySnapshot {}
