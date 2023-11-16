import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'comment_post_event.dart';

part 'comment_post_state.dart';

class CommentPostBloc extends Bloc<CommentPostEvent, CommentPostState> {
  final _storage = const FlutterSecureStorage();

  CommentPostBloc() : super(const CommentPostState()) {
    on<CommentPostSubmitted>(_onCommentPostSubmitted);
  }

  Future<void> _onCommentPostSubmitted(
      CommentPostSubmitted event, Emitter<CommentPostState> emit) async {
    emit(state.copyWith(status: CommentPostStatus.loading));
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        int postId = await _doSubmitted(event.comment, event.postId, token);
        emit(state.copyWith(
          status: CommentPostStatus.success,
          postId: postId,
        ));
      } else {
        emit(state.copyWith(
          status: CommentPostStatus.error,
          error: 'Vous devez être connecté pour poster un commentaire',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: CommentPostStatus.error,
        error: error,
      ));
    }
  }

  _doSubmitted(String comment, int postId, String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'content': comment,
      'post_id': postId,
    };
    Response<dynamic> response = await dio
        .post(
          '/comment',
          data: data,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          ),
        )
        .catchError((error) => throw error.response.data['message']);

    return response.data['post_id'];
  }
}
