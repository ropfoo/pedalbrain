import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/knob/knob.dart';
import 'package:pedalbrain/widgets/arrow_button.dart';
import 'package:pedalbrain/widgets/name_change_modal.dart';

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

  double _currentSliderValue = 10;

  NameChangeModal nameChangeModal = NameChangeModal();

  void _onSelected(dynamic choice, BuildContext context) {
    switch (choice) {
      case "rename":
        return nameChangeModal.show(
            context: context,
            initialName: widget.selection!.knobData.label,
            onChanged: (value) => widget.selection!.setLabel(value));

      default:
    }
  }

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

    if (widget.selection != null) {
      _currentSliderValue = widget.selection!.knobData.options.radius;
    }

    return SlideTransition(
      position: _offsetAnimation,
      child: widget.selection != null
          ? Container(
              width: 500,
              height: 290,
              color: const Color(0xff00042C),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ArrowButton(
                              onPressed: () {
                                _controller.reverse();
                                widget.selection!.toggleEditMode();
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 25),
                              child: Text(
                                widget.selection!.knobData.label,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PopupMenuButton(
                              onSelected: (choice) =>
                                  _onSelected(choice, context),
                              color: const Color(0xff615EFF),
                              itemBuilder: (ctx) => [
                                const PopupMenuItem(
                                  value: "rename",
                                  child: Text(
                                    'Rename',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "color",
                                  child: Text(
                                    'Color',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: _currentSliderValue,
                    min: 10,
                    max: 30,
                    divisions: 4,
                    label: widget.selection!.knobData.options.radius
                        .round()
                        .toString(),
                    onChanged: (double value) {
                      widget.selection!.setRadius(value);
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  )
                ],
              ),
            )
          : Container(),
    );
  }
}
