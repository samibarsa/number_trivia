import 'package:dartz/dartz.dart';
import 'package:numbers_trivia/core/error/failuers.dart';

  abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call({Params param});
}
