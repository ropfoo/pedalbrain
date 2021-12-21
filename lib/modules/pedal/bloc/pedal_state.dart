import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';

class PedalState {
  PedalData pedalData = PedalData(
    dimensions: Dimensions(height: 300, width: 500),
    knobs: [],
    position: Position(x: 0, y: 0),
    name: 'Pedal',
    isEditable: false,
    isListPreview: false,
    color: "orange",
  );
}
