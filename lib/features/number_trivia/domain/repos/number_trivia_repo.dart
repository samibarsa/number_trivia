import 'package:dartz/dartz.dart';
import 'package:numbers_trivia/core/error/failuers.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';

abstract class NumberTriviaRepository {
    Future<Either<Failure, NumberTriviaEntiteies>> getConcreteNumberTrivia(
        int number);
    Future<Either<Failure, NumberTriviaEntiteies>> getRandomNumberTrivia();
}
