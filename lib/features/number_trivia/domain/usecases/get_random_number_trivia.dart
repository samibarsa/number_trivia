import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_trivia/core/error/failuers.dart';
import 'package:numbers_trivia/core/usecases/usecase.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';

class GetRandomNumberTrivia implements Usecase<NumberTriviaEntiteies,NoParams> {
  NumberTriviaRepository repository;
  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntiteies>> call({NoParams? param}) async {
   return await repository.getRandomNumberTrivia();

  }

}

class NoParams extends Equatable{
  @override

  List<Object?> get props => [];
}