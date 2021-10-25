import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      child: Text('-'),
      onPressed: () => {},
    );
  }
}
