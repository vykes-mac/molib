import 'package:flutter/material.dart';

import 'presentation/UI/pages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Virtual Library',
      home: HomePage(),
    );
  }
}
