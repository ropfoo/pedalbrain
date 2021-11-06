import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/knob_data.dart';
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

  PedalData.createFromSnapshot(dynamic snapshotData, KnobOptions knobOptions) {
    var data = snapshotData as Map<String, dynamic>;
    var dataDimensions = data['dimensions'];
    int width = dataDimensions['width'];
    int height = dataDimensions['height'];
    var initDimensions = Dimensions(
      width: width.toDouble(),
      height: height.toDouble(),
    );

    List<Knob> getKnobs() {
      List<Knob> knobs = [];

      for (var knobData in data['knobs']) {
        String knobLabel = knobData['label'];
        int knobRadius = knobData['radius'];
        var knobPosition = knobData['position'];
        int x = knobPosition['x'];
        int y = knobPosition['y'];
        Position initKnobPosition = Position(
          x: x.toDouble() * knobOptions.resizeFactor,
          y: y.toDouble() * knobOptions.resizeFactor,
        );
        Knob newKnob = Knob(
          initialKnobData: KnobData(
            position: initKnobPosition,
          ),
          label: knobLabel,
          options: knobOptions,
          radius: knobRadius.toDouble() * knobOptions.resizeFactor,
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
