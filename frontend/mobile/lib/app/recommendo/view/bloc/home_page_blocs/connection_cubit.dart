import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppConnectionState { initialState, connectionOn, connectionOff }

class AppConnectionCubit extends Cubit<AppConnectionState> {
  final connectivity = Connectivity();

  StreamSubscription<List<ConnectivityResult>>? streamSubscription;

  AppConnectionCubit() : super(AppConnectionState.initialState) {
    streamSubscription = connectivity.onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.mobile) ||
          event.contains(ConnectivityResult.wifi)) {
        emit(AppConnectionState.connectionOn);
      } else {
        emit(AppConnectionState.connectionOff);
      }
    });
  }

  void changeState() {
    if (state == AppConnectionState.connectionOn) {
      emit(AppConnectionState.connectionOff);
    } else {
      emit(AppConnectionState.connectionOn);
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
