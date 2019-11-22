import 'dart:io';
import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String id;
  final String picture;
  final String libelle;
  final String fileName;
  final File file;

  const Channel({this.id, this.picture, this.libelle, this.fileName, this.file});

  @override
  List<Object> get props => [id, picture, libelle, fileName, file];

  static Channel fromMap(String id, Map<String, dynamic> map) {
    return Channel(id: id, libelle: map["libelle"], picture: map["picture"], fileName: map["fileName"]);
  }

  Channel fromFile(File file) {
    return Channel(id: id, libelle: libelle, picture: picture, fileName: fileName, file: file);
  }
}
