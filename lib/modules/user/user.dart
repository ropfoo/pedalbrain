import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/pedal/pedal.dart';

class PedalUI extends StatefulWidget {
  const PedalUI({Key? key}) : super(key: key);

  @override
  _PedalUIState createState() => _PedalUIState();
}

class _PedalUIState extends State<PedalUI> {
  bool isEditMode = false;

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
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            var data = snapshot.data?.data() as Map<String, dynamic>;

            return Stack(
              children: [
                Pedal(
                  isEditable: isEditMode,
                  initPedalData: PedalData.createFromSnapshot(
                    data,
                    KnobOptions(
                      isEditable: false,
                      showLabel: false,
                    ),
                  ),
                ),
                Positioned(
                  width: 200,
                  height: 500,
                  child: TextButton(
                      onPressed: () => setState(() {
                            isEditMode = !isEditMode;
                          }),
                      child: const Text('test')),
                )
              ],
            );
          },
        );
      },
    );
  }
}
