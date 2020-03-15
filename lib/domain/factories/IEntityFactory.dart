import 'package:flutter/foundation.dart';
import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/entities/BookShelf.dart';
import 'package:molib/domain/value_objects/Author.dart';
import 'package:molib/domain/value_objects/ISBN.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';
import 'package:molib/domain/value_objects/Title.dart';

abstract class IEntityFactory {
  Book newBook({
    @required Title title,
    @required Author author,
    @required ISBN isbn,
    @required PublishDate publishDate,
  });

  BookShelf newBookShelf();
}
