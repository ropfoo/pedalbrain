import 'package:flutter/widgets.dart';

class KnobLabel extends StatelessWidget {
  final String text;

  const KnobLabel({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Text(text),
    );
  }
}
