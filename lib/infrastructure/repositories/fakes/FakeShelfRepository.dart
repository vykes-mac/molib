import 'package:molib/domain/entities/BookShelf.dart';
import 'package:molib/domain/repositories/IBookShelfRepository.dart';
import 'package:molib/domain/value_objects/Identity.dart';

class FakeShelfRepository implements IBookShelfRepository {
  List<BookShelf> shelves = [BookShelf(id: Identity.fromString('bbb'))];

  @override
  Future<void> create(BookShelf bookShelf) async {
    return shelves.add(bookShelf);
  }

  @override
  Future<BookShelf> find(Identity shelfId) async {
    return shelves.where((sh) => sh.id == shelfId).first;
  }
}
