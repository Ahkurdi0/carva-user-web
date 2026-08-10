import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { notDetermined, on, off }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  NetworkDetectorNotifier() : super(NetworkStatus.notDetermined) {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      // Pick the first result, or handle multiple if needed
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;

      NetworkStatus newState;
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
          newState = NetworkStatus.on;
          break;

        case ConnectivityResult.none:
        case ConnectivityResult.other:
        case ConnectivityResult.vpn:
        case ConnectivityResult.bluetooth:
          newState = NetworkStatus.off;
          break;
      }

      if (newState != state) {
        state = newState;
      }
    });
  }
}

final networkAwareProvider =
    StateNotifierProvider<NetworkDetectorNotifier, NetworkStatus>(
      (ref) => NetworkDetectorNotifier(),
    );
