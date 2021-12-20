import 'package:pedalbrain/models/color_field_data.dart';
import 'package:pedalbrain/modules/colorpicker/bloc/color_picker_state.dart';
import 'package:rxdart/subjects.dart';

class ColorPickerBloc {
  ColorPickerState state = ColorPickerState(colorFields: const [
    ColorFieldData(name: "orange", isActive: true),
    ColorFieldData(name: "green", isActive: false)
  ]);
  final BehaviorSubject<ColorPickerState> _subjectColorPicker =
      BehaviorSubject.seeded(ColorPickerState(colorFields: const [
    ColorFieldData(name: "orange", isActive: true),
    ColorFieldData(name: "green", isActive: false)
  ]));

  Stream<ColorPickerState> get stream => _subjectColorPicker.stream;
  ColorPickerState get current => _subjectColorPicker.value;

  void selectColor(String name) {
    List<ColorFieldData> newColorFields = [];
    for (ColorFieldData color in state.colorFields) {
      newColorFields.add(
        ColorFieldData(name: color.name, isActive: color.name == name),
      );
    }
    state = ColorPickerState(colorFields: newColorFields);
    _subjectColorPicker.add(ColorPickerState(colorFields: newColorFields));
  }
}
