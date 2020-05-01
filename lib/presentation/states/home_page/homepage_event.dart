part of 'homepage_bloc.dart';

@immutable
abstract class HomePageEvent {
  const HomePageEvent();
  factory HomePageEvent.onBookShelvesRequested() => BookShelvesRequested();
}

class BookShelvesRequested extends HomePageEvent {
  const BookShelvesRequested();
}
