import 'package:flutter_test/flutter_test.dart';
import 'package:molib/application/usecases/CreateShelfUseCase.dart';
import 'package:molib/application/usecases/GetAllBookUseCase.dart';
import 'package:molib/infrastructure/factories/EntityFactory.dart';
import 'package:molib/infrastructure/models/BookModel.dart';
import 'package:molib/infrastructure/repositories/fakes/FakeBookRepository.dart';
import 'package:molib/infrastructure/repositories/fakes/FakeShelfRepository.dart';
import 'package:molib/presentation/viewmodels/HomeViewModel.dart';

void main() {
  HomePageViewModel sut;
  CreateShelfUseCase createShelfUseCase;
  GetAllBooksUseCase getAllBooksUseCase;
  FakeBookRepository fakeBookRepository;
  FakeShelfRepository fakeShelfRepository;
  EntityFactory entityFactory;
  setUp(() {
    entityFactory = EntityFactory();
    fakeShelfRepository = FakeShelfRepository();
    fakeBookRepository = FakeBookRepository();

    getAllBooksUseCase = GetAllBooksUseCase(bookRepository: fakeBookRepository);
    createShelfUseCase = CreateShelfUseCase(fakeShelfRepository, entityFactory);

    sut = HomePageViewModel(
      createShelfUseCase: createShelfUseCase,
      getAllBooksUseCase: getAllBooksUseCase,
    );
  });

  group('HomePageViewModel.getBooksOnShelves', () {
    test('should create an empty shelf when no books in storage', () async {
      //arrange
      fakeBookRepository.books = [];
      //act
      await sut.getBooksOnShelves();
      //assert
      expect(sut.shelves.length, 1);
      expect(sut.shelves.first.books, isEmpty);
    });

    test('should return books from storage and group by shelf', () async {
      //act
      await sut.getBooksOnShelves();
      //assert
      expect(sut.shelves, isNotEmpty);
      expect(sut.shelves.first.books, isNotEmpty);
    });

    test('create empty shelf if last shelf reaches maximum capacity', () async {
      //arrange
      var map = {
        "Book_Id": "aaa",
        "Shelf_Id": "bbb",
        "Title": "Red Rose",
        "Author": "Jan Jensen",
        "ISBN": "ISBN-10: 0-596-52068-9",
        "Publish_Date": "2020-01-20"
      };
      fakeBookRepository.books.add(BookModel.fromMap(map));
      //act
      await sut.getBooksOnShelves();
      //assert
      expect(sut.shelves[sut.shelves.length - 2].books.length, BOOKS_PER_SHELF);
      expect(sut.shelves.last.books, isEmpty);
    });
  });
}
