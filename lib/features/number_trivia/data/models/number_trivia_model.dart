import 'package:flutter/cupertino.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';

class NumberTriviaModel extends NumberTriviaEntiteies {
  const NumberTriviaModel({required this.number, required this.text})
      : super(text: text, number: number);
  final int number;
  final String text;

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
        number: (json['number'] as num).toInt(), text: json['text']);
  }
  Map<String, dynamic> toJson() {
    return {"text": text, "number": number};
  }
}
