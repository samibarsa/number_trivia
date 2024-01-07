import 'package:dartz/dartz.dart';
import 'package:numbers_trivia/core/error/failuers.dart';

class InputConverter{
  Either<Failure,int> stringToUnSignedInteger (String str){
     try {
       final integer =int.parse(str);
       if(integer<0)throw const FormatException();
       return Right(integer) ;
     } on  FormatException {
      return left(InvalidInputFailure());
     }
  }


// ignore: must_be_immutable
}class InvalidInputFailure extends Failure{}