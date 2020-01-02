import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/dialogs/dialogs.dart';
import 'package:programme_tv_multisport/src/widgets/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting("fr_FR", null).then(
    (_) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<SportBloc>(
            create: (BuildContext context) => SportBloc(),
          ),
          BlocProvider<SportSelectedBloc>(
            create: (BuildContext context) => SportSelectedBloc(),
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
                sportSelectedBloc: BlocProvider.of<SportSelectedBloc>(context),
                broadcastSelectedBloc: BlocProvider.of<BroadcastSelectedBloc>(context)),
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
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SportBloc>(context).add(GetSportList());
    BlocProvider.of<ChannelBloc>(context).add(GetChannelList());
    BlocProvider.of<DateListBloc>(context).add(GetDateList());
    BlocProvider.of<DateSelectedBloc>(context).add(DateNowSelected());
    return MaterialApp(
      title: 'Programme tv foot & multisport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBarHome(),
        drawer: BlocProvider<SportDrawerListBloc>(
          create: (BuildContext context) => SportDrawerListBloc(
              sportListBloc: BlocProvider.of<SportBloc>(context)),
          child: DrawerHome(),
        ),
        body: BlocBuilder<LoadingBloc, LoadingState>(
          builder: (BuildContext context, LoadingState state) {
            if (state is LoadingHidden) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
            }
            if (state is LoadingVisible) {
              SchedulerBinding.instance
                  .addPostFrameCallback((_) => loading(context));
            }
            return BodyHome();
          },
        ),
        bottomNavigationBar: BottomNavigationBarHome(),
      ),
    );
  }
}
