import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:molib/application/boundaries/create_shelf/ICreateShelfUseCase.dart';
import 'package:molib/application/boundaries/get_all_books/BookDto.dart';
import 'package:molib/application/boundaries/get_all_books/IGetAllBooksUseCase.dart';
import 'package:molib/presentation/models/Book.dart';
import 'package:molib/presentation/models/BookShelf.dart';

const BOOKS_PER_SHELF = 6;

class HomePageViewModel {
  List<BookShelf> _shelves = [];

  List<BookShelf> get shelves => _shelves;

  final ICreateShelfUseCase _createShelfUseCase;
  final IGetAllBooksUseCase _getAllBooksUseCase;

  HomePageViewModel(
      {@required ICreateShelfUseCase createShelfUseCase,
      @required IGetAllBooksUseCase getAllBooksUseCase})
      : _createShelfUseCase = createShelfUseCase,
        _getAllBooksUseCase = getAllBooksUseCase;

  Future<void> getBooksOnShelves() async {
    var result = await _getAllBooksUseCase.execute();
    if (result.books.isEmpty) {
      await createShelf();
      return;
    }

    var groupByShelfId = groupBy(result.books, (BookDto book) => book.shelfId);
    groupByShelfId.forEach(
      (id, books) => _createShelfWithBooks(id.id, books),
    );

    if (_shelves.last.books.length == BOOKS_PER_SHELF) {
      await createShelf();
    }
  }

  Future<void> createShelf() async {
    var result = await _createShelfUseCase.execute();
    _shelves.add(BookShelf(result.shelfId.id));
  }

  _createShelfWithBooks(String id, List<BookDto> books) {
    BookShelf shelf = BookShelf(id);
    shelf.books = books
        .map(
          (b) => Book(
            id: b.id.id,
            title: b.title.value,
            author: b.author.value,
            isbn: b.isbn.value,
            publishDate: b.publishDate.toString(),
          ),
        )
        .toList();

    _shelves.add(shelf);
  }
}
