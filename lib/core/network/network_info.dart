import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImp(this.dataConnectionChecker);
  @override
  Future<bool> get isConnected {
    dataConnectionChecker!.hasConnection;
    return Future(() => Future.value(true));
  }
}
