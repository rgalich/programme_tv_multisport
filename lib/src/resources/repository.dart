import 'package:programme_tv_multisport/src/enums/broadcast.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import './sqlite_provider.dart';
import './storage_provider.dart';
import './firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final _storageProvider = StorageProvider();
  final _sqliteProvider = SqliteProvider();

  Future<List<Channel>> channelList() async {
    List<Channel> channelList = new List<Channel>();

    channelList = await _sqliteProvider.getChannelList();

    channelList.sort((b, a) => a.lastUpdate.compareTo(b.lastUpdate));
    await _sqliteProvider.insertChannelList(await _firestoreProvider.channelList(channelList.length == 0 ? null : channelList.first.lastUpdate));

    channelList = await _sqliteProvider.getChannelList();

    channelList = await Future.wait(channelList.map((channel) async {
      return await _storageProvider.downloadChannelPicture(channel);
    }));

    return channelList;
  }  

  Future<List<Sport>> sportList() async {
    List<Sport> sportList = new List<Sport>();

    sportList = await _sqliteProvider.getSportList();
    
    sportList.sort((b, a) => a.lastUpdate.compareTo(b.lastUpdate));
    await _sqliteProvider.insertSportList(await _firestoreProvider.sportList(sportList.length == 0 ? null : sportList.first.lastUpdate));

    sportList = await _sqliteProvider.getSportList();

    sportList = await Future.wait(sportList.map((sport) async {
      return await _storageProvider.downloadSportIcon(sport);
    }));

    return sportList;
  }

  Future<DateTime> dateNow() async {
    final date = _firestoreProvider.dateNow();
    await _sqliteProvider.deleteEvent(date.add(new Duration(days: -8)));
    return date;
  }

  Future<List<Event>> eventList(DateTime date, List<Sport> sportList,
          List<Channel> channelList, Sport sport, Broadcast broadcast) async {
    List<Event> eventList = new List<Event>();

    eventList = await _sqliteProvider.getEventList(date, sportList, channelList, sport, broadcast);

    if (broadcast == Broadcast.All) {
      if (eventList.where((event) => event.isLive).length == 0) {
        await _sqliteProvider.insertOrUpdateEventList(await _firestoreProvider.eventList(date, sportList, channelList, sport, Broadcast.Live, null));
      }

      if (eventList.where((event) => !event.isLive).length == 0) {
        await _sqliteProvider.insertOrUpdateEventList(await _firestoreProvider.eventList(date, sportList, channelList, sport, Broadcast.Replay, null));
      }
    }

    eventList = await _sqliteProvider.getEventList(date, sportList, channelList, sport, broadcast);

    eventList.sort((b, a) => a.lastUpdate.compareTo(b.lastUpdate));
    await _sqliteProvider.insertOrUpdateEventList(await _firestoreProvider.eventList(date, sportList, channelList, sport, broadcast, eventList.length == 0 ? null : eventList.first.lastUpdate));

    eventList = await _sqliteProvider.getEventList(date, sportList, channelList, sport, broadcast);

    eventList.sort((a, b) => a.longDate.compareTo(b.longDate));

    return eventList;
  }
}
