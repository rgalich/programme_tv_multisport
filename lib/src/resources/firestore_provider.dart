import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;

  Future<List<Channel>> channelList(DateTime lastUpdate) async {
    List<Channel> channelList = new List<Channel>();

    Query query = _firestore.collection("channel");

    if (lastUpdate != null) {
      query = query.where('lastUpdate', isGreaterThan: lastUpdate);
    }

    QuerySnapshot querySnapshot = await query.getDocuments();
    querySnapshot.documents.forEach((document) {
      channelList.add(Channel.fromMap(document.documentID, document.data));
    });

    return channelList;
  }

  Future<List<Sport>> sportList(DateTime lastUpdate) async {
    List<Sport> sportList = new List<Sport>();

    Query query = _firestore.collection("sport");

    if (lastUpdate != null) {
      query = query.where('lastUpdate', isGreaterThan: lastUpdate);
    }

    QuerySnapshot querySnapshot = await query.getDocuments();
    querySnapshot.documents.forEach((document) {
      sportList.add(Sport.fromMap(document.documentID, document.data));
    });

    return sportList;
  }

  Future<DateTime> dateNow() async {
    return DateFormat("yyyy-MM-dd").parse(Timestamp.now().toDate().toString());
  }

  Future<List<Event>> eventList(DateTime date, List<Sport> sportList, List<Channel> channelList, Sport sport) async {
    List<Event> eventList = new List<Event>();

    Query query = _firestore.collection("event")
      .where('date', isGreaterThanOrEqualTo: date)
      .where('date', isLessThan: date.add(new Duration(days: 1)));

    // if (sport != null) {
    //   query = query.where('sportId', isEqualTo: sport.id);
    // }

    QuerySnapshot querySnapshot = await query.getDocuments();
    
    querySnapshot.documents.forEach((document) {
      eventList.add(Event.fromMap(document.documentID, sportList, channelList, document.data));
    });

    return eventList;
  }
}