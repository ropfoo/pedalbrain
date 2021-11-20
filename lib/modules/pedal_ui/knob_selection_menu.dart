import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/widgets/arrow_button.dart';

class KnobSelectionMenu extends StatefulWidget {
  final bool isVisible;
  final Knob? selection;

  const KnobSelectionMenu({
    Key? key,
    required this.isVisible,
    required this.selection,
  }) : super(key: key);

  @override
  State<KnobSelectionMenu> createState() => _KnobSelectionMenuState();
}

class _KnobSelectionMenuState extends State<KnobSelectionMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVisible) {
      _controller.forward();
    }

    return SlideTransition(
      position: _offsetAnimation,
      child: widget.selection != null
          ? Container(
              width: 500,
              height: 290,
              color: const Color(0xff000913),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Row(
                      children: [
                        ArrowButton(
                          onPressed: () {
                            _controller.reverse();
                            widget.selection!.toggleEditMode();
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 25),
                          child: Text(widget.selection!.label,
                              style: Theme.of(context).textTheme.headline4),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
