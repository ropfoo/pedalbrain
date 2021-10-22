import 'package:pedalbrain/models/position.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_event.dart';
import 'package:pedalbrain/modules/pedal/bloc/pedal_state.dart';

class PedalBloc {
  final state = PedalState();
  final event = PedalEvent();

  PedalBloc() {
    event.stream.listen((event) {
      switch (event.action) {
        case PedalAction.upatePos:
          state.pedalData.position =
              event.payload?.newPos ?? Position(x: 0, y: 0);
          break;
        default:
      }
      state.sink.add(state.pedalData);
    });
  }
}
