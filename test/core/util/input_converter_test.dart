import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/core/util/input_converter.dart';

void main(){
 late InputConverter inputConverter;
 setUp(() {
   inputConverter =InputConverter();

 });
 group('StringToUnsignedInt', () {
   test('should Convert string To UnSigned Integer', () {
       const str= '123';
        final result = inputConverter.stringToUnSignedInteger(str);
        expect(result, const Right((123)));

   });
   test('should trow exception whe the string is not integer', () {
     const str= 'abc';
     final result = inputConverter.stringToUnSignedInteger(str);
     expect(result, Left(InvalidInputFailure()));

   });
 });
}