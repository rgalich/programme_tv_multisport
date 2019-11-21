import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class BodyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventListBloc, EventListState>(
        builder: (BuildContext context, EventListState state) {
      if (state is EventListLoaded) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            Event event = state.eventList[index];
            return ListTile(
              key: Key(event.id),
              title: Text(event.libelle),
              dense: true,
            );
          },
          itemCount: state.eventList.length,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 0.0),
        );
      }

      return Text('Toto');
    });
  }
}
