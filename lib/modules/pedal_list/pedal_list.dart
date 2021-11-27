import 'package:flutter/material.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/pedal_list/bloc/pedal_list_bloc.dart';
import 'package:pedalbrain/modules/pedal_list/pedal_list_item.dart';
import 'package:pedalbrain/screens/pedal_ui_screen.dart';
import 'package:pedalbrain/widgets/add_button.dart';

class PedalList extends StatelessWidget {
  PedalList({Key? key}) : super(key: key);

  final PedalListBloc _pedalListBloc = PedalListBloc();
  List<PedalListItem> getPedalListItems(List<dynamic> list) {
    List<PedalListItem> pedalListItems = [];
    for (var item in list) {
      var pedalData = PedalData.createFromSnapshot(
        item,
        KnobOptions(
          isEditable: false,
          showLabel: false,
        ),
      );
      pedalListItems.add(PedalListItem(
        pedalData: pedalData,
        onLeave: (update, add) {
          _pedalListBloc.getData();
          update();
        },
      ));
    }
    return pedalListItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pedals',
                  style: Theme.of(context).textTheme.headline1,
                ),
                AddButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PedalUIScreen(
                        pedalData: PedalData.createDefault(),
                        onLeave: (upade, add) {
                          _pedalListBloc.getData();
                          add();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 620,
          child: StreamBuilder(
            stream: _pedalListBloc.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (_pedalListBloc.state.listData.isNotEmpty) {
                return ListView(
                  children: getPedalListItems(_pedalListBloc.state.listData),
                );
              } else {
                return const Text('no pedal data');
              }
            },
          ),
        )
      ],
    );
  }
}
