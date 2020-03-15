import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'Failure.dart';

class Title extends Equatable {
  final String value;

  Title._(this.value);

  static Either<Failure, Title> create(String value) {
    if (value.isEmpty || value == null)
      return Left(Failure('title cannot be empty of null'));
    else
      return Right(Title._(value));
  }

  @override
  List<Object> get props => [value];
}
