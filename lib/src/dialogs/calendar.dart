import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';

void calendar(BuildContext context) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOut.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -200, 0.0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            titlePadding: EdgeInsets.all(0.0),
            contentPadding: EdgeInsets.all(0.0),
            title: Container(
              padding: EdgeInsets.only(left: 24.0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(27, 119, 0, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "CALENDRIER",
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      }),
                ],
              ),
            ),
            content: Container(
              width: double.maxFinite,
              child: BlocBuilder<DateListBloc, DateListState>(
                builder: (BuildContext context, DateListState state) {
                  if (state is DateListLoaded) {
                    return ListView.separated(
                      padding: EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime date = state.dateList[index];
                        return ListTile(
                          dense: true,
                          title: Text(DateFormat('dd.M. EEEE', 'fr_FR').format(date).toUpperCase()),
                        );
                      },
                      itemCount: state.dateList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(height: 0.0),
                    );
                  }

                  return Text("TOTO");
                },
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {});
}
