import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/widgets/widgets.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SportBloc>(
          builder: (BuildContext context) => SportBloc(),
        ), 
        BlocProvider<SportSelectedBloc>(
          builder: (BuildContext context) => SportSelectedBloc(),
        )
      ],
      child: App(),
    )
    ,
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sportBloc = BlocProvider.of<SportBloc>(context);
    _sportBloc.add(GetSportList());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBarHome(),
        drawer: DrawerHome()
      ),
    );
  }
}
