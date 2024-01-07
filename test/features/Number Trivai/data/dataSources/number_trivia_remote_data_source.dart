
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sourcses/number_trivia_remote_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../Fixtures/fixtures_reader.dart';
import 'number_trivia_remote_data_source.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late NumberTriviaRemoteDataSourceImp datasource;

  setUp(() {
    mockHttpClient = MockClient();
    datasource = NumberTriviaRemoteDataSourceImp(client: mockHttpClient);
  });
  group('get concrete number trivia ', () {
    const tNumberTriviaModel= NumberTriviaModel(number: 1, text: "Test Test");
    const tNumber = 1;
    test('should return header', () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));

      datasource.getConcreteNumberTrivia(tNumber);
      verify(mockHttpClient.get(Uri.parse('http://numberesapi.com/$tNumber') , headers: {
        'Content-Type': 'application/json',
      }));
    });
    test('should return ', ()async {

      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));

        final result = await  datasource.getConcreteNumberTrivia(tNumber);
        expect( result, equals(tNumberTriviaModel));
    });
    test('should trow an exception when the status code dose not equal 200', ()async {

      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('SomeThing was wrong', 404));

      final call  =   datasource.getConcreteNumberTrivia;
      expect( ()=> call(tNumber),throwsA(const TypeMatcher<ServerException>() ));
    });
  });
  group('get random number trivia ', () {
    const tNumberTriviaModel= NumberTriviaModel(number: 1, text: "Test Test");
    test('should return header', () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));

      datasource.getRandomNumberTrivia();
      verify(mockHttpClient.get(Uri.parse('http://numberesapi.com/random') , headers: {
        'Content-Type': 'application/json',
      }));
    });
    test('should return ', ()async {

      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));

      final result = await  datasource.getRandomNumberTrivia();
      expect( result, equals(tNumberTriviaModel));
    });
    test('should trow an exception when the status code dose not equal 200', ()async {

      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('SomeThing was wrong', 404));

      final call  =   datasource.getRandomNumberTrivia;
      expect( ()=> call(),throwsA(const TypeMatcher<ServerException>() ));
    });
  });
}
