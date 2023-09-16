import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class SqlHelper {
  Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE cities(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      city TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  Future<sql.Database> db() async {
    final path = await sql.getDatabasesPath();
    final fullPath = join(path, 'weather.db');

    return sql.openDatabase(
      fullPath,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> createData(String city) async {
    final db = await SqlHelper().db();

    final data = {"city": city};
    final id = await db.insert(
      "cities",
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SqlHelper().db();
    return db.query("cities", orderBy: "id");
  }

  Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SqlHelper().db();
    return db.query("cities", where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Future<int> updateData(int id, String city) async {
  //   final db = await SqlHelper().db();
  //   final data = {
  //     'city': city,
  //     'createdAt': DateTime.now().toString(),
  //   };
  //   final result =
  //       await db.update('cities', data, where: 'id = ?', whereArgs: [id]);
  //   return result;
  // }

  Future<void> deleteData(int id) async {
    final db = await SqlHelper().db();
    await db.delete("cities", where: "id = ?", whereArgs: [id]);
  }
}
