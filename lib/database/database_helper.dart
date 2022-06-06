import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/city.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        cityName TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// cityName, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    print("on fait quelque chode");
    return sql.openDatabase(
      'database.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String cityName) async {
    print("ajour de $cityName");
    final db = await SQLHelper.db();

    final data = {'cityName': cityName};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<City>> getItems() async {
    final db = await SQLHelper.db();
    return await db.query('items', orderBy: "id").then((value) {
      List<City> citys = [];
      for (Map<String, dynamic> data in value) {
        citys.add(City(id: data["id"], cityName: data["cityName"]));
      }
      return citys;
    });
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String cityName, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {'cityName': cityName, 'createdAt': DateTime.now().toString()};

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
