import 'package:pedalbrain/models/color_field_data.dart';
import 'package:pedalbrain/modules/colorpicker/bloc/color_picker_state.dart';
import 'package:rxdart/subjects.dart';

class ColorPickerBloc {
  ColorPickerState state = ColorPickerState(
    colorFields: ColorFieldCreator.create("orange"),
  );
  final BehaviorSubject<ColorPickerState> _subjectColorPicker =
      BehaviorSubject.seeded(
    ColorPickerState(
      colorFields: ColorFieldCreator.create("orange"),
    ),
  );

  Stream<ColorPickerState> get stream => _subjectColorPicker.stream;
  ColorPickerState get current => _subjectColorPicker.value;

  ColorPickerBloc(String activeColor) {
    state =
        ColorPickerState(colorFields: ColorFieldCreator.create(activeColor));
    _subjectColorPicker.add(
        ColorPickerState(colorFields: ColorFieldCreator.create(activeColor)));
  }

  void selectColor(String name) {
    List<ColorFieldData> newColorFields = ColorFieldCreator.create(name);
    state = ColorPickerState(colorFields: newColorFields);
    _subjectColorPicker.add(ColorPickerState(colorFields: newColorFields));
  }
}

class ColorFieldCreator {
  static final List<String> colors = ["orange", "green"];
  static List<ColorFieldData> create(String activeColor) {
    List<ColorFieldData> colorFields = [];
    for (var color in colors) {
      colorFields
          .add(ColorFieldData(name: color, isActive: color == activeColor));
    }
    return colorFields;
  }
}
