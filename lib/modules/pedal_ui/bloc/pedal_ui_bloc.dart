import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedalbrain/models/color_group.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
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

  void updatePedalData() async {
    final CollectionReference pedals = FirebaseFirestore.instance
        .collection('users')
        .doc('So6Y0xYBudc4jDDEjGNM')
        .collection('pedals');

    final pedalDataDoc = pedals.doc(state.pedalData?.id);

    var data = state.pedalData?.toJson();

    print(data);

    if (data != null) pedalDataDoc.update(data);
  }

  void addPedalData() async {
    final CollectionReference pedals = FirebaseFirestore.instance
        .collection('users')
        .doc('So6Y0xYBudc4jDDEjGNM')
        .collection('pedals');

    var data = state.pedalData?.toJson();

    pedals.add(data);
  }

  void setOverlay(bool showOverlay) {
    state.showOverlay = showOverlay;
    _subjectPedalUI.add(PedalUIState());
  }

  void selectOption(selection) {
    state.activeSelection = selection;
    _subjectPedalUI.add(PedalUIState());
  }

  void renamePedal(String newName) {
    state.pedalData!.name = newName;
    _subjectPedalUI.add(PedalUIState());
  }

  void setPedalColor(String colorName) {
    state.pedalData!.color = ColorGroup.getColor(colorName);
    _subjectPedalUI.add(PedalUIState());
  }

  void addKnob() {
    state.pedalData!.knobs = [
      ...state.pedalData!.knobs,
      Knob(
        knobData: KnobData(
          label: "Gain",
          options: KnobOptions(),
        ),
      ),
    ];
    _subjectPedalUI.add(PedalUIState());
  }

  void dispose() {
    _subjectPedalUI.close();
  }
}
