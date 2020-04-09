import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/infrastructure/models/BookModel.dart';

abstract class IDatasource {
  add(BookModel model);
  Future<List<BookModel>> findAll();
  Future<BookModel> find(Identity bookId);
}
