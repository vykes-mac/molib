import 'package:molib/domain/entities/BookShelf.dart';
import 'package:molib/domain/value_objects/Identity.dart';

abstract class IBookShelfRepository {
  add(BookShelf bookShelf);
  update(BookShelf bookShelf);
  find(Identity shelfId);
}
