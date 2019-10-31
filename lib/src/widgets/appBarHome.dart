import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  @override
  final preferredSize = Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text('FOOTBALL'),
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
