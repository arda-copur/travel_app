import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool _hasInternet = true; // Default
  bool get hasInternet => _hasInternet;

  ConnectivityProvider() {
    _checkInitialConnectivity();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectivityStatus(results);
    });
  }

  Future<void> _checkInitialConnectivity() async {
    final List<ConnectivityResult> results =
        await Connectivity().checkConnectivity();
    _updateConnectivityStatus(results);
  }

  void _updateConnectivityStatus(List<ConnectivityResult> results) {
    bool connected = results.any((result) => result != ConnectivityResult.none);
    if (_hasInternet != connected) {
      _hasInternet = connected;
      notifyListeners();
    }
  }
}
