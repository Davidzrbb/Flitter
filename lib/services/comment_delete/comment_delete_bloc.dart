import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repository/comments/comments_repository.dart';

part 'comment_delete_event.dart';

part 'comment_delete_state.dart';

class CommentDeleteBloc extends Bloc<CommentDeleteEvent, CommentDeleteState> {
  final _storage = const FlutterSecureStorage();
  final CommentsRepository commentsRepository;

  CommentDeleteBloc({required this.commentsRepository})
      : super(const CommentDeleteState()) {
    on<CommentDelete>(_onCommentDelete);
  }

  _onCommentDelete(
      CommentDelete event, Emitter<CommentDeleteState> emit) async {
    emit(state.copyWith(status: CommentDeleteStatus.loading));
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        await commentsRepository.deleteComment(event.id, token);
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
}
