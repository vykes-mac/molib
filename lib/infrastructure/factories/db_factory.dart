import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFactory {
  Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'molib.db');

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  void populateDb(Database db, int version) async {
    await _createBookTable(db);
    await _createShelfTable(db);
  }

  _createBookTable(Database db) async {
    await db
        .execute(
          """CREATE TABLE books(
            Book_Id TEXT PRIMARY KEY,
            Shelf_Id TEXT,
            Title TEXT,
            Author Text,
            ISBN TEXT,
            Publish_Date TEXT)""",
        )
        .then((_) => print('creating table books...'))
        .catchError((e) => print('error creating books table: $e'));
  }

  _createShelfTable(Database db) async {
    await db
        .execute("""
          CREATE TABLE shelf(Shelf_Id TEXT PRIMARY KEY)
      """)
        .then((_) => print('creating table shelf'))
        .catchError((e) => print('error creating shelf table: $e'));
  }
}
