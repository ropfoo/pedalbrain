import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

class PedalData {
  String? id;
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
        'radius': knob.knobData.options.radius,
        'position': {
          'x': knob.knobData.position?.x,
          'y': knob.knobData.position?.y,
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

  PedalData.createDefault() {
    dimensions = Dimensions(width: 200, height: 300);
    knobs = [
      Knob(
        label: "Gain",
        knobData: KnobData(
          options: KnobOptions(),
        ),
      )
    ];
    position = Position(x: 0, y: 0);
    name = "New Pedal";
  }

  PedalData.createFromSnapshot(dynamic snapshotData, KnobOptions knobOptions) {
    var data = snapshotData as Map<dynamic, dynamic>;
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
          knobData: KnobData(
            position: initKnobPosition,
            options: KnobOptions(radius: knobRadius.toDouble()),
          ),
          label: knobLabel,
        );
        knobs.add(newKnob);
      }

      return knobs;
    }

    id = data['id'];
    name = data['name'];
    dimensions = initDimensions;
    knobs = getKnobs();
  }
}
