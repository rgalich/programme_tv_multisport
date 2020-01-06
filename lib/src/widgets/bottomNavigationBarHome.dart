import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/enums/enums.dart';

class BottomNavigationBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BroadcastSelectedBloc, BroadcastSelectedState>(
      builder: (BuildContext context, BroadcastSelectedState state) {
        return BottomNavigationBar(
          currentIndex: (state as BroadcastSelectedLoaded).broadcast.index,
          onTap: (index) {
            BlocProvider.of<BroadcastSelectedBloc>(context)
                  .add(BroadcastSelected(broadcast: Broadcast.values[index]));
          },
          elevation: 0.0,
          backgroundColor: Colors.grey.withOpacity(0.1),
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              title: Text('Tous'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              title: Text('Direct'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.replay), title: Text('Rediffusion'))
          ],
        );
      },
    );
  }
}
