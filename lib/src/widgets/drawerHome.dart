import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';

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
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Text(state.sportList[index].libelle);
                    },
                    itemCount: state.sportList.length,
                  );
                }
              }),
        );
  }
}