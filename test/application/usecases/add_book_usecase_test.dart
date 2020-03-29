import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:molib/application/boundaries/add_book/AddBookInput.dart';
import 'package:molib/application/usecases/AddBookUseCase.dart';
import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/entities/BookShelf.dart';
import 'package:molib/domain/factories/IEntityFactory.dart';
import 'package:molib/domain/repositories/IBookRepository.dart';
import 'package:molib/domain/repositories/IBookShelfRepository.dart';
import 'package:molib/domain/value_objects/Author.dart';
import 'package:molib/domain/value_objects/ISBN.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';
import 'package:molib/domain/value_objects/Title.dart';

class MockShelfRepository extends Mock implements IBookShelfRepository {}

class MockBookRepository extends Mock implements IBookRepository {}

class MockEntityFactory extends Mock implements IEntityFactory {}

void main() {
  AddBookUseCase sut;
  MockShelfRepository mockShelfRepository;
  MockBookRepository mockBookRepository;
  MockEntityFactory mockEntityFactory;

  setUp(() {
    mockBookRepository = MockBookRepository();
    mockShelfRepository = MockShelfRepository();
    mockEntityFactory = MockEntityFactory();

    sut = AddBookUseCase(
        bookShelfRepository: mockShelfRepository,
        bookRepository: mockBookRepository,
        entityFactory: mockEntityFactory);
  });

  group('AddBookUseCase', () {
    var title = Title.create('Book Title').getOrElse(null);
    var author = Author.create('Book Author').getOrElse(null);
    var isbn = ISBN.create('ISBN-10: 0-596-52068-9').getOrElse(null);
    var publishDate = PublishDate.create('2020-01-20').getOrElse(null);

    var input = AddBookInput(
        shelfId: Identity.fromString('add'),
        title: title,
        author: author,
        isbn: isbn,
        publishDate: publishDate);

    test('should return a Failure when bookshelf does not exist', () async {
      //arrange
      when(mockShelfRepository.find(input.shelfId)).thenAnswer((_) => null);

      //act
      var result = await sut.execute(input);

      //assert
      expect(result.isLeft(), true);
    });

    test('should return book with created id when added succesfully', () async {
      //arrange
      when(mockShelfRepository.find(input.shelfId))
          .thenAnswer((_) => BookShelf(id: input.shelfId));

      when(mockEntityFactory.newBook(
              title: anyNamed('title'),
              author: anyNamed('author'),
              isbn: anyNamed('isbn'),
              publishDate: anyNamed('publishDate')))
          .thenReturn(
        Book(
            id: Identity.fromString('bb'),
            title: input.title,
            author: input.author,
            isbn: input.isbn,
            publishDate: input.publishDate),
      );

      //act
      var result = await sut.execute(input);

      //assert
      expect(result.isRight(), true);
      expect(result.getOrElse(null).bookId, isNotNull);
      verify(mockBookRepository.add(any)).called(1);
      verify(mockShelfRepository.update(any)).called(1);
    });
  });
}
