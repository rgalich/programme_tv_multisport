import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String id;
  final String picture;
  final String libelle;

  const Channel({this.id, this.picture, this.libelle});

  @override
  List<Object> get props => [id, picture, libelle];

  static Channel fromMap(String id, Map<String, dynamic> map) {
    return Channel(id: id, libelle: map["libelle"], picture: map["picture"]);
  }
}
