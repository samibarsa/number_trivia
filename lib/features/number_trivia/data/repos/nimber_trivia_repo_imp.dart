import 'package:dartz/dartz.dart';
import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:numbers_trivia/core/error/failuers.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sourcses/number_trivia_local_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sourcses/number_trivia_remote_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';

import '../../../../core/network/network_info.dart';
typedef _ConcreteOrRandom = Future<NumberTriviaEntiteies> Function();
class NumberTriviaRepoImp implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource numberTriviaLocalDataSource;
  final NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;
  final NetworkInfo netWorkInfo;

  NumberTriviaRepoImp(
      {required this.numberTriviaLocalDataSource,
      required this.numberTriviaRemoteDataSource,
      required this.netWorkInfo});

  Future<Either<Failure, NumberTriviaEntiteies>> _getTrivia(
      _ConcreteOrRandom getConcreteOrRandom) async {
    if (await netWorkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        numberTriviaLocalDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return left(ServerFailure());
        // TODO
      }
    } else {
      try {
        final localTrivia =
            await numberTriviaLocalDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTriviaEntiteies>> getConcreteNumberTrivia(
      int number) async {
    netWorkInfo.isConnected;

    return await _getTrivia(() {
      return numberTriviaRemoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTriviaEntiteies>> getRandomNumberTrivia() async {
    netWorkInfo.isConnected;

    return await _getTrivia(() {
      return numberTriviaRemoteDataSource.getRandomNumberTrivia();
    });
  }
}
