import 'package:flutter/material.dart';
import 'package:pedalbrain/models/app_color.dart';
import 'package:pedalbrain/modules/colorpicker/color_picker.dart';

class ColorPickerModal {
  void show(
      {required BuildContext context,
      required Function update,
      required String activeColor}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            height: 380,
            color: AppColor.overlay,
            child: ColorPicker(
              activeColor: activeColor,
              updatePedalColor: (value) => update(value),
            ),
          ),
        );
      },
    );
  }
}
