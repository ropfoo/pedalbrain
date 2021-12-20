import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/colorpicker/bloc/color_picker_bloc.dart';
import 'package:pedalbrain/modules/colorpicker/color_field.dart';

class ColorPicker extends StatelessWidget {
  late final ColorPickerBloc _colorPickerBloc;
  final Function updatePedalColor;
  final String activeColor;

  ColorPicker(
      {Key? key, required this.updatePedalColor, required this.activeColor})
      : super(key: key) {
    _colorPickerBloc = ColorPickerBloc(activeColor);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _colorPickerBloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return ColorField(
                  colorFieldData: _colorPickerBloc.state.colorFields[index],
                  onPressed: () {
                    _colorPickerBloc.selectColor(
                        _colorPickerBloc.state.colorFields[index].name);
                    updatePedalColor(
                        _colorPickerBloc.state.colorFields[index].name);
                  },
                );
              },
            );
          }
          return const Text("loading");
        });
  }
}
