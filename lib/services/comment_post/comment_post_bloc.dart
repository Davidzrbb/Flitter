import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../repository/comments/comments_repository.dart';

part 'comment_post_event.dart';

part 'comment_post_state.dart';

class CommentPostBloc extends Bloc<CommentPostEvent, CommentPostState> {
  final _storage = const FlutterSecureStorage();
  final CommentsRepository commentsRepository;

  CommentPostBloc({required this.commentsRepository})
      : super(const CommentPostState()) {
    on<CommentPostSubmitted>(_onCommentPostSubmitted);
  }

  Future<void> _onCommentPostSubmitted(
      CommentPostSubmitted event, Emitter<CommentPostState> emit) async {
    emit(state.copyWith(status: CommentPostStatus.loading));
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        int postId = await commentsRepository.createComment(
            event.comment, event.postId, token);
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
}
