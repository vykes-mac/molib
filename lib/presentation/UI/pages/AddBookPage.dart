import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  String _title = "";
  String _author = "";
  String _isbn = "";
  String _publishDate = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
              child: Hero(
            tag: 'addBook',
            child: Card(
                child: Stack(children: [
              Image.asset(
                'assets/images/book.png',
                fit: BoxFit.fill,
              ),
              _buildUI()
            ])),
          )),
        ),
      ),
    );
  }

  Widget _buildUI() => Container(
        height: 349,
        width: 309,
        padding: EdgeInsets.only(left: 50, right: 20, top: 40),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            _createTextField(
              hint: 'Title',
              fontSize: 26,
              fontWeight: FontWeight.bold,
              onChanged: (val) => _title = val,
            ),
            _createTextField(
              hint: 'Author',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              onChanged: (val) => _author = val,
            ),
            _createTextField(
              hint: 'ISBN',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              onChanged: (val) => _isbn = val,
            ),
            _createTextField(
              hint: 'Date',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              onChanged: (val) => _publishDate = val,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  TextField _createTextField({
    String hint,
    double fontSize,
    FontWeight fontWeight,
    Function(String val) onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      cursorColor: Colors.black87,
      style: TextStyle(
          color: Colors.black, fontWeight: fontWeight, fontSize: fontSize),
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          border: InputBorder.none),
    );
  }
}
