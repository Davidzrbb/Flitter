import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import '../../models/inscription_user.dart';

part 'inscription_event.dart';

part 'inscription_state.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
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

  Future<bool> _doInscription(InscriptionUser inscriptionUser) async {
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
    await dio
        .post('/auth/signup', data: data)
        .catchError((error) => throw error.response.data['message']);
    return true;
  }
}
