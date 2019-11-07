import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/widgets/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting("fr_FR", null).then(
    (_) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<SportBloc>(
            builder: (BuildContext context) => SportBloc(),
          ),
          BlocProvider<SportSelectedBloc>(
            builder: (BuildContext context) => SportSelectedBloc(),
          ),
          BlocProvider<DateListBloc>(
            builder: (BuildContext context) => DateListBloc(),
          )
        ],
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sportBloc = BlocProvider.of<SportBloc>(context);
    _sportBloc.add(GetSportList());
    final _dateListBloc = BlocProvider.of<DateListBloc>(context);
    _dateListBloc.add(GetDateList());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(appBar: AppBarHome(), drawer: DrawerHome()),
    );
  }
}
