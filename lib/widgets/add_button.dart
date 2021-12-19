import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddButton extends StatelessWidget {
  final Widget plusSVG = SvgPicture.asset(
    'assets/icons/plus.svg',
    semanticsLabel: 'plus',
    width: 20,
    height: 20,
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
        child: plusSVG,
      ),
    );
  }
}
