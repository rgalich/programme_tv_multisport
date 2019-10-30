import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/widgets/appBarHome.dart';

void main() {
  runApp(
    BlocProvider(
      builder: (BuildContext context) => SportBloc(),
      child: App(),
    ),
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
        drawer: Drawer(
          child: BlocBuilder(
              bloc: _sportBloc,
              builder: (BuildContext context, SportState state) {
                if (state is SportListEmply) {
                  return Text("Empty");
                }
                if (state is SportListLoaded) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Text(state.sportList[index].libelle);
                    },
                    itemCount: state.sportList.length,
                  );
                }
              }),
        ),
      ),
    );
  }
}
