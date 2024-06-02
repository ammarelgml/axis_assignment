import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkHandler {
  Future<bool> get isConnected;
}

class NetworkHandlerImpl implements NetworkHandler {
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkHandlerImpl(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}

class NoInternetConnection {
  final String message;

  NoInternetConnection(this.message);
}
