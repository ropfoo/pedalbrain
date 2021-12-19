import 'package:flutter/material.dart';
import 'package:pedalbrain/models/app_color.dart';
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
    return StreamBuilder(
      stream: _pedalListBloc.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (_pedalListBloc.state.listData.isNotEmpty) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColor.background,
                pinned: true,
                expandedHeight: 180.0,
                collapsedHeight: 100.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.all(10),
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
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return getPedalListItems(
                        _pedalListBloc.state.listData)[index];
                  },
                  childCount: _pedalListBloc.state.listData.length,
                ),
              ),
            ],
          );
        } else {
          return const Text('no pedal data');
        }
      },
    );
  }
}
