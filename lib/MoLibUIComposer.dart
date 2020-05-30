import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:molib/application/boundaries/add_book/IAddBookUseCase.dart';
import 'package:molib/application/usecases/AddBookUseCase.dart';
import 'package:molib/application/usecases/CreateShelfUseCase.dart';
import 'package:molib/application/usecases/GetAllBookUseCase.dart';
import 'package:molib/domain/repositories/IBookRepository.dart';
import 'package:molib/domain/repositories/IBookShelfRepository.dart';
import 'package:molib/infrastructure/datasources/SqfliteDatasource.dart';
import 'package:molib/infrastructure/factories/EntityFactory.dart';
import 'package:molib/infrastructure/repositories/BookRepsitory.dart';
import 'package:molib/infrastructure/repositories/ShelfRepository.dart';
import 'package:molib/presentation/UI/pages/AddBookPage.dart';
import 'package:molib/presentation/UI/pages/HomePage.dart';
import 'package:molib/presentation/viewmodels/AddBookViewModel.dart';
import 'package:molib/presentation/viewmodels/HomeViewModel.dart';
import 'package:sqflite/sqflite.dart';

import 'presentation/states/add_book_page/addbook_bloc.dart';
import 'presentation/states/home_page/homepage_bloc.dart';

class HomePageCoordinator implements HomePageDelegate {
  @override
  Future<bool> onAddBook(BuildContext context, String shelfId) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        fullscreenDialog: true,
        barrierDismissible: true,
        barrierColor: Colors.black38,
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            MoLibUIComposer.composeAddBookPage(shelfId),
      ),
    );
  }
}

class MoLibUIComposer {
  static SqfliteDatasource _datasource;
  static final EntityFactory _entityFactory = EntityFactory();
  static IBookRepository _bookRepository;
  static IBookShelfRepository _shelfRepository;

  static configure(Database db) {
    _datasource = SqfliteDatasource(db: db);
    _bookRepository = BookRepository(datasource: _datasource);
    _shelfRepository = ShelfRepository(_datasource);
  }

  static Widget composeHomePage() {
    HomePageCoordinator coordinator = HomePageCoordinator();

    GetAllBooksUseCase getAllBooksUseCase =
        GetAllBooksUseCase(bookRepository: _bookRepository);
    CreateShelfUseCase createShelfUseCase =
        CreateShelfUseCase(_shelfRepository, _entityFactory);

    HomePageViewModel viewModel = HomePageViewModel(
      createShelfUseCase: createShelfUseCase,
      getAllBooksUseCase: getAllBooksUseCase,
    );

    return BlocProvider(
      create: (context) => HomePageBloc(viewModel),
      child: HomePage(delegate: coordinator),
    );
  }

  static Widget composeAddBookPage(String shelfId) {
    IAddBookUseCase addBookUseCase = AddBookUseCase(
        bookShelfRepository: _shelfRepository,
        bookRepository: _bookRepository,
        entityFactory: _entityFactory);

    AddBookViewModel viewModel = AddBookViewModel(addBookUseCase);

    return BlocProvider(
      create: (_) => AddBookBloc(viewModel),
      child: AddBookPage(shelfId),
    );
  }
}
