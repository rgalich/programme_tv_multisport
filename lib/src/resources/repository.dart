import 'package:programme_tv_multisport/src/models/models.dart';
import './storage_provider.dart';
import './firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final _storageProvider = StorageProvider();

  Future<List<Channel>> channelList() async {
    List<Channel> channelList = await _firestoreProvider.channelList();
    List<Channel> channelWithPicture = new List<Channel>();

    channelList.forEach((channel) async {
      channelWithPicture.add(await _storageProvider.downloadChannelPicture(channel));
    });
    return channelWithPicture;
  }  

  Future<List<Sport>> sportList() async => await _firestoreProvider.sportList();

  Future<DateTime> dateNow() => _firestoreProvider.dateNow();

  Future<List<Event>> eventList(DateTime date, List<Sport> sportList,
          List<Channel> channelList, Sport sport) async =>
      await _firestoreProvider.eventList(date, sportList, channelList, sport);
}
