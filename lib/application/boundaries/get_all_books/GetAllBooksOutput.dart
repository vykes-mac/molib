import 'dart:collection';

import 'BookDto.dart';

class GetAllBooksOutput {
  final UnmodifiableListView<BookDto> books;

  GetAllBooksOutput({this.books});
}
