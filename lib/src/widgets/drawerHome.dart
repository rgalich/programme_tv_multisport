import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:programme_tv_multisport/src/widgets/widgets.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DrawerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<SportDrawerListBloc, SportDrawerListState>(
          builder: (BuildContext context, SportDrawerListState state) {
        if (state is SportDrawerListLoaded) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return StickyHeader(
                header: Container(
                  height: 20,
                  color: Colors.grey[300],
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    state.sportDrawerList[index].libelle,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                content: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext contextSport, int indexSport) {
                    return ListTileDrawerHome(
                        sport:
                            state.sportDrawerList[index].sportList[indexSport]);
                  },
                  separatorBuilder: (BuildContext contextSport, int indexSport) => Divider(height: 0.5),
                  itemCount: state.sportDrawerList[index].sportList.length,
                ),
              );
            },
            itemCount: state.sportDrawerList.length,
          );
        }

        return Text('eee');
      }),
    );
  }
}
