import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String id;
  final String image;
  final String libelle;

  const Channel({this.id, this.image, this.libelle});

  @override
  List<Object> get props => [id, image, libelle];

  static Channel fromMap(String id, Map<String, dynamic> map) {
    return Channel(id: id, libelle: map["libelle"], image: map["image"]);
  }
}
