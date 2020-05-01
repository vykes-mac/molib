import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:molib/presentation/models/BookShelf.dart';
import 'package:molib/presentation/viewmodels/HomeViewModel.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HomePageViewModel _viewModel;

  void getBooksOnShelves() => add(HomePageEvent.onBookShelvesRequested());

  HomePageBloc(this._viewModel);

  @override
  HomePageState get initialState => HomePageState.initial();

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    try {
      yield HomePageState.onBookShelvesRequested(
        shelves: [],
        isFetching: true,
        errorMessage: '',
      );
      await _viewModel.getBooksOnShelves();
      yield HomePageState.onBookShelvesRequested(
        shelves: _viewModel.shelves,
        isFetching: false,
        errorMessage: '',
      );
    } on Exception catch (e) {
      yield HomePageState.onBookShelvesRequested(
        shelves: [],
        isFetching: false,
        errorMessage: e.toString(),
      );
    }
  }
}
