import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  @override
  final preferredSize = Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: <Widget>[
          BlocBuilder<SportSelectedBloc, SportSelectedState>(
            builder: (BuildContext context, SportSelectedState state) {
              if (state is SportSelectedEmply) {
                return Text("data");
              }
              if (state is SportSelectedLoaded) {
                return Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(state.sport.libelle),
                );
              }

              return Text("data");
            },
          ),
          Text('10.09.2019, MARDI', style: TextStyle(fontSize: 13))
        ],
      ),
      backgroundColor: Color.fromRGBO(27, 119, 0, 1),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.calendar_today, color: Colors.white))
      ],
    );
  }
}