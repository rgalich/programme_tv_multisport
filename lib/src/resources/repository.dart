import 'package:programme_tv_multisport/src/models/models.dart';
import './sqlite_provider.dart';
import './storage_provider.dart';
import './firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final _storageProvider = StorageProvider();
  final _sqliteProvider = SqliteProvider();

  Future<List<Channel>> channelList() async {
    List<Channel> channelList = await _firestoreProvider.channelList();
    List<Channel> channelWithPicture = new List<Channel>();

    channelList.forEach((channel) async {
      channelWithPicture.add(await _storageProvider.downloadChannelPicture(channel));
    });
    return channelWithPicture;
  }  

  Future<List<Sport>> sportList() async {
    List<Sport> sportList = new List<Sport>();

    sportList = await _sqliteProvider.getSportList();

    if (sportList.length > 0) {
      return sportList;
    }

    sportList = await _firestoreProvider.sportList();
    await _sqliteProvider.insertSportList(sportList);

    return sportList;
  }

  Future<DateTime> dateNow() => _firestoreProvider.dateNow();

  Future<List<Event>> eventList(DateTime date, List<Sport> sportList,
          List<Channel> channelList, Sport sport) async =>
      await _firestoreProvider.eventList(date, sportList, channelList, sport);
}
