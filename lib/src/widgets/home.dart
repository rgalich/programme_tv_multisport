import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/dialogs/dialogs.dart';
import 'package:programme_tv_multisport/src/widgets/widgets.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      );
  }
}