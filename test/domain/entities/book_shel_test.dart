import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;
import 'package:molib/domain/DomainExcpetion.dart';
import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/entities/BookShelf.dart';
import 'package:molib/domain/value_objects/Identity.dart';

void main() {
  BookShelf sut;

  setUp(() {
    sut = BookShelf(id: Identity.fromString('aaa'));
  });

  group('BookShelf', () {
    test(
        'addBook should throw and DomainException when bookshelf exceeds its capacity',
        () {
      //arrange
      for (int i = 0; i < 10; i++) {
        sut.addBook(Book());
      }

      expect(() => sut.addBook(Book()),
          throwsA(matcher.TypeMatcher<DomainException>()));
    });

    test('addBook should add book to shelf', () {
      //arrange
      var book = Book();

      //act
      sut.addBook(book);

      //assert
      expect(sut.books.length, 1);
    });
  });
}
