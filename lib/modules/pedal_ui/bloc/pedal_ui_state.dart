import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

class PedalUIState {
  PedalData? pedalData;
  bool? showOverlay;
  Knob? activeSelection;

  PedalUIState({this.pedalData, this.showOverlay, this.activeSelection});
}
