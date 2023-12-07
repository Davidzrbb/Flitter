import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/inscription_user.dart';
import '../repository/auth/auth_repository.dart';

part 'inscription_event.dart';

part 'inscription_state.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
  final _storage = const FlutterSecureStorage();
  final AuthRepository authRepository;

  InscriptionBloc({required this.authRepository}) : super(InscriptionState()) {
    on<InscriptionSubmitted>(_onInscriptionSubmitted);
  }

  void _onInscriptionSubmitted(
      InscriptionSubmitted event, Emitter<InscriptionState> emit) async {
    emit(state.copyWith(status: InscriptionStatus.loading));

    try {
      final token = await authRepository.doInscription(InscriptionUser(
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
}
