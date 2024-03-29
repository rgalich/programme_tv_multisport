import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/widgets/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:async';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    initializeDateFormatting("fr_FR", null).then(
      (_) => runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<SportBloc>(
              create: (BuildContext context) => SportBloc(),
            ),
            BlocProvider<SportSelectedBloc>(
              create: (BuildContext context) => SportSelectedBloc(
                  sportListBloc: BlocProvider.of<SportBloc>(context)),
            ),
            BlocProvider<DateListBloc>(
              create: (BuildContext context) => DateListBloc(),
            ),
            BlocProvider<DateSelectedBloc>(
              create: (BuildContext context) => DateSelectedBloc(),
            ),
            BlocProvider<ChannelBloc>(
              create: (BuildContext context) => ChannelBloc(),
            ),
            BlocProvider<BroadcastSelectedBloc>(
              create: (BuildContext context) => BroadcastSelectedBloc(),
            ),
            BlocProvider<EventListBloc>(
              create: (BuildContext context) => EventListBloc(
                  dateSelectedBloc: BlocProvider.of<DateSelectedBloc>(context),
                  sportListBloc: BlocProvider.of<SportBloc>(context),
                  channelListBloc: BlocProvider.of<ChannelBloc>(context),
                  sportSelectedBloc:
                      BlocProvider.of<SportSelectedBloc>(context),
                  broadcastSelectedBloc:
                      BlocProvider.of<BroadcastSelectedBloc>(context)),
            ),
            BlocProvider<LoadingBloc>(
              create: (BuildContext context) => LoadingBloc(
                  eventListBloc: BlocProvider.of<EventListBloc>(context)),
            )
          ],
          child: App(),
        ),
      ),
    );
  }, onError: Crashlytics.instance.recordError);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChannelBloc>(context).add(GetChannelList());
    BlocProvider.of<SportBloc>(context).add(GetSportList());
    BlocProvider.of<DateListBloc>(context).add(GetDateList());
    BlocProvider.of<DateSelectedBloc>(context).add(DateNowSelected());
    return MaterialApp(
      title: 'Programme tv foot & multisport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Varela',
      ),
      home: BlocBuilder<EventListBloc, EventListState>(
        builder: (BuildContext context, EventListState state) {
          if (!(state is EventListEmply)) {
            return Home();
          }

          return SplashScreen();
        }
      )
    );
  }
}
