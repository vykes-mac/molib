import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;
import 'package:molib/domain/value_objects/Failure.dart';
import 'package:molib/domain/value_objects/PublishDate.dart';

void main() {
  group('PublishDate', () {
    test('should return failure when date is not formatted properly', () {
      //arrange
      var date =
          PublishDate.create('2019.01.20').fold((err) => err, (_) => null);

      //assert
      expect(date, matcher.TypeMatcher<Failure>());
    });

    test('should set date when date is valid', () {
      //arrange
      var dateStr = '2019-01-20';
      var date = PublishDate.create(dateStr).getOrElse(null);

      //assert
      expect(date.toDate(), DateTime(2019, 01, 20));
    });
  });
}
