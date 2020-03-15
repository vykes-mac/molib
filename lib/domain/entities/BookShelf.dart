import 'package:flutter/foundation.dart';
import 'package:molib/domain/value_objects/Identity.dart';

import '../DomainExcpetion.dart';
import 'Book.dart';

class BookShelf {
  static const MAX_CAPACITY = 10;
  Identity id;
  List<Book> _books;
  List<Book> get books => _books;

  BookShelf({@required this.id}) {
    _books = List();
  }

  addBook(Book book) {
    if (_books.length == MAX_CAPACITY)
      throw DomainException('Book shelf has reached maximum capacity');
    book.shelfId = id;
    _books.add(book);
  }
}
