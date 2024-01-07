import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sourcses/number_trivia_local_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Fixtures/fixtures_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([], customMocks: [
MockSpec<SharedPreferences>(
as: #MockSharedPreferences,
  onMissingStub: OnMissingStub.returnDefault,
)])void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImp dataSources;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSources = NumberTriviaLocalDataSourceImp(mockSharedPreferences);
  });
  group('getLastNumberTrivia ', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixtures('trivia_cached.json')));
    test(""""should return number trivia from shared preferences when there is 
        one in the cache""", () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixtures('trivia_cached.json'));

      final result = await dataSources.getLastNumberTrivia();
      verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));

      expect(result, equals(tNumberTriviaModel));
    });
    test(""""should throw  an Exception when there is not a cached value """,
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSources.getLastNumberTrivia;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('cache Number Trivia', () {
    const tNumberTriviaModel=NumberTriviaModel(number:1 , text: 'number trivia');
   test('should call the shared preferences to cache the data', ()async {
     dataSources.cacheNumberTrivia(tNumberTriviaModel);
     final expectedToJsonString = json.encode(tNumberTriviaModel.toJson());
     verify(mockSharedPreferences.setString('CACHED_NUMBER_TRIVIA', expectedToJsonString));

   }) ;
  }
  );
}
