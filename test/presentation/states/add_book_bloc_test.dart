import 'package:flutter_test/flutter_test.dart';
import 'package:molib/application/boundaries/add_book/IAddBookUseCase.dart';
import 'package:molib/application/usecases/AddBookUseCase.dart';
import 'package:molib/domain/factories/IEntityFactory.dart';
import 'package:molib/infrastructure/factories/EntityFactory.dart';
import 'package:molib/infrastructure/repositories/fakes/FakeBookRepository.dart';
import 'package:molib/infrastructure/repositories/fakes/FakeShelfRepository.dart';
import 'package:molib/presentation/states/add_book_page/addbook_bloc.dart';
import 'package:molib/presentation/viewmodels/AddBookViewModel.dart';

void main() {
  AddBookBloc sut;
  AddBookViewModel viewModel;
  IAddBookUseCase addBookUseCase;
  IEntityFactory entityFactory;
  setUp(() {
    entityFactory = EntityFactory();
    addBookUseCase = AddBookUseCase(
        bookShelfRepository: FakeShelfRepository(),
        bookRepository: FakeBookRepository(),
        entityFactory: entityFactory);

    viewModel = AddBookViewModel(addBookUseCase);

    sut = AddBookBloc(viewModel);
  });

  tearDown(() => sut.close());

  group('AddBookPageBloc.addBook', () {
    test('should return error state with messages when invalid inputs',
        () async {
      //arrange
      var title = "Title";
      var author = "Author";
      var isbn = "ISBN-10: 0-596-52068-9";
      var publishDate = "";
      var shelfId = "bbb";

      List<AddBookState> states = [];

      //act
      sut.addBook(
        title: title,
        author: author,
        isbn: isbn,
        publishDate: publishDate,
        shelfId: shelfId,
      );

      //assert
      sut
          .listen((state) => states.add(state))
          .asFuture()
          .whenComplete(() => expect(states.last.errMessage, isNotEmpty));
    });

    test('should return state with created book', () async {
      //arrange
      var title = "Title";
      var author = "Author";
      var isbn = "ISBN-10: 0-596-52068-9";
      var publishDate = "2020-01-01";
      var shelfId = "bbb";

      List<AddBookState> states = [];

      //act
      sut.addBook(
        title: title,
        author: author,
        isbn: isbn,
        publishDate: publishDate,
        shelfId: shelfId,
      );

      //assert
      sut
          .listen((state) => states.add(state))
          .asFuture()
          .whenComplete(() => expect(states.last.book.id, isNotEmpty));
    });
  });
}
