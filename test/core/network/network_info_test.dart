import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  late NetworkInfoImp networkInfoImp;
  late MockDataConnectionChecker mockDataConnectionChecker;
  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImp = NetworkInfoImp(mockDataConnectionChecker);
  });
  group('isConnection', () {
    test('dasd', () async {
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((realInvocation) async => true);
      final result = await networkInfoImp.isConnected;
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
