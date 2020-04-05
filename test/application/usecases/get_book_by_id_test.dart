import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:molib/application/boundaries/get_book_by_id/GetBookByIdInput.dart';
import 'package:molib/application/usecases/GetBookByIdUseCase.dart';
import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/value_objects/Identity.dart';

import 'add_book_usecase_test.dart';

void main() {
  GetBookByIdUseCase sut;
  MockBookRepository mockBookRepository;

  setUp(() {
    mockBookRepository = MockBookRepository();
    sut = GetBookByIdUseCase(bookRepository: mockBookRepository);
  });

  group('GetBookByIdUseCase', () {
    var input = GetBookByIdInput(bookId: Identity.fromString('aaaa'));

    test('should a Failure when book was not found', () async {
      //arrange
      when(mockBookRepository.find(bookId: null)).thenAnswer((_) => null);

      //act
      var result = await sut.execute(input);

      //assert
      expect(result.isLeft(), true);
    });

    test('should return book when it is found', () async {
      //arrange
      var book = Book();
      when(mockBookRepository.find(bookId: input.bookId))
          .thenAnswer((_) async => book);

      // act
      var result = await sut.execute(input);

      //assert
      expect(result.isRight(), true);
      verify(mockBookRepository.find(bookId: input.bookId));
    });
  });
}
