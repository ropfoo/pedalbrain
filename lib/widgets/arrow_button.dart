import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArrowButton extends StatelessWidget {
  final Function onPressed;

  ArrowButton({Key? key, required this.onPressed}) : super(key: key);
  final Widget arrowSVG = SvgPicture.asset(
    'assets/icons/arrow.svg',
    semanticsLabel: 'Acme Logo',
    width: 20,
    height: 20,
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
            color: const Color(0xff353535),
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: arrowSVG,
      ),
    );
  }
}
