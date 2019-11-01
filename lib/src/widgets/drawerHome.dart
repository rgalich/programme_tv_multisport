import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:programme_tv_multisport/src/widgets/widgets.dart';

class DrawerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<SportBloc, SportState>(
          builder: (BuildContext context, SportState state) {
        if (state is SportListEmply) {
          return Text("Empty");
        }
        if (state is SportListLoaded) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              Sport sport = state.sportList[index];
              return ListTileDrawerHome(sport: sport);
            },
            itemCount: state.sportList.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 0.0),
          );
        }

        return Text('eee');
      }),
    );
  }
}
