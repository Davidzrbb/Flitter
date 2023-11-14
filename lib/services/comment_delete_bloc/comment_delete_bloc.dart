import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'comment_delete_event.dart';

part 'comment_delete_state.dart';

class CommentDeleteBloc extends Bloc<CommentDeleteEvent, CommentDeleteState> {
  final _storage = const FlutterSecureStorage();

  CommentDeleteBloc() : super(const CommentDeleteState()) {
    on<CommentDelete>(_onCommentDelete);
  }

  _onCommentDelete(
      CommentDelete event, Emitter<CommentDeleteState> emit) async {
    emit(state.copyWith(status: CommentDeleteStatus.loading));
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        _doDelete(event.id, token);
        emit(state.copyWith(status: CommentDeleteStatus.success));
      } else {
        emit(state.copyWith(
          status: CommentDeleteStatus.error,
          error: 'Vous devez être connecté pour supprimer un commentaire',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: CommentDeleteStatus.error,
        error: error,
      ));
    }
  }

  Future<bool> _doDelete(int id, String token) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    return dio
        .delete(
          '/comment/$id',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          ),
        )
        .then((value) => true);
  }
}
