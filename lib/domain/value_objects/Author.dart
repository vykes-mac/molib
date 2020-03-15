import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:molib/domain/value_objects/Failure.dart';

class Author extends Equatable {
  final String value;

  Author._(this.value);

  static Either<Failure, Author> create(String value) {
    if (value.isEmpty || value == null)
      return Left(Failure('author cannot be empty or null'));
    else
      return Right(Author._(value));
  }

  @override
  List<Object> get props => [value];
}
