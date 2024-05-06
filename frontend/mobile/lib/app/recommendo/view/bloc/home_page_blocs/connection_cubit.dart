import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppConnectionState { initialState, connectionOn, connectionOff }

class AppConnectionCubit extends Cubit<AppConnectionState> {
  final _connectivity = Connectivity();

  StreamSubscription<List<ConnectivityResult>>? _streamSubscription;

  AppConnectionCubit() : super(AppConnectionState.initialState) {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
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

  bool get isOffline => AppConnectionState.connectionOff == state;

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
