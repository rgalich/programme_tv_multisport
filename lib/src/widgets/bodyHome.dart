import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class BodyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventListBloc, EventListState>(
        builder: (BuildContext context, EventListState state) {
      if (state is EventListLoaded) {
        if (state.eventList.length != 0) {
          return Container(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                Event event = state.eventList[index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      key: Key(event.id),
                      title: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: Image.file(event.sportLogoFile),
                          ),
                          SizedBox(width: 10.0),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  event.libelle,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                if (event.secondLibelle != "")
                                  Text(
                                    event.secondLibelle,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.file(
                                event.mainChannelPicture,
                                height: 20.0,
                                width: 35.0,
                              ),
                              if (event.secondChannelPicture != null)
                                SizedBox(height: 5.0),
                              if (event.secondChannelPicture != null)
                                Image.file(
                                  event.secondChannelPicture,
                                  height: 20.0,
                                  width: 35.0,
                                ),
                            ],
                          ),
                          VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  DateFormat('Hm', 'fr_FR')
                                      .format(event.longDate),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 2.0),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: Container(
                                  width: 50.0,
                                  color: event.isLive
                                      ? Colors.redAccent
                                      : Colors.blueGrey,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        event.isLive ? 'Direct' : 'Rediff',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      dense: true,
                    ),
                    Divider(
                      height: 0.0,
                    )
                  ],
                );
              },
              itemCount: state.eventList.length,
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Il n'y a pas d'événements pour ce sport aujourd'hui."),
                Text("Veuillez sélectionner une autre date ou un autre sport.")
              ],
            ),
          );
        }
      }

      return Text('');
    });
  }
}
