import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;
import 'package:molib/application/usecases/AddBookUseCase.dart';
import 'package:molib/infrastructure/factories/EntityFactory.dart';
import 'package:molib/infrastructure/repositories/fakes/FakeBookRepository.dart';
import 'package:molib/infrastructure/repositories/fakes/FakeShelfRepository.dart';
import 'package:molib/presentation/viewmodels/AddBookViewModel.dart';

void main() {
  AddBookViewModel sut;
  AddBookUseCase addBookUseCase;
  FakeBookRepository fakeBookRepository;
  FakeShelfRepository fakeShelfRepository;
  EntityFactory entityFactory;

  setUp(() {
    fakeShelfRepository = FakeShelfRepository();
    fakeBookRepository = FakeBookRepository();
    entityFactory = EntityFactory();

    addBookUseCase = AddBookUseCase(
        bookShelfRepository: fakeShelfRepository,
        bookRepository: fakeBookRepository,
        entityFactory: entityFactory);

    sut = AddBookViewModel(addBookUseCase);
  });

  group('AddBookViewModel.addBook', () {
    String title = "";
    String author = "Jan Jensen";
    String isbn = "ISBN-10: 0-596-52068-9";
    String publishDate = "2020-01-01";
    String shelfId = "bbb";
    test('should throw Exception when errors with input', () {
      //assert
      expect(() => sut.addBook(title, author, isbn, publishDate, shelfId),
          throwsA(matcher.TypeMatcher<Exception>()));
    });

    test('should add book successfully and return book with id', () async {
      //arrange
      var atitle = "Red Book";
      //act

      await sut.addBook(atitle, author, isbn, publishDate, shelfId);

      //assert
      expect(sut.book, isNotNull);
      expect(sut.book.id, isNotNull);
    });
  });
}
