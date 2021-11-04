import 'package:pedalbrain/models/dimensions.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_event.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_state.dart';

class PedalBloc {
  final PedalData initPedalData;
  final state = PedalState();
  final event = PedalEvent();

  PedalBloc({required this.initPedalData}) {
    state.pedalData = initPedalData;

    event.stream.listen((event) {
      switch (event.action) {
        case PedalAction.upatePos:
          state.pedalData.position =
              event.payload?.newPos ?? Position(x: 0, y: 0);
          break;

        case PedalAction.updateDimesnions:
          state.pedalData.dimensions = event.payload?.newDimensions ??
              Dimensions(width: 200, height: 300);
          break;

        case PedalAction.setKnobs:
          state.pedalData.knobs = event.payload?.newKnobs ?? [];
          break;

        default:
      }
      state.sink.add(state.pedalData);
    });
  }
}
