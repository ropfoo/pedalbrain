import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArrowButton extends StatelessWidget {
  final Function onPressed;

  ArrowButton({Key? key, required this.onPressed}) : super(key: key);
  final Widget arrowSVG = SvgPicture.asset(
    'assets/icons/arrow.svg',
    semanticsLabel: 'arrow',
    width: 18,
    height: 18,
  );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color(0xff97A1FF),
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: arrowSVG,
      ),
    );
  }
}
