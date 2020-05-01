part of 'addbook_bloc.dart';

@immutable
abstract class AddBookEvent {
  final String title;
  final String author;
  final String isbn;
  final String publishDate;
  final String shelfId;

  const AddBookEvent(
    this.title,
    this.author,
    this.isbn,
    this.publishDate,
    this.shelfId,
  );

  factory AddBookEvent.onAddBookRequested({
    @required String title,
    @required String author,
    @required String isbn,
    @required String publishDate,
    @required String shelfId,
  }) =>
      _AddBookEvent(
        title,
        author,
        isbn,
        publishDate,
        shelfId,
      );
}

class _AddBookEvent extends AddBookEvent {
  final String title;
  final String author;
  final String isbn;
  final String publishDate;
  final String shelfId;

  const _AddBookEvent(
    this.title,
    this.author,
    this.isbn,
    this.publishDate,
    this.shelfId,
  ) : super(
          title,
          author,
          isbn,
          publishDate,
          shelfId,
        );
}
