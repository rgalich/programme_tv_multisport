import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  key: Key(state.sportList[index].id),
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: new SvgPicture.asset(
                            'assets/${state.sportList[index].logo}',
                            color: Colors.grey,
                            semanticsLabel: 'football'),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        state.sportList[index].libelle,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black.withOpacity(0.7)),
                      )
                    ],
                  ),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Text('10',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {});
            },
            itemCount: state.sportList.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 0.0),
          );
        }
      }),
    );
  }
}
