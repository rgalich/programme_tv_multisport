import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class Event extends Equatable {
  final String id;
  final String sportLogo;
  final File mainChannelPicture;
  final File secondChannelPicture;
  final DateTime date;
  final String libelle;
  final String secondLibelle;
  
  const Event({this.id, this.sportLogo, this.mainChannelPicture, this.secondChannelPicture, this.date, this.libelle, this.secondLibelle});

  @override
  List<Object> get props => [id, sportLogo, mainChannelPicture, secondChannelPicture, date, libelle, secondLibelle];

  static Event fromMap(String id, List<Sport> sportList, List<Channel> channelList, Map<String, dynamic> map) {
    return Event(
      id: id, 
      date: (map['date'] as Timestamp).toDate(), 
      libelle: map['libelle'], 
      secondLibelle: map['secondLibelle'], 
      sportLogo: sportList.singleWhere((sport) => sport.id == map['sportId'])?.logo ,
      mainChannelPicture: channelList.singleWhere((channel) => channel.id == map['mainChannelId'])?.pictureFile,
      //secondChannelPicture: channelList.firstWhere((channel) => channel.id == map['secondChannelId'])?.pictureFile
    );
  }
}