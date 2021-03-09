import 'dart:async';
import 'package:connectivity/connectivity.dart';

class NetworkProvider {
  StreamSubscription<ConnectivityResult> _subscription;
  bool _isConnected;

  bool get isConnected => _isConnected;

  NetworkProvider() {
    _subscription =
        Connectivity().onConnectivityChanged.listen(_checkConnection);
  }

  void _checkConnection(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }
  }

  void dispose() {
    _subscription.cancel();
  }
}
