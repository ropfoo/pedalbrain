import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

class PedalData {
  Position position = Position(x: 0, y: 0);
  Dimensions dimensions = Dimensions(width: 300, height: 300);
  List<Knob> knobs = [];
  String name = 'Pedal';

  PedalData({
    required this.dimensions,
    required this.knobs,
    required this.position,
    required this.name,
  });

  PedalData.createFromSnapshot(dynamic snapshotData) {
    var data = snapshotData as Map<String, dynamic>;
    var dataDimensions = data['dimensions'];
    int width = dataDimensions['width'];
    int height = dataDimensions['height'];
    var initDimensions =
        Dimensions(width: width.toDouble(), height: height.toDouble());

    List<Knob> getKnobs() {
      List<Knob> knobs = [];

      for (var knobData in data['knobs']) {
        String knobLabel = knobData['label'];
        int knobRadius = knobData['radius'];
        Knob newKnob = Knob(
          radius: knobRadius.toDouble() / 2,
          label: knobLabel,
          showLabel: false,
        );
        knobs.add(newKnob);
      }

      return knobs;
    }

    name = data['name'];
    dimensions = initDimensions;
    knobs = getKnobs();
  }
}
