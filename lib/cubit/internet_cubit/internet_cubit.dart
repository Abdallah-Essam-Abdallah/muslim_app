import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetInitial());

  StreamSubscription? internetSubscription;

  void checkInternetConnection() {
    internetSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(ConnectedInternetState());
      } else {
        emit(DisconnectedInternetState());
      }
    });
  }

  @override
  Future<void> close() {
    internetSubscription!.cancel();
    return super.close();
  }
}
