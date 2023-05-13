import 'package:hdc_remake/application_dependencies/app_dependencies.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  final _databaseName = "HymnsDatabase.db";
  final _databaseVersion = 1;

  final table = 'hymns';

  final columnId = 'id';
  final columnName = 'name';
  final columnLyrics = 'lyrics';
  final columnSongbookId = 'songbookId';
  final columnAudioURL = 'audioURL';

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

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER NOT NULL,
      $columnName TEXT NOT NULL,
      $columnLyrics TEXT NOT NULL,
      $columnSongbookId INTEGER NOT NULL,
      $columnAudioURL TEXT NULL,
      PRIMARY KEY ($columnId, $columnSongbookId)
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

  Future<List<Hymn>> getHymnsBySongbookId(int songbookId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(table, where: '$columnSongbookId = ?', whereArgs: [songbookId]);
    return result.map((hymnMap) => Hymn.fromMap(hymnMap)).toList();
  }

  Future<int> deleteAllHymns() async {
    Database db = await instance.database;
    return await db.delete(table);
  }

  // En DatabaseHelper.dart
  Future<int> deleteHymnsBySongbookId(int songbookId) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: 'songbookId = ?',
      whereArgs: [songbookId],
    );
  }

  Future<List<Hymn>> loadLocalHymns(int songbookId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(table, where: 'songbookId = ?', whereArgs: [songbookId]);
    return result.map((map) => Hymn.fromMap(map)).toList();
  }

  Future<int> getHymnCountBySongbookId(int songbookId) async {
    final db = await database;
    var result = await db.rawQuery('SELECT COUNT(*) FROM hymns WHERE songbookId = ?', [songbookId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Hymn>> loadHymns(int songbookId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: "$columnSongbookId = ?",
      whereArgs: [songbookId],
    );

    return List.generate(maps.length, (i) {
      return Hymn.fromMap(maps[i]);
    });
  }

  Future<String?> getHymnbookVersion(int songbookId) async {
    Database db = await instance.database;
    String tableName = 'book';
    var result = await db.query(tableName, columns: ['version'], where: 'id = ?', whereArgs: [songbookId]);
    if (result.isNotEmpty) {
      return result.first['version'] as String?;
    } else {
      return null;
    }
  }
}