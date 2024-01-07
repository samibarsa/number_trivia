import 'dart:convert';

import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../domain/entities/number_trivia_entities.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImp implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImp({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number) =>
      _getTrivia('http://numberesapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTrivia('http://numberesapi.com/random');


  Future<NumberTriviaModel> _getTrivia(String url) async {
    final response = await client.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}

