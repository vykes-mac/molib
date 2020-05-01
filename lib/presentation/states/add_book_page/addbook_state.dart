part of 'addbook_bloc.dart';

@immutable
abstract class AddBookState {
  final Book book;
  final String errMessage;
  final bool isCommitting;
  const AddBookState(
    this.book,
    this.isCommitting,
    this.errMessage,
  );

  factory AddBookState.initial() =>
      _AddBookState(book: null, errMessage: '', isCommitting: false);

  factory AddBookState.bookAdded(
          {Book book, String errMessage, bool isCommitting}) =>
      _AddBookState(
        book: book,
        errMessage: errMessage,
        isCommitting: isCommitting,
      );
}

class _AddBookState extends AddBookState {
  final Book book;
  final String errMessage;
  final bool isCommitting;
  const _AddBookState({
    this.book,
    this.isCommitting,
    this.errMessage,
  }) : super(
          book,
          isCommitting,
          errMessage,
        );
}
