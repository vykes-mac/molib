import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:molib/presentation/UI/widgets/BookWidget.dart';
import 'package:molib/presentation/models/Book.dart';
import 'package:molib/presentation/models/BookShelf.dart';
import 'package:molib/presentation/states/home_page/homepage_bloc.dart';
import 'package:molib/presentation/viewmodels/HomeViewModel.dart';

abstract class HomePageDelegate {
  Future<bool> onAddBook(BuildContext context, String shelfId);
}

class HomePage extends StatefulWidget {
  final HomePageDelegate delegate;

  HomePage({this.delegate});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController(initialPage: 0);

  List<BookShelf> _shelves;

  @override
  void initState() {
    BlocProvider.of<HomePageBloc>(context).getBooksOnShelves();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vitrual Library',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: SafeArea(
          child: Stack(fit: StackFit.expand, children: [
        _background(),
        //_buildShelfUI(this.shelves)
        _buildUI(),
      ])),
    );
  }

  Widget _buildUI() => BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state.isFetching)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return _buildShelfUI(state.shelves);
        },
      );

  _background() => Container(
        child: Image.asset(
          'assets/images/shelf.png',
          fit: BoxFit.fill,
        ),
      );

  _buildShelfUI(List<BookShelf> shelves) {
    this._shelves = shelves;
    return PageView.builder(
      itemCount: shelves.length,
      itemBuilder: (_, idx) => _books(shelves[idx].books),
      controller: _controller,
    );
  }

  _books(List<Book> books) {
    List<Widget> children = _createGridviewChildren(books);

    return Container(
      child: GridView.count(
        addAutomaticKeepAlives: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(24.0),
        childAspectRatio: 8.0 / 9.0,
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 37,
        children: children,
      ),
    );
  }

  _createGridviewChildren(List<Book> books) {
    List<Widget> children = [];
    books.forEach((book) => children.add(BookWidget(book: book)));
    if (children.length < BOOKS_PER_SHELF) {
      children.add(
        Hero(
          transitionOnUserGestures: true,
          tag: 'addBook',
          child: GestureDetector(
            onTap: () => _showCreateBookPage(),
            child: Image.asset(
              'assets/images/add_book.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return children;
  }

  _showCreateBookPage() async {
    var shelf = _shelves[_controller.page.toInt()];
    var book = await widget.delegate.onAddBook(context, shelf.id);

    if (book) {
      BlocProvider.of<HomePageBloc>(context).getBooksOnShelves();
    }
  }
}
