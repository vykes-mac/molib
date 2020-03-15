import 'package:flutter/foundation.dart';
import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/value_objects/Identity.dart';

abstract class IBookRepository {
  add(Book book);
  update(Book book);
  delete({@required Identity bookId});
  find({@required Identity bookId});
  findAll();
}
