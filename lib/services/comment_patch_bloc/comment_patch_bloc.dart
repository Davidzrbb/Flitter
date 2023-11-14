import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../models/patch_comment.dart';

part 'comment_patch_event.dart';

part 'comment_patch_state.dart';

class CommentPatchBloc extends Bloc<CommentPatchEvent, CommentPatchState> {
  final _storage = const FlutterSecureStorage();

  CommentPatchBloc() : super(const CommentPatchState()) {
    on<CommentPatch>(_onCommentPatch);
  }

  void _onCommentPatch(
      CommentPatch event, Emitter<CommentPatchState> emit) async {
    emit(state.copyWith(status: CommentPatchStatus.loading));
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        await _doPatch(event.commentPatchModel, token);
        emit(state.copyWith(
          status: CommentPatchStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: CommentPatchStatus.error,
          error: 'Vous devez être connecté pour modifier un post',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: CommentPatchStatus.error,
        error: error,
      ));
    }
  }

  _doPatch(CommentPatchModel commentPatchModel, String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'content': commentPatchModel.comment,
    };
    Response<dynamic> response = await dio
        .post('/comment/${commentPatchModel.id}', data: data)
        .catchError((error) => throw error.response.data['message']);
    return true;
  }
}
