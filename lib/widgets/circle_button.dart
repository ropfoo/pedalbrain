import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget icon;
  const CircleButton({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      child: icon,
      onPressed: () => {},
    );
  }
}
