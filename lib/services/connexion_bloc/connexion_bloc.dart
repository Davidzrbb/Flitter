import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/connexion_user.dart';
import 'package:dio/dio.dart';

import '../../models/user.dart';

part 'connexion_event.dart';

part 'connexion_state.dart';

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {
  final _storage = const FlutterSecureStorage();
  ConnexionBloc() : super(ConnexionState()) {
    on<ConnexionSubmitted>(_onConnexionSubmitted);
    on<IsConnected>(_onIsConnected);
    on<Disconnected>(_onDisconnected);
  }

  void _onConnexionSubmitted(
      ConnexionSubmitted event, Emitter<ConnexionState> emit) async {
    emit(state.copyWith(status: ConnexionStatus.loading));

    try {
      final token = await _doConnexion(ConnexionUser(
          email: event.connexionUser.email,
          password: event.connexionUser.password));

      await _storage.write(
        key: 'authToken',
        value: token,
      );
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

  void _onIsConnected(IsConnected event, Emitter<ConnexionState> emit) async {
    emit(state.copyWith(status: ConnexionStatus.loading));

    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        User user = await _doIsConnected(token);

        emit(state.copyWith(
          status: ConnexionStatus.success,
          user: user,
        ));
      } else {
        emit(state.copyWith(
          status: ConnexionStatus.error,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: ConnexionStatus.error,
      ));
    }
  }

  void _onDisconnected(Disconnected event, Emitter<ConnexionState> emit) async {
    emit(state.copyWith(status: ConnexionStatus.loading));

    try {
      await _storage.delete(key: 'authToken');
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

  Future<String> _doConnexion(ConnexionUser connexionUser) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'email': connexionUser.email,
      'password': connexionUser.password,
    };
    Response<dynamic> response = await dio
        .post('/auth/login', data: data)
        .catchError((error) => throw error.response.data['message']);
    return response.data['authToken'];
  }

  Future<User> _doIsConnected(String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'authToken': token,
    };
    Response<dynamic> response = await dio
        .get('/auth/me',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            }))
        .catchError((error) => throw error.response.data['message']);
    return User.fromJson(response.data);
  }
}
