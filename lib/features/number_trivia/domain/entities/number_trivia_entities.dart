import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NumberTriviaEntiteies extends Equatable {
  final String? text;
  final int? number;

  const NumberTriviaEntiteies({@required this.text, @required this.number});

  @override
  List<Object?> get props => [text, number];
}
