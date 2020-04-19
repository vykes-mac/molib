import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/infrastructure/models/BookModel.dart';
import 'package:molib/infrastructure/models/ShelfModel.dart';

abstract class IDatasource {
  addBook(BookModel model);
  Future<List<BookModel>> findAllBooks();
  Future<BookModel> findBook(Identity bookId);
  Future<void> createShelf(ShelfModel model);
  Future<ShelfModel> findShelf(Identity shelfId);
  Future<List<BookModel>> findBooksOnSelf(Identity shelfId);
}
