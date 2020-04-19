import 'package:molib/domain/entities/BookShelf.dart';
import 'package:molib/domain/repositories/IBookShelfRepository.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/infrastructure/datasources/IDatasource.dart';
import 'package:molib/infrastructure/models/BookModel.dart';
import 'package:molib/infrastructure/models/ShelfModel.dart';

class ShelfRepository implements IBookShelfRepository {
  IDatasource _datasource;

  ShelfRepository(this._datasource);

  @override
  create(BookShelf bookShelf) async {
    var shelModel = ShelfModel(id: bookShelf.id);
    return await _datasource.createShelf(shelModel);
  }

  @override
  Future<BookShelf> find(Identity shelfId) async {
    ShelfModel shelf = await _datasource.findShelf(shelfId);
    List<BookModel> books = [];
    if (shelf != null) books = await _datasource.findBooksOnSelf(shelfId);

    BookShelf bookShelf = BookShelf(id: shelfId);
    books.forEach((b) => bookShelf.addBook(b));
    return bookShelf;
  }
}
