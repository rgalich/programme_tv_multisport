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
          ),
          BlocProvider<DateSelectedBloc>(
            builder: (BuildContext context) => DateSelectedBloc(),
          ),
          BlocProvider<ChannelBloc>(
            builder: (BuildContext context) => ChannelBloc(),
          ),
          BlocProvider<EventListBloc>(
            builder: (BuildContext context) => EventListBloc(
              dateSelectedBloc: BlocProvider.of<DateSelectedBloc>(context),
              sportListBloc: BlocProvider.of<SportBloc>(context),
              channelListBloc: BlocProvider.of<ChannelBloc>(context),
              sportSelectedBloc: BlocProvider.of<SportSelectedBloc>(context)
            ),
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
    final _channelBloc = BlocProvider.of<ChannelBloc>(context);
    _channelBloc.add(GetChannelList());
    final _dateListBloc = BlocProvider.of<DateListBloc>(context);
    _dateListBloc.add(GetDateList());
    final _dateSelectedBloc = BlocProvider.of<DateSelectedBloc>(context);
    _dateSelectedBloc.add(DateNowSelected());
    return MaterialApp(
      title: 'Programme tv foot & multisport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(appBar: AppBarHome(), drawer: DrawerHome(), body: BodyHome()),
    );
  }
}
