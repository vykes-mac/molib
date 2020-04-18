import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/infrastructure/models/BookModel.dart';

abstract class IDatasource {
  addBook(BookModel model);
  Future<List<BookModel>> findAllBooks();
  Future<BookModel> findBook(Identity bookId);
}
