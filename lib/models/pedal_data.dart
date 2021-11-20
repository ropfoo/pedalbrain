import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

class PedalData {
  Position position = Position(x: 0, y: 0);
  Dimensions dimensions = Dimensions(width: 300, height: 300);
  List<Knob> knobs = [];
  String name = 'Pedal';
  bool isEditable = false;

  Map<String, dynamic> toJson() => {
        'name': name,
        'dimensions': {
          'width': dimensions.width,
          'height': dimensions.height,
        },
        'knobs': _knobsToJson()
      };

  List<Map<String, dynamic>> _knobsToJson() {
    List<Map<String, dynamic>> knobsData = [];
    for (var knob in knobs) {
      knobsData.add({
        'label': knob.label,
        'radius': knob.radius,
        'position': {
          'x': knob.initialKnobData.position?.x,
          'y': knob.initialKnobData.position?.y,
        },
      });
    }

    return knobsData;
  }

  PedalData({
    required this.dimensions,
    required this.knobs,
    required this.position,
    required this.name,
    required this.isEditable,
  });

  PedalData.createFromSnapshot(dynamic snapshotData, KnobOptions knobOptions) {
    var data = snapshotData as Map<String, dynamic>;
    var dataDimensions = data['dimensions'];
    num width = dataDimensions['width'];
    num height = dataDimensions['height'];
    var initDimensions = Dimensions(
      width: width.toDouble(),
      height: height.toDouble(),
    );

    List<Knob> getKnobs() {
      List<Knob> knobs = [];

      for (var knobData in data['knobs']) {
        String knobLabel = knobData['label'];
        num knobRadius = knobData['radius'];
        var knobPosition = knobData['position'];
        num x = knobPosition['x'];
        num y = knobPosition['y'];
        Position initKnobPosition = Position(
          x: x.toDouble(),
          y: y.toDouble(),
        );
        Knob newKnob = Knob(
          initialKnobData: KnobData(
            position: initKnobPosition,
            options: KnobOptions(),
          ),
          label: knobLabel,
          options: knobOptions,
          radius: knobRadius.toDouble(),
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
