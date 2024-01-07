import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';

import '../../../../Fixtures/fixtures_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test Test");

  test("should be a subclass of entities", () {
    expect(tNumberTriviaModel, isA<NumberTriviaEntiteies>());
  });
  group("from-json", () {
    test('should return a valid model when the JSON number is an integer', () {
      final Map<String, dynamic> jsonMap = jsonDecode(fixtures('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
    test('should return a valid model when the JSON number is an integer', () {
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixtures('trivia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
  });
  group("toJson", () {
    test("should return a map which containing a proper data", () {
      final result = tNumberTriviaModel.toJson();
      final expectedMap = {"text": "Test Test",
        "number": 1.0,};
      expect(result, expectedMap);
    });

  });
}
