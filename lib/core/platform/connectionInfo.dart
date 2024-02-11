import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Connectioninfo {
  Future<bool> get isConnected;
}

class ConnectioninfoImpl implements Connectioninfo {
  final InternetConnectionChecker connectionChecker;

  ConnectioninfoImpl({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}