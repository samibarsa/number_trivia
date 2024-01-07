import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_trivia/core/error/failuers.dart';
import 'package:numbers_trivia/core/usecases/usecase.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';

class GetConcreteNumberTrivia
    implements Usecase<NumberTriviaEntiteies, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntiteies>> call({Params? param}) async {
    return await repository.getConcreteNumberTrivia(param!.number);
  }
}

class Params extends Equatable {
  const Params({
    required this.number,
  });
  final int number;

  @override
  List<Object?> get props => [number];
}
