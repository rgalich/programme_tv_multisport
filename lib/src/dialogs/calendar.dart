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
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8.0),
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
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ListView.separated(
                        padding: EdgeInsets.all(0.0),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          DateTime date = state.dateList[index];
                          return BlocBuilder<DateSelectedBloc,
                                  DateSelectedState>(
                              builder: (BuildContext context,
                                  DateSelectedState state) {
                            if (state is DateSelectedLoaded) {
                              return Container(
                                color: state is DateSelectedLoaded &&
                                        date == state.date
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.white,
                                child: ListTile(
                                    dense: true,
                                    title: Text(
                                      DateFormat('dd.M. EEEE', 'fr_FR')
                                          .format(date)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight:
                                            state is DateSelectedLoaded &&
                                                    date == state.date
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      BlocProvider.of<DateSelectedBloc>(context)
                                          .add(DateSelected(date: date));
                                    }),
                              );
                            }
                          });
                        },
                        itemCount: state.dateList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(height: 0.0),
                      ),
                    );
                  }

                  return Text("");
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
