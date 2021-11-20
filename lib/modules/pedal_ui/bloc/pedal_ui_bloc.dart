import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/pedal_ui/bloc/pedal_ui_state.dart';
import 'package:rxdart/rxdart.dart';

class PedalUIBloc {
  PedalUIState state = PedalUIState();
  final BehaviorSubject<PedalUIState> _subjectPedalUI =
      BehaviorSubject<PedalUIState>.seeded(PedalUIState());

  PedalUIBloc(PedalData initPedalData) {
    state.pedalData = initPedalData;
  }

  Stream<PedalUIState> get stream => _subjectPedalUI.stream;
  PedalUIState get current => _subjectPedalUI.value;

  void initPedalData() async {
    final CollectionReference pedals = FirebaseFirestore.instance
        .collection('users')
        .doc('So6Y0xYBudc4jDDEjGNM')
        .collection('pedals');

    final initPedalDataSnapshot =
        await pedals.doc('f4fkYjHnvVStEnMEllQ4').get();

    var data = initPedalDataSnapshot.data() as Map<String, dynamic>;

    var pedalData = PedalData.createFromSnapshot(
      data,
      KnobOptions(
        isEditable: false,
        showLabel: true,
      ),
    );

    state = PedalUIState(pedalData: pedalData);
    _subjectPedalUI.add(PedalUIState(pedalData: pedalData));
  }

  void setOverlay(bool showOverlay) {
    state.showOverlay = showOverlay;
    _subjectPedalUI.add(PedalUIState());
  }

  void selectOption(selection) {
    state.activeSelection = selection;
    _subjectPedalUI.add(PedalUIState());
  }

  void dispose() {
    _subjectPedalUI.close();
  }
}
