import 'package:programme_tv_multisport/src/models/models.dart';

import './firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<List<Channel>> channelList() async =>
      await _firestoreProvider.channelList();

  Future<List<Sport>> sportList() async => await _firestoreProvider.sportList();

  Future<DateTime> dateNow() => _firestoreProvider.dateNow();

  Future<List<Event>> eventList(DateTime date, List<Sport> sportList,
          List<Channel> channelList) async =>
      await _firestoreProvider.eventList(date, sportList, channelList);
}
