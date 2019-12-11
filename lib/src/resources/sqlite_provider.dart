import 'package:path/path.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:sqflite/sqflite.dart' as sqlite;

class SqliteProvider {
  Future<String> getDatabasePath() async {
    String databasesPath = await sqlite.getDatabasesPath();
    return join(databasesPath, 'tele-sportifs.db');
  }

  Future<sqlite.Database> openDatabase(String path) async {
    return await sqlite.openDatabase(path, version: 1,
        onCreate: (sqlite.Database db, int version) async {
      await db.execute(
          "CREATE TABLE sport (id STRING, logo STRING, libelle STRING, 'order' INTEGER)");
    });
  }

  Future insertSportList(List<Sport> sportList) async {
    String path = await this.getDatabasePath();
    sqlite.Database db = await this.openDatabase(path);

    await db.transaction((txn) async {
      for (Sport sport in sportList) {
        await txn.rawInsert(
            "INSERT INTO sport(id, libelle, logo, 'order') VALUES(?, ?, ?, ?)",
            [sport.id, sport.libelle, sport.logo, sport.order]);
      }
    });
  }

  Future<List<Sport>> getSportList() async {
    String path = await this.getDatabasePath();
    sqlite.Database db = await this.openDatabase(path);

    List<Map<String, dynamic>> mapList =
        await db.rawQuery('SELECT * FROM sport');
    List<Sport> sportList = new List<Sport>();
    mapList.forEach((map) {
      sportList.add(Sport.fromMap(map['id'], map));
    });

    return sportList;
  }

  Future closeDatabase(sqlite.Database db) async {
    await db.close();
  }
}
