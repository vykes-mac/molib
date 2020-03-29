import 'package:dartz/dartz.dart';
import 'package:molib/domain/value_objects/Failure.dart';

abstract class IUseCase<TUseCaseInput, TUseCaseOuput> {
  Future<Either<Failure, TUseCaseOuput>> execute(TUseCaseInput input);
}
