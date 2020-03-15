import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;
import 'package:molib/domain/value_objects/Failure.dart';
import 'package:molib/domain/value_objects/Title.dart';

void main() {
  group('Title', () {
    test('should return Failure when value is empty', () {
      //arrange
      var title = Title.create('').fold((err) => err, (title) => title);

      //assert
      expect(title, matcher.TypeMatcher<Failure>());
    });

    test('should create title when value is not empty', () {
      //arrange
      var str = 'Programming 101';
      var title = Title.create(str).getOrElse(null);

      //assert
      expect(title.value, str);
    });
  });
}
