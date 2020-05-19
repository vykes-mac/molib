import 'package:flutter/material.dart';
import 'package:molib/presentation/models/Book.dart';
import 'package:molib/presentation/utils/RandomColorGenerator.dart';

class BookWidget extends StatelessWidget {
  final Book book;

  BookWidget({this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black26, offset: Offset(-8.0, 0.0), blurRadius: 6.0)
      ]),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset('assets/images/book.png',
              color: RandomColorGenerator.getColor(),
              colorBlendMode: BlendMode.hardLight,
              fit: BoxFit.cover),
          _bookInfo()
        ],
      ),
    );
  }

  Widget _bookInfo() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              book.title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              book.author,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0),
            ),
          )
        ],
      );
}
