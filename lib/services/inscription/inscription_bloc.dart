import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/inscription_user.dart';

part 'inscription_event.dart';

part 'inscription_state.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
  final _storage = const FlutterSecureStorage();

  InscriptionBloc() : super(InscriptionState()) {
    on<InscriptionSubmitted>(_onInscriptionSubmitted);
  }

  void _onInscriptionSubmitted(
      InscriptionSubmitted event, Emitter<InscriptionState> emit) async {
    emit(state.copyWith(status: InscriptionStatus.loading));

    try {
      final token = await _doInscription(InscriptionUser(
          name: event.inscriptionUser.name,
          email: event.inscriptionUser.email,
          password: event.inscriptionUser.password));
      await _storage.write(
        key: 'authToken',
        value: token,
      );
      emit(state.copyWith(
        status: InscriptionStatus.success,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: InscriptionStatus.error,
        error: error,
      ));
    }
  }

  Future<String> _doInscription(InscriptionUser inscriptionUser) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'name': inscriptionUser.name,
      'email': inscriptionUser.email,
      'password': inscriptionUser.password,
    };
    Response<dynamic> response = await dio
        .post('/auth/signup', data: data)
        .catchError((error) => throw error.response.data['message']);
    return response.data['authToken'];
  }
}
