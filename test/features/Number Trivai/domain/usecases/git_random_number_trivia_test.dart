import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';
import 'package:numbers_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'git_concrete_number_trivia_test.mocks.dart';

//class MockNumberTriviaRepository extends Mock
//  implements NumberTriviaRepository {}
@GenerateMocks([NumberTriviaRepository])
// Import generated mock classes

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumberTrivia = NumberTriviaEntiteies(number: 1, text: 'test');

  test(
    'should get trivia  from the repository',
    () async {
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(tNumberTrivia));
      final result = await usecase();
      expect(result, const Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia()).called(1);
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
