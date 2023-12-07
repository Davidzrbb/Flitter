import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/patch_comment.dart';
import '../repository/comments/comments_repository.dart';

part 'comment_patch_event.dart';

part 'comment_patch_state.dart';

class CommentPatchBloc extends Bloc<CommentPatchEvent, CommentPatchState> {
  final _storage = const FlutterSecureStorage();
  final CommentsRepository commentsRepository;

  CommentPatchBloc({required this.commentsRepository})
      : super(const CommentPatchState()) {
    on<CommentPatch>(_onCommentPatch);
  }

  void _onCommentPatch(
      CommentPatch event, Emitter<CommentPatchState> emit) async {
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        emit(state.copyWith(status: CommentPatchStatus.loading));
        int postId = await commentsRepository.patchComment(
            event.commentPatchModel, token);
        emit(state.copyWith(
          status: CommentPatchStatus.success,
          postId: postId,
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
}
