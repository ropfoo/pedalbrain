import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_state.dart';
import 'package:rxdart/subjects.dart';

class PedalBloc {
  final PedalData initPedalData;
  var state = PedalState();
  final _subjectPedal = BehaviorSubject<PedalState>.seeded(PedalState());

  Stream<PedalState> get stream => _subjectPedal.stream;
  PedalState get current => _subjectPedal.value;

  PedalBloc({required this.initPedalData}) {
    state.pedalData = initPedalData;
    _subjectPedal.add(state);
  }

  void updatePos(Position newPos) {
    state.pedalData.position = newPos;
    _subjectPedal.add(state);
  }

  void updateDimensions(Dimensions newDimensions) {
    state.pedalData.dimensions = newDimensions;
    _subjectPedal.add(state);
  }

  void setKnobs(List<Knob> newKnobs) {
    state.pedalData.knobs = newKnobs;
    _subjectPedal.add(state);
  }

  void toggleEditable() {
    state.pedalData.isEditable = !state.pedalData.isEditable;
    _subjectPedal.add(state);
  }
}
