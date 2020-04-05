import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:molib/application/usecases/GetAllBookUseCase.dart';
import 'package:molib/domain/entities/Book.dart';

import 'add_book_usecase_test.dart';

void main() {
  GetAllBooksUseCase sut;
  MockBookRepository mockBookRepository;

  setUp(() {
    mockBookRepository = MockBookRepository();
    sut = GetAllBooksUseCase(bookRepository: mockBookRepository);
  });

  group('GetAllBooksUseCase', () {
    test('should return an empty list when no books are found', () async {
      //arrange
      when(mockBookRepository.findAll()).thenAnswer((_) async => []);

      //act
      var result = await sut.execute();

      //assert
      expect(result.books, isEmpty);
    });

    test('should return list of books', () async {
      //arrange
      var books = [Book()];
      when(mockBookRepository.findAll()).thenAnswer((_) async => books);

      //act
      var result = await sut.execute();

      //assert
      expect(result.books, isNotEmpty);
      verify(mockBookRepository.findAll());
    });
  });
}
