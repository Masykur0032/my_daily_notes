import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import 'model/notes.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'mydailynote.db';

    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);

    return itemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS note');
    await db.execute('''
    CREATE TABLE note (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      body TEXT,
      date TEXT
    )
    ''');
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('note', orderBy: 'id');
    return mapList;
  }

  Future<int> insert(Note object) async {
    Database db = await this.initDb();
    int count = await db.insert('note', object.toMap());
    return count;
  }

  Future<int> update(Note object) async {
    Database db = await this.initDb();
    int count = await db
        .update('note', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('note', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Note>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Note> itemList = List<Note>();
    for (int i = 0; i < count; i++) {
      itemList.add(Note.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
