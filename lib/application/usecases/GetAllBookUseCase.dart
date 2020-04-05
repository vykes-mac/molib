import 'dart:collection';

import 'package:molib/application/boundaries/get_all_books/BookDto.dart';
import 'package:molib/application/boundaries/get_all_books/GetAllBooksOutput.dart';
import 'package:molib/application/boundaries/get_all_books/IGetAllBooksUseCase.dart';
import 'package:molib/domain/repositories/IBookRepository.dart';

class GetAllBooksUseCase implements IGetAllBooksUseCase {
  final IBookRepository _bookRepository;

  GetAllBooksUseCase({IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  @override
  Future<GetAllBooksOutput> execute() async {
    var books = await _bookRepository.findAll();

    List<BookDto> output =
        books.map((book) => BookDto.fromEntity(book)).toList();
    return GetAllBooksOutput(books: UnmodifiableListView(output));
  }
}
