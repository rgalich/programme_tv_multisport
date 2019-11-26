import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class StorageProvider {
  final _storage = FirebaseStorage.instance;  

  Future<Channel> downloadChannelPicture(Channel channel) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File pictureFile = File('${directory.path}/${channel.pictureName}');
    
    if (!pictureFile.existsSync()) {
      StorageReference storageReference = await _storage.getReferenceFromUrl('gs://programme-tv-multisport.appspot.com/${channel.pictureName}');
      storageReference.writeToFile(pictureFile);
      await pictureFile.create();
    }

    return channel.copyWith(pictureFile: pictureFile);
  }
}