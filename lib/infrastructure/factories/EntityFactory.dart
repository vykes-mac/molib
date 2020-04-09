import 'package:flutter/foundation.dart';
import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/entities/BookShelf.dart';
import 'package:molib/domain/factories/IEntityFactory.dart';
import 'package:molib/domain/value_objects/Author.dart';
import 'package:molib/domain/value_objects/ISBN.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';
import 'package:molib/domain/value_objects/Title.dart';
import 'package:uuid/uuid.dart';

class EntityFactory implements IEntityFactory {
  @override
  Book newBook({
    @required Title title,
    @required Author author,
    @required ISBN isbn,
    @required PublishDate publishDate,
  }) {
    return Book(
        id: Identity.fromString(Uuid().v4()),
        title: title,
        author: author,
        isbn: isbn,
        publishDate: publishDate);
  }

  @override
  BookShelf newBookShelf() {
    return BookShelf(id: Identity.fromString(Uuid().v4()));
  }
}
