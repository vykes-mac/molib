import 'package:flutter/foundation.dart';
import 'package:molib/domain/entities/Book.dart';
import 'package:molib/domain/value_objects/Author.dart';
import 'package:molib/domain/value_objects/ISBN.dart';
import 'package:molib/domain/value_objects/Identity.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';
import 'package:molib/domain/value_objects/Title.dart';

class BookModel extends Book {
  Identity id;
  Identity shelfId;
  Title title;
  Author author;
  ISBN isbn;
  PublishDate publishDate;

  BookModel({
    @required this.id,
    @required this.shelfId,
    @required this.title,
    @required this.author,
    @required this.isbn,
    @required this.publishDate,
  });

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: Identity.fromString(map["Book_Id"]),
      shelfId: Identity.fromString(map["Shelf_Id"]),
      title: Title.create(map["Title"]).getOrElse(null),
      author: Author.create(map["Author"]).getOrElse(null),
      isbn: ISBN.create(map["ISBN"]).getOrElse(null),
      publishDate: PublishDate.create(map["Publish_Date"]).getOrElse(null),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Book_Id": id.id,
      "Shelf_Id": shelfId.id,
      "Title": title.value,
      "Author": author.value,
      "ISBN": isbn.value,
      "Publish_Date": publishDate.toString()
    };
  }
}
