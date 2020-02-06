import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programme_tv_multisport/src/enums/broadcast.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;

  Future signInAnonymously() async {
    if (await FirebaseAuth.instance.currentUser() == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
  }

  Future<List<Channel>> channelList(DateTime lastUpdate) async {
    await signInAnonymously();
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
    await signInAnonymously();
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

  DateTime dateNow() {
    DateTime date = Timestamp.now().toDate();
    return DateTime(date.year, date.month, date.day);
  }

  Future<List<Event>> eventList(
      DateTime date,
      List<Sport> sportList,
      List<Channel> channelList,
      Sport sport,
      Broadcast broadcast,
      DateTime lastUpdate) async {
    await signInAnonymously();
    List<Event> eventList = new List<Event>();

    Query query = _firestore.collection("event");

    query = query.where('shortDate', isEqualTo: date);

    if (lastUpdate != null) {
      query = query.where('lastUpdate', isGreaterThan: lastUpdate);
    }

    if (sport != null) {
      query = query.where('sportId', isEqualTo: sport.id);
    }

    if (broadcast != Broadcast.All) {
      query = query.where('isLive',
          isEqualTo: broadcast == Broadcast.Live ? true : false);
    }

    try {
      QuerySnapshot querySnapshot = await query.getDocuments();

      querySnapshot.documents.forEach((document) {
        eventList.add(Event.fromMap(
            document.documentID, sportList, channelList, document.data));
      });
    } catch (e) {
      print(e);
    }

    return eventList;
  }
}
