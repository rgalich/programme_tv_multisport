import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class ListTileDrawerHome extends StatelessWidget {
  final Sport sport;

  const ListTileDrawerHome({this.sport});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SportSelectedBloc, SportSelectedState>(
          builder: (BuildContext context, SportSelectedState state) {
        return Container(
          color: state is SportSelectedLoaded && sport == state.sport
              ? Colors.grey.withOpacity(0.1)
              : Colors.white,
          child: ListTile(
            key: Key(sport.id),
            dense: true,
            title: Row(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: Image.file(sport.logoFile,
                      color:
                          state is SportSelectedLoaded && sport == state.sport
                              ? Colors.black
                              : Colors.grey),
                ),
                SizedBox(width: 10.0),
                Text(
                  sport.libelle,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight:
                        state is SportSelectedLoaded && sport == state.sport
                            ? FontWeight.bold
                            : FontWeight.normal,
                    color: Colors.black.withOpacity(0.7),
                  ),
                )
              ],
            ),
            trailing: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text(
                  '10',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
              BlocProvider.of<SportSelectedBloc>(context)
                  .add(SportSelected(sport: sport));
            },
          ),
        );
      }),
    );
  }
}
