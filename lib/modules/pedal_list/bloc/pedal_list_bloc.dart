import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedalbrain/modules/pedal_list/bloc/pedal_list_state.dart';
import 'package:rxdart/rxdart.dart';

class PedalListBloc {
  PedalListState state = PedalListState(listData: []);
  final BehaviorSubject<PedalListState> _subjectPedalList =
      BehaviorSubject<PedalListState>.seeded(PedalListState(listData: []));

  PedalListBloc() {
    getData();
  }

  Stream<PedalListState> get stream => _subjectPedalList.stream;
  PedalListState get current => _subjectPedalList.value;

  void getData() async {
    final CollectionReference pedals = FirebaseFirestore.instance
        .collection('users')
        .doc('So6Y0xYBudc4jDDEjGNM')
        .collection('pedals');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await pedals.get();

    var list = [];
    for (var doc in querySnapshot.docs) {
      dynamic docData = doc.data();
      var listItem = {
        "id": doc.id,
        ...docData,
      };
      list.add(listItem);
    }

    // Get data from docs and convert map to List
    var pedalListState = PedalListState(listData: list);
    state = pedalListState;
    _subjectPedalList.add(pedalListState);
  }

  void dispose() {
    _subjectPedalList.close();
  }
}
