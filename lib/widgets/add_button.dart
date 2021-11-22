import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddButton extends StatelessWidget {
  final Widget plusSVG = SvgPicture.asset(
    'assets/icons/plus.svg',
    semanticsLabel: 'plus',
    width: 24,
    height: 24,
  );

  final Function onPressed;

  AddButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 3,
            color: const Color(0xff2B2F79),
          ),
        ),
        child: plusSVG,
      ),
    );
  }
}
