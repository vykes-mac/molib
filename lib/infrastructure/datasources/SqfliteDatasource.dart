import 'package:flutter/foundation.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/infrastructure/datasources/IDatasource.dart';
import 'package:molib/infrastructure/models/BookModel.dart';
import 'package:molib/infrastructure/models/ShelfModel.dart';
import 'package:sqflite/sqlite_api.dart';

class SqfliteDatasource implements IDatasource {
  final Database _db;
  const SqfliteDatasource({@required Database db}) : _db = db;

  @override
  addBook(BookModel model) async {
    await _db.insert('books', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<BookModel>> findAllBooks() async {
    var listOfMaps = await _db.query('books');
    if (listOfMaps.isEmpty) return [];

    return listOfMaps.map<BookModel>((map) => BookModel.fromMap(map)).toList();
  }

  @override
  Future<BookModel> findBook(Identity bookId) async {
    var listOfMaps = await _db.query(
      'books',
      where: 'Book_Id = ?',
      whereArgs: [bookId.id],
    );
    return BookModel.fromMap(listOfMaps.first);
  }

  @override
  Future<void> createShelf(ShelfModel model) async {
    return await _db.insert('shelf', model.toMap());
  }

  @override
  Future<List<BookModel>> findBooksOnSelf(Identity shelfId) async {
    var listOfMaps = await _db.query(
      'books',
      where: 'Shelf_Id = ?',
      whereArgs: [shelfId.id],
    );

    return listOfMaps.map<BookModel>((map) => BookModel.fromMap(map)).toList();
  }

  @override
  Future<ShelfModel> findShelf(Identity shelfId) async {
    var listOfMaps = await _db.query(
      'shelf',
      where: 'Shelf_Id = ?',
      whereArgs: [shelfId.id],
    );
    return ShelfModel.fromMap(listOfMaps.first);
  }
}
