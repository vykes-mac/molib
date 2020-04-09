import 'package:flutter_test/flutter_test.dart';
import 'package:molib/domain/value_objects/Author.dart';
import 'package:molib/domain/value_objects/ISBN.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';
import 'package:molib/domain/value_objects/Title.dart';
import 'package:molib/infrastructure/factories/EntityFactory.dart';

void main() {
  EntityFactory sut;

  setUp(() {
    sut = EntityFactory();
  });

  test('should create a book from the provided information', () {
    //arrange
    var title = Title.create('Domain Driven Design').getOrElse(null);
    var author = Author.create('Vaugh Vernon').getOrElse(null);
    var isbn = ISBN.create('ISBN-10: 0-596-52068-9').getOrElse(null);
    var publishDate = PublishDate.create('2019-01-20').getOrElse(null);

    //act
    var book = sut.newBook(
      title: title,
      author: author,
      isbn: isbn,
      publishDate: publishDate,
    );

    //assert
    expect(book.id, isNotNull);
    expect(book.title, title);
  });
}
