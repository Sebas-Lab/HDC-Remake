import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hdc_remake/models/hymn.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import '../models/songbook.dart';

class DatabaseHelper {

  final _databaseName = "HymnsDatabase.db";
  final _databaseVersion = 1;

  final table = 'hymns';

  final columnId = 'id';
  final columnName = 'name';
  final columnLyrics = 'lyrics';

  // Singleton constructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnLyrics TEXT NOT NULL
    )
    ''');
  }

  Future<int> insert(Hymn hymn) async {
    Database db = await instance.database;
    return await db.insert(table, hymn.toMap());
  }

  Future<int> update(Hymn hymn) async {
    Database db = await instance.database;
    return await db.update(
      table,
      hymn.toMap(),
      where: '$columnId = ?',
      whereArgs: [hymn.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<Hymn?> getHymn(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Hymn.fromMap(maps.first);
    }

    return null;
  }

  Future<List<Hymn>> getAllHymns() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Hymn.fromMap(maps[i]);
    });
  }

  Future<List<Hymn>> _loadHymnsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/sample_hymns.json');
    final List<dynamic> hymnsJson = jsonDecode(jsonString);
    return hymnsJson.map((hymn) => Hymn.fromMap(hymn)).toList();
  }

  Future<void> populateDatabase() async {
    List<Hymn> hymns = await _loadHymnsFromJson();
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    for (Hymn hymn in hymns) {
      await dbHelper.insert(hymn);
    }
  }

  Future<List<Hymn>> searchHymnsByName(String query) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: "$columnName LIKE ?",
      whereArgs: ['%$query%'],
    );

    return List.generate(maps.length, (i) {
      return Hymn.fromMap(maps[i]);
    });
  }

  Future<List<Songbook>> getSongbooks() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('name');

    return List.generate(maps.length, (i) {
      return Songbook.fromJson(maps[i]);
    });
  }
}