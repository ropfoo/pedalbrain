import 'package:flutter/material.dart';
import 'package:pedalbrain/models/knob_data.dart';
import 'package:pedalbrain/models/pedal_data.dart';
import 'package:pedalbrain/modules/pedal_list/bloc/pedal_list_bloc.dart';
import 'package:pedalbrain/modules/pedal_list/pedal_list_item.dart';

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
        onLeave: () {
          _pedalListBloc.getData();
          print('lel');
        },
      ));
    }
    return pedalListItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            alignment: Alignment.topLeft,
            child: Text(
              'Pedals',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(
            height: 300,
            child: StreamBuilder(
              stream: _pedalListBloc.stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (_pedalListBloc.state.listData.isNotEmpty) {
                  return ListView(
                    children: getPedalListItems(_pedalListBloc.state.listData),
                  );
                } else {
                  return Text('no pedal data');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
