import 'package:molib/domain/entities/BookShelf.dart';
import 'package:molib/domain/value_objects/Identity.dart';

abstract class IBookShelfRepository {
  create(BookShelf bookShelf);
  Future<BookShelf> find(Identity shelfId);
}
