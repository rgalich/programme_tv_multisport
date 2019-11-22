import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class StorageProvider {
  final _storage = FirebaseStorage.instance;  

  Future<Channel> downloadChannelPicture(Channel channel) async {
    Directory directory = await getApplicationDocumentsDirectory();
    StorageReference storageReference = await _storage.getReferenceFromUrl('gs://programme-tv-multisport.appspot.com/${channel.fileName}');
    File channelFile = File('${directory.path}/${channel.fileName}');
    storageReference.writeToFile(channelFile);
    if (!channelFile.existsSync()) {
      await channelFile.create();
    }

    return channel.fromFile(channelFile);
  }
}