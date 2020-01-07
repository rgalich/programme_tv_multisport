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
      StorageReference storageReference = await _storage.getReferenceFromUrl('gs://programme-tv-multisport.appspot.com/channel/${channel.pictureName}');
      await storageReference.writeToFile(pictureFile).future;
      await pictureFile.create();
    }

    return channel.copyWith(pictureFile: pictureFile);
  }

  Future<Sport> downloadSportIcon(Sport sport) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File logoFile = File('${directory.path}/${sport.logo}');
    
    if (!logoFile.existsSync()) {
      StorageReference storageReference = await _storage.getReferenceFromUrl('gs://programme-tv-multisport.appspot.com/sport/${sport.logo}');
      await storageReference.writeToFile(logoFile).future;
      await logoFile.create();
    }

    return sport.copyWith(logoFile: logoFile);
  }
}