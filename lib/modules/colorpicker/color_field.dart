import 'package:flutter/material.dart';
import 'package:pedalbrain/models/color_field_data.dart';
import 'package:pedalbrain/models/color_group.dart';

class ColorField extends StatelessWidget {
  final Function onPressed;
  final ColorFieldData colorFieldData;

  const ColorField(
      {Key? key, required this.colorFieldData, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorGroup.getColor(colorFieldData.name).primary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorFieldData.isActive ? Colors.white : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }
}
