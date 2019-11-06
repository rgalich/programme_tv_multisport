import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;

  Future<List<Channel>> channelList() async {
    List<Channel> channelList = new List<Channel>();

    QuerySnapshot querySnapshot = await _firestore.collection("channel").getDocuments();
    querySnapshot.documents.forEach((document) {
      channelList.add(Channel.fromMap(document.documentID, document.data));
    });

    return channelList;
  }

  Future<List<Sport>> sportList() async {
    List<Sport> sportList = new List<Sport>();

    QuerySnapshot querySnapshot = await _firestore.collection("sport").getDocuments();
    querySnapshot.documents.forEach((document) {
      sportList.add(Sport.fromMap(document.documentID, document.data));
    });

    return sportList;
  }

  Future<List<DateTime>> dateList() async {
    List<DateTime> dateList = new List<DateTime>();

    final currentDate = Timestamp.now().toDate();
    dateList.add(currentDate);

    for (var i = 1; i <= 7; i++) {
      dateList.add(currentDate.add(new Duration(days: i)));
      dateList.add(currentDate.add(new Duration(days: i * -1)));
    }

    return dateList;
  }
}