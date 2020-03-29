import 'package:flutter/foundation.dart';
import 'package:molib/domain/value_objects/Author.dart';
import 'package:molib/domain/value_objects/ISBN.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';
import 'package:molib/domain/value_objects/Title.dart';

class AddBookOutput {
  final Identity bookId;
  final Identity shelfId;
  final Title title;
  final Author author;
  final ISBN isbn;
  final PublishDate publishDate;

  const AddBookOutput({
    @required this.bookId,
    @required this.shelfId,
    @required this.title,
    @required this.author,
    @required this.isbn,
    @required this.publishDate,
  });
}
