import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pedalbrain/modules/knob/knob.dart';

class KnobSelection extends StatelessWidget {
  final Knob knob;
  final Function onPress;
  KnobSelection({
    Key? key,
    required this.knob,
    required this.onPress,
  }) : super(key: key);

  final Widget knobSVG = SvgPicture.asset(
    'assets/icons/knob.svg',
    semanticsLabel: 'Acme Logo',
    width: 35,
    height: 35,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(bottom: 15),
          ),
          onPressed: () {
            onPress();
            knob.toggleEditMode();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 25,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35),
              ),
              color: Color(0xFF000913),
            ),
            child: Row(
              children: [
                knobSVG,
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    knob.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
