import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:molib/presentation/models/Book.dart';
import 'package:molib/presentation/viewmodels/AddBookViewModel.dart';

part 'addbook_event.dart';
part 'addbook_state.dart';

class AddBookBloc extends Bloc<AddBookEvent, AddBookState> {
  AddBookViewModel _viewModel;

  AddBookBloc(this._viewModel);

  void addBook(
          {@required String title,
          @required String author,
          @required String isbn,
          @required String publishDate,
          @required String shelfId}) =>
      add(
        AddBookEvent.onAddBookRequested(
            title: title,
            author: author,
            isbn: isbn,
            publishDate: publishDate,
            shelfId: shelfId),
      );

  @override
  AddBookState get initialState => AddBookState.initial();

  @override
  Stream<AddBookState> mapEventToState(
    AddBookEvent event,
  ) async* {
    try {
      yield AddBookState.bookAdded(
          book: null, isCommitting: true, errMessage: '');
      await _viewModel.addBook(event.title, event.author, event.isbn,
          event.publishDate, event.shelfId);
      yield AddBookState.bookAdded(
          book: _viewModel.book, isCommitting: false, errMessage: '');
    } on Exception catch (e) {
      yield AddBookState.bookAdded(
          book: null, isCommitting: false, errMessage: e.toString());
    }
  }
}
