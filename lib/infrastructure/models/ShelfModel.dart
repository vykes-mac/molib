import 'package:molib/domain/value_objects/Identity.dart';

class ShelfModel {
  final Identity id;

  ShelfModel({this.id});

  factory ShelfModel.fromMap(Map<String, dynamic> map) {
    return ShelfModel(
      id: Identity.fromString(map['Shelf_Id']),
    );
  }

  toMap() {
    return {"Shelf_Id": id.id};
  }
}
