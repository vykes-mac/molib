import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/value_objects/Author.dart';
import 'package:molib/domain/value_objects/ISBN.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';
import 'package:molib/domain/value_objects/Title.dart';

class BookDto {
  Identity id;
  Identity shelfId;
  Title title;
  Author author;
  ISBN isbn;
  PublishDate publishDate;

  BookDto({
    this.id,
    this.shelfId,
    this.title,
    this.author,
    this.isbn,
    this.publishDate,
  });

  BookDto.fromEntity(Book book)
      : id = book.id,
        shelfId = book.shelfId,
        title = book.title,
        author = book.author,
        isbn = book.isbn,
        publishDate = book.publishDate;
}
