import 'package:flutter/foundation.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String isbn;
  final String publishDate;

  const Book({
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.isbn,
    @required this.publishDate,
  });
}
