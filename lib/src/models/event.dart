import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class Event extends Equatable {
  final String id;
  final String sportLogoId;
  final String mainChannelId;
  final String secondChannelId;
  final File sportLogoFile;
  final File mainChannelPicture;
  final File secondChannelPicture;
  final DateTime longDate;
  final DateTime shortDate;
  final String libelle;
  final String secondLibelle;
  final bool isLive;
  final DateTime lastUpdate;

  const Event(
      {this.id,
      this.sportLogoFile,
      this.mainChannelPicture,
      this.secondChannelPicture,
      this.longDate,
      this.shortDate,
      this.libelle,
      this.secondLibelle,
      this.isLive,
      this.sportLogoId,
      this.mainChannelId,
      this.secondChannelId,
      this.lastUpdate});

  @override
  List<Object> get props => [
        id,
        sportLogoFile,
        mainChannelPicture,
        secondChannelPicture,
        longDate,
        shortDate,
        libelle,
        secondLibelle,
        isLive,
        sportLogoId,
        mainChannelId,
        secondChannelId,
        lastUpdate
      ];

  static Event fromMap(String id, List<Sport> sportList,
      List<Channel> channelList, Map<String, dynamic> map) {
    return Event(
        id: id,
        sportLogoId: map['sportId'],
        mainChannelId: map['mainChannelId'],
        secondChannelId: map['secondChannelId'],
        longDate: map['longDate'] is Timestamp
            ? map['longDate'].toDate()
            : Timestamp.fromMillisecondsSinceEpoch(map['longDate']).toDate(),
        shortDate: map['shortDate'] is Timestamp
            ? map['shortDate'].toDate()
            : Timestamp.fromMillisecondsSinceEpoch(map['shortDate']).toDate(),
        libelle: map['libelle'],
        secondLibelle: map['secondLibelle'],
        isLive: map['isLive'] is bool
            ? map['isLive']
            : map['isLive'] == 1 ? true : false,
        lastUpdate: map['lastUpdate'] is Timestamp
            ? map['lastUpdate'].toDate()
            : Timestamp.fromMillisecondsSinceEpoch(map['lastUpdate']).toDate(),
        sportLogoFile: sportList
            .singleWhere((sport) => sport.id == map['sportId'])
            ?.logoFile,
        mainChannelPicture: channelList
            .singleWhere((channel) => channel.id == map['mainChannelId'])
            ?.pictureFile,
        secondChannelPicture: map['secondChannelId'] != null
            ? channelList
                .singleWhere((channel) => channel.id == map['secondChannelId'])
                ?.pictureFile
            : null);
  }
}
