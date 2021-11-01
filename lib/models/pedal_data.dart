import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

class PedalData {
  Position position = Position(x: 0, y: 0);
  Dimensions dimensions = Dimensions(width: 200, height: 400);
  List<Knob> knobs = [
    Knob(
      radius: 20,
      label: 'Bass',
    ),
    Knob(
      radius: 20,
      label: 'Gain',
    ),
    Knob(
      radius: 20,
      label: 'Treble',
    )
  ];
}
