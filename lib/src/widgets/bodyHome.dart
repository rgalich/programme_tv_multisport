import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
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
              title: Row(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: SvgPicture.asset('assets/${event.sportLogo}',
                        semanticsLabel: 'football'),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        event.libelle,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        event.secondLibelle,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(DateFormat('Hm', 'fr_FR')
                      .format(event.date)),
                ],
              ),
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
