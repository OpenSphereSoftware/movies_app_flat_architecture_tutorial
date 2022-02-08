import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvp_assignment_movies/main.dart';

enum NetworkStatus { notDetermined, on, off }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  late NetworkStatus lastResult;

  NetworkDetectorNotifier() : super(NetworkStatus.notDetermined) {
    lastResult = NetworkStatus.notDetermined;

    Connectivity().checkConnectivity().then((status) {
      if (status == ConnectivityResult.none) {
        snackbarKey.currentState?.showSnackBar(const SnackBar(
          duration: Duration(days: 1),
          content: Text("No connection."),
        ));
      } else {
        snackbarKey.currentState?.hideCurrentSnackBar();
      }
    });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      NetworkStatus newState;
      switch (result) {
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = NetworkStatus.on;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.off;
          break;
      }

      if (newState != state) {
        if (newState == NetworkStatus.off) {
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            duration: Duration(days: 1),
            content: Text("No connection."),
          ));
        } else {
          snackbarKey.currentState?.hideCurrentSnackBar();
        }
        state = newState;
      }
    });
  }
}

final networkAwareProvider = StateNotifierProvider((ref) {
  return NetworkDetectorNotifier();
});
