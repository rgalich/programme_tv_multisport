import 'package:path/path.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:sqflite/sqflite.dart' as sqlite;

class SqliteProvider {
  sqlite.Database db;

  Future openDatabase() async {
    String databasesPath = await sqlite.getDatabasesPath();
    String fullPath = join(databasesPath, 'tele-sportifs.db');

    this.db = await sqlite.openDatabase(fullPath, version: 1,
        onCreate: (sqlite.Database db, int version) async {
      await db.execute(
          "CREATE TABLE sport (id STRING, logo STRING, libelle STRING, 'order' INTEGER, lastUpdate INTEGER)");
      await db.execute(
          "CREATE TABLE channel (id STRING, libelle STRING, pictureName STRING, lastUpdate INTEGER)");
    });
  }

  Future insertSportList(List<Sport> sportList) async {
    if (this.db == null) {
      await this.openDatabase();
    }

    await this.db.transaction((txn) async {
      for (Sport sport in sportList) {
        await txn.rawInsert(
            "INSERT INTO sport(id, libelle, logo, 'order', 'lastUpdate') VALUES(?, ?, ?, ?, ?)",
            [
              sport.id,
              sport.libelle,
              sport.logo,
              sport.order,
              sport.lastUpdate.millisecondsSinceEpoch
            ]);
      }
    });
  }

  Future<List<Sport>> getSportList() async {
    if (this.db == null) {
      await this.openDatabase();
    }

    List<Map<String, dynamic>> mapList =
        await this.db.rawQuery('SELECT * FROM sport');
    List<Sport> sportList = new List<Sport>();
    mapList.forEach((map) {
      sportList.add(Sport.fromMap(map['id'], map));
    });

    return sportList;
  }

  Future insertChannelList(List<Channel> channelList) async {
    if (this.db == null) {
      await this.openDatabase();
    }

    await this.db.transaction((txn) async {
      for (Channel channel in channelList) {
        await txn.rawInsert(
            "INSERT INTO channel(id, libelle, pictureName, lastUpdate) VALUES(?, ?, ?, ?)",
            [
              channel.id,
              channel.libelle,
              channel.pictureName,
              channel.lastUpdate.millisecondsSinceEpoch
            ]);
      }
    });
  }

  Future<List<Channel>> getChannelList() async {
    if (this.db == null) {
      await this.openDatabase();
    }

    List<Map<String, dynamic>> mapList =
        await this.db.rawQuery('SELECT * FROM channel');
    List<Channel> channelList = new List<Channel>();
    mapList.forEach((map) {
      channelList.add(Channel.fromMap(map['id'], map));
    });

    return channelList;
  }

  Future closeDatabase(sqlite.Database db) async {
    await db.close();
  }
}
