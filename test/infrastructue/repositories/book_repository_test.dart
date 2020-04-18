import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/value_objects/Author.dart';
import 'package:molib/domain/value_objects/ISBN.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';
import 'package:molib/domain/value_objects/Title.dart';
import 'package:molib/infrastructure/datasources/IDatasource.dart';
import 'package:molib/infrastructure/models/BookModel.dart';
import 'package:molib/infrastructure/repositories/BookRepsitory.dart';

class MockDatasource extends Mock implements IDatasource {}

void main() {
  BookRepository sut;
  MockDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockDatasource();
    sut = BookRepository(datasource: mockDatasource);
  });

  group('BookRepository.add', () {
    var title = Title.create('Domain Driven Design').getOrElse(null);
    var author = Author.create('Vaugh Vernon').getOrElse(null);
    var isbn = ISBN.create('ISBN-10: 0-596-52068-9').getOrElse(null);
    var publishDate = PublishDate.create('2019-01-20').getOrElse(null);

    var book = Book(
      id: Identity.fromString('aaa'),
      title: title,
      author: author,
      isbn: isbn,
      publishDate: publishDate,
    );

    test('should add a book when call to the datasource is successful',
        () async {
      //act
      await sut.add(book);

      //assert
      verify(mockDatasource.addBook(any)).called(1);
    });
  });

  group('BookRepository.findAll', () {
    test(
        'should return a list of books when the call to the datasource is successful',
        () async {
      //arrange
      var map = {
        "Book_Id": "aaa",
        "Shelf_id": "bbb",
        "Title": "Title",
        "Author": "Author",
        "ISBN": "ISBN-10: 0-596-52068-9",
        "Publish_Date": "2020-01-20"
      };
      when(mockDatasource.findAllBooks())
          .thenAnswer((_) async => [BookModel.fromMap(map)]);
      //act
      var books = await sut.findAll();

      //assert
      expect(books, isNotEmpty);
      verify(mockDatasource.findAllBooks()).called(1);
    });
  });

  group('BookRepository.find', () {
    test('should return a books when the call to the datasource is successful',
        () async {
      //arrange
      var map = {
        "Book_Id": "aaa",
        "Shelf_id": "bbb",
        "Title": "Title",
        "Author": "Author",
        "ISBN": "ISBN-10: 0-596-52068-9",
        "Publish_Date": "2020-01-20"
      };
      when(mockDatasource.findBook(any))
          .thenAnswer((_) async => BookModel.fromMap(map));
      //act
      var book = await sut.find(bookId: Identity.fromString('aaa'));

      //assert
      expect(book, isNotNull);
      verify(mockDatasource.findBook(any)).called(1);
    });
  });
}
