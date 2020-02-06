import 'package:path/path.dart';
import 'package:programme_tv_multisport/src/enums/broadcast.dart';
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
      await db.execute(
          "CREATE TABLE event (id STRING, shortDate INTEGER, longDate INTEGER, isLive INTEGER, libelle STRING, secondLibelle STRING, mainChannelId STRING, secondChannelId STRING, sportId STRING, lastUpdate INTEGER)");
    });
  }

  Future deleteEvent(DateTime date) async {
    if (this.db == null) {
      await this.openDatabase();
    }

    await db.rawDelete('DELETE FROM event WHERE shortDate < ?', [date.millisecondsSinceEpoch]);
  }

  Future insertSportList(List<Sport> sportList) async {
    if (this.db == null) {
      await this.openDatabase();
    }

    sqlite.Batch batch = db.batch();
    for (Sport sport in sportList) {
      batch.rawInsert(
          "INSERT INTO sport(id, libelle, logo, 'order', 'lastUpdate') VALUES(?, ?, ?, ?, ?)",
          [
            sport.id,
            sport.libelle,
            sport.logo,
            sport.order,
            sport.lastUpdate.millisecondsSinceEpoch
          ]);
    }

    await batch.commit(noResult: true);
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

    sqlite.Batch batch = db.batch();

    for (Channel channel in channelList) {
      batch.rawInsert(
          "INSERT INTO channel(id, libelle, pictureName, lastUpdate) VALUES(?, ?, ?, ?)",
          [
            channel.id,
            channel.libelle,
            channel.pictureName,
            channel.lastUpdate.millisecondsSinceEpoch
          ]);
    }

    await batch.commit(noResult: true);
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

  Future<List<Event>> getEventList(DateTime date, List<Sport> sportList,
      List<Channel> channelList, Sport sport, Broadcast broadcast) async {
    if (this.db == null) {
      await this.openDatabase();
    }

    String rawQuery = 'SELECT * FROM event WHERE shortDate = ?';
    List<dynamic> rawQueryParam = new List<dynamic>();
    rawQueryParam.add(date.millisecondsSinceEpoch);

    if (sport != null) {
      rawQuery = '$rawQuery AND sportId = ?';
      rawQueryParam.add(sport.id);
    }

    if (broadcast != Broadcast.All) {
      rawQuery = '$rawQuery AND isLive = ?';
      rawQueryParam.add(broadcast == Broadcast.Live ? 1 : 0);
    }

    List<Map<String, dynamic>> mapList =
        await this.db.rawQuery(rawQuery, rawQueryParam);
    List<Event> eventList = new List<Event>();
    mapList.forEach((map) {
      eventList.add(Event.fromMap(map['id'], sportList, channelList, map));
    });

    return eventList;
  }

  Future insertOrUpdateEventList(List<Event> eventList) async {
    if (this.db == null) {
      await this.openDatabase();
    }

    sqlite.Batch batch = db.batch();

    for (Event event in eventList) {
      int count = sqlite.Sqflite.firstIntValue(await db
          .rawQuery('SELECT COUNT(*) FROM event WHERE id = ?', [event.id]));

      if (count > 0) {
        batch.rawUpdate(
            "UPDATE event SET shortDate = ?, longDate = ?, isLive = ?, libelle = ?, secondLibelle = ?, mainChannelId = ?, secondChannelId = ?, sportId = ?, lastUpdate = ? WHERE id = ?",
            [
              event.shortDate.millisecondsSinceEpoch,
              event.longDate.millisecondsSinceEpoch,
              event.isLive,
              event.libelle,
              event.secondLibelle,
              event.mainChannelId,
              event.secondChannelId,
              event.sportLogoId,
              event.lastUpdate.millisecondsSinceEpoch,
              event.id,
            ]);
      } else {
        batch.rawInsert(
            "INSERT INTO event(id, shortDate, longDate, isLive, libelle, secondLibelle, mainChannelId, secondChannelId, sportId, lastUpdate) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            [
              event.id,
              event.shortDate.millisecondsSinceEpoch,
              event.longDate.millisecondsSinceEpoch,
              event.isLive,
              event.libelle,
              event.secondLibelle,
              event.mainChannelId,
              event.secondChannelId,
              event.sportLogoId,
              event.lastUpdate.millisecondsSinceEpoch
            ]);
      }
    }

    await batch.commit(noResult: true);
  }
}
