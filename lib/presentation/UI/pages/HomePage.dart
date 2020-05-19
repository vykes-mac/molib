import 'package:flutter/material.dart';
import 'package:molib/presentation/UI/widgets/BookWidget.dart';
import 'package:molib/presentation/models/Book.dart';
import 'package:molib/presentation/models/BookShelf.dart';
import 'package:molib/presentation/viewmodels/HomeViewModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController(initialPage: 0);

  var shelf = BookShelf('aaa');

  List<BookShelf> shelves = [];

  @override
  void initState() {
    shelf.books = [Book(id: "aaa", title: "Book", author: "Author")];
    shelves.add(shelf);
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
        _buildShelfUI(this.shelves)
        //_buildUI(),
      ])),
    );
  }

  _background() => Container(
        child: Image.asset(
          'assets/images/shelf.png',
          fit: BoxFit.fill,
        ),
      );

  _buildShelfUI(List<BookShelf> shelves) {
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
            onTap: () {},
            child: Image.asset(
              'assets/images/add_book.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
      return children;
    }
  }
}
