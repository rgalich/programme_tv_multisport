import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/dialogs/dialogs.dart';

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
                return Text("");
              }
              if (state is SportSelectedLoaded) {
                return Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(state.sport.libelle),
                );
              }

              return Text("");
            },
          ),
          BlocBuilder<DateSelectedBloc, DateSelectedState>(
              builder: (BuildContext context, DateSelectedState state) {
            if (state is DateSelectedLoaded) {
              return Text(
                  DateFormat('dd.MM.yyyy, EEEE', 'fr_FR').format(state.date).toUpperCase(),
                  style: TextStyle(fontSize: 13));
            }

            return Text("");
          }),
        ],
      ),
      backgroundColor: Color.fromRGBO(27, 119, 0, 1),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.calendar_today),
          color: Colors.white,
          onPressed: () {
            calendar(context);
          },
        ),
      ],
    );
  }
}
