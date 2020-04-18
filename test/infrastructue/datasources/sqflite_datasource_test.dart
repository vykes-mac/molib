import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/infrastructure/datasources/SqfliteDatasource.dart';
import 'package:molib/infrastructure/models/BookModel.dart';
import 'package:sqflite/sqflite.dart';

class MockSqfliteDatabase extends Mock implements Database {}

void main() {
  SqfliteDatasource sut;
  MockSqfliteDatabase database;

  setUp(() {
    database = MockSqfliteDatabase();
    sut = SqfliteDatasource(db: database);
  });

  var map = {
    "Book_Id": "aaa",
    "Shelf_Id": "bbb",
    "Title": "Title",
    "Author": "Author",
    "ISBN": "ISBN-10: 0-596-52068-9",
    "Publish_Date": "2020-01-20"
  };
  group('SqfliteDatasource.addBook', () {
    test('should perform a database insert', () async {
      //arrange
      var bookModel = BookModel.fromMap(map);
      when(database.insert('books', bookModel.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace))
          .thenAnswer((_) async => 1);
      //act
      await sut.addBook(bookModel);

      //assert
      verify(database.insert('books', bookModel.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace))
          .called(1);
    });
  });

  group('SqfliteDatasource.findBook', () {
    test('should perform a database qurey and return a matching record',
        () async {
      //arrange
      when(database.query('books',
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => [map]);
      //act
      var bookModel = await sut.findBook(Identity.fromString('aaa'));

      //assert
      expect(bookModel, isNotNull);
      expect(bookModel.id.id, 'aaa');
    });
  });

  group('SqfliteDatasource.findAllBooks', () {
    test('should perform database query and return all records', () async {
      //arrange
      when(database.query('books')).thenAnswer((_) async => [map]);

      //act
      var bookModels = await sut.findAllBooks();

      //assert
      expect(bookModels, isNotEmpty);
      verify(database.query('books'));
    });
  });
}
