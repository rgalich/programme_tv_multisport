import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/widgets/widgets.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DrawerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<SportDrawerListBloc, SportDrawerListState>(
          builder: (BuildContext context, SportDrawerListState state) {
        if (state is SportDrawerListLoaded) {
          return Column(children: <Widget>[
            Container(
              color: Color.fromRGBO(27, 119, 0, 1),
              padding: EdgeInsets.fromLTRB(5.0, 30.0, 0.0, 10.0),
              child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.accessibility_new,
                              color: Colors.white,
                              size: 35,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Programme Tv multisport',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 22),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
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
                      padding: EdgeInsets.all(0.0),
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
              ),
            )
          ],);
        }

        return Text('');
      }),
    );
  }
}
