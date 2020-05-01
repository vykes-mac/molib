import 'package:flutter_test/flutter_test.dart';
import 'package:molib/application/boundaries/create_shelf/ICreateShelfUseCase.dart';
import 'package:molib/application/boundaries/get_all_books/IGetAllBooksUseCase.dart';
import 'package:molib/application/usecases/CreateShelfUseCase.dart';
import 'package:molib/application/usecases/GetAllBookUseCase.dart';
import 'package:molib/domain/factories/IEntityFactory.dart';
import 'package:molib/infrastructure/factories/EntityFactory.dart';
import 'package:molib/infrastructure/repositories/fakes/FakeBookRepository.dart';
import 'package:molib/infrastructure/repositories/fakes/FakeShelfRepository.dart';
import 'package:molib/presentation/states/home_page/homepage_bloc.dart';
import 'package:molib/presentation/viewmodels/HomeViewModel.dart';

void main() {
  HomePageBloc sut;
  HomePageViewModel viewModel;
  IGetAllBooksUseCase getAllBooksUseCase;
  ICreateShelfUseCase createShelfUseCase;
  IEntityFactory entityFactory;
  setUp(() {
    entityFactory = EntityFactory();
    createShelfUseCase =
        CreateShelfUseCase(FakeShelfRepository(), entityFactory);
    getAllBooksUseCase =
        GetAllBooksUseCase(bookRepository: FakeBookRepository());
    viewModel = HomePageViewModel(
      getAllBooksUseCase: getAllBooksUseCase,
      createShelfUseCase: createShelfUseCase,
    );
    sut = HomePageBloc(viewModel);
  });

  tearDown(() => sut.close());

  group('HomePageBloc.getBooksOnShelves', () {
    test('should return shelf with books from fake repository', () async {
      //arrange
      var idx = 0;

      //act
      sut.getBooksOnShelves();

      //assert
      sut.listen(expectAsync1((state) {
        _expectedStates(state, idx);
        idx++;
      }, count: 3));
    });
  });
}

void _expectedStates(HomePageState state, int idx) {
  var expectedStates = [
    {'numOfShelves': 0, 'isFetching': false, 'errMessage': ''},
    {'numOfShelves': 0, 'isFetching': true, 'errMessage': ''},
    {'numOfShelves': 1, 'isFetching': false, 'errMessage': ''}
  ];

  expect(state.shelves.length, expectedStates[idx]['numOfShelves']);
  expect(state.isFetching, expectedStates[idx]['isFetching']);
  expect(state.errMessages, expectedStates[idx]['errMessage']);
}
