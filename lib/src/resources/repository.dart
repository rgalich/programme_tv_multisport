import 'package:programme_tv_multisport/src/models/models.dart';

import './firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<List<Channel>> channelLis() => _firestoreProvider.channelList();

  Future<List<Sport>> sportLis() => _firestoreProvider.sportList();
}
