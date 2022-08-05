import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// ignore: constant_identifier_names
enum InternetState { Initial, Available, Unavailable }

class InternetCubit extends Cubit<InternetState> {
  Connectivity connectivity = Connectivity();
  // ignore: unused_field
  StreamSubscription? _streamSubscription;

  InternetCubit() : super(InternetState.Initial) {
    _streamSubscription = connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetState.Available);
      } else {
        emit(InternetState.Unavailable);
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
