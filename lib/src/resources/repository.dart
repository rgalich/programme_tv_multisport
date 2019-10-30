import 'package:programme_tv_multisport/src/models/models.dart';

import './firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<List<Channel>> channelList() => _firestoreProvider.channelList();

  Future<List<Sport>> sportList() => _firestoreProvider.sportList();
}
