part of 'homepage_bloc.dart';

@immutable
abstract class HomePageState {
  final List<BookShelf> shelves;
  final bool isFetching;
  final String errMessages;

  HomePageState({this.shelves, this.isFetching, this.errMessages});

  factory HomePageState.initial() =>
      _HomePageState(shelves: [], isFetching: false, errMessages: '');

  factory HomePageState.onBookShelvesRequested({
    List<BookShelf> shelves,
    bool isFetching,
    String errorMessage,
  }) =>
      _HomePageState(
        shelves: shelves,
        isFetching: isFetching,
        errMessages: errorMessage,
      );
}

class _HomePageState extends HomePageState {
  final List<BookShelf> shelves;
  final bool isFetching;
  final String errMessages;

  _HomePageState({this.shelves, this.isFetching, this.errMessages})
      : super(
          shelves: shelves,
          isFetching: isFetching,
          errMessages: errMessages,
        );
}
