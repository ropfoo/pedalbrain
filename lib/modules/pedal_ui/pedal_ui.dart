import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';

class PedalUI extends StatelessWidget {
  final CollectionReference pedals = FirebaseFirestore.instance
      .collection('users')
      .doc('So6Y0xYBudc4jDDEjGNM')
      .collection('pedals');

  PedalUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 500,
          height: 500,
          color: const Color(0xFF0B0B0B),
          child: FutureBuilder<dynamic>(
            future: pedals.doc('f4fkYjHnvVStEnMEllQ4').get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              var data = snapshot.data?.data() as Map<String, dynamic>;
              return Stack(
                children: [
                  Pedal(
                    initPedalData: PedalData.createFromSnapshot(
                      data,
                      KnobOptions(
                        isEditable: false,
                        showLabel: true,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          color: Colors.red,
          child: const Text('Pedal'),
        )
      ],
    );
  }
}
