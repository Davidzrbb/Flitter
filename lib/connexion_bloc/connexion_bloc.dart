
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../models/ConnexionUser.dart';
import 'package:dio/dio.dart';

part 'connexion_event.dart';

part 'connexion_state.dart';

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {
  ConnexionBloc() : super(ConnexionState()) {
    on<ConnexionSubmitted>(_onConnexionSubmitted);
  }

  void _onConnexionSubmitted(
      ConnexionSubmitted event, Emitter<ConnexionState> emit) async {
    emit(state.copyWith(status: ConnexionStatus.loading));

    try {
      final token = await doConnexion(ConnexionUser(
          email: event.connexionUser.email,
          password: event.connexionUser.password));
      emit(state.copyWith(
        status: ConnexionStatus.success,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ConnexionStatus.error,
        error: error,
      ));
    }
  }

  Future<bool> doConnexion(ConnexionUser connexionUser) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'email': connexionUser.email,
      'password': connexionUser.password,
    };
    await dio
        .post('/auth/login', data: data)
        .catchError((error) => throw error.response.data['message']);
    return true;
  }
}
