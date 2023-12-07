import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/post.dart';
import '../repository/comments/comments_repository.dart';

part 'get_comment_event.dart';

part 'get_comment_state.dart';

class GetCommentBloc extends Bloc<GetCommentEvent, GetCommentState> {
  final _storage = const FlutterSecureStorage();

  final CommentsRepository commentsRepository;

  GetCommentBloc({required this.commentsRepository})
      : super(GetCommentState()) {
    on<GetComment>(_getAllComment);
  }

  _getAllComment(GetComment event, Emitter<GetCommentState> emit) async {
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        emit(state.copyWith(status: GetCommentStatus.loading));
        Post post =
            await commentsRepository.getAllComments(event.postId, token);
        emit(state.copyWith(
          status: GetCommentStatus.success,
          post: post,
        ));
      } else {
        emit(state.copyWith(
          status: GetCommentStatus.error,
          error: 'Vous devez être connecté pour voir les commentaires',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: GetCommentStatus.error,
        error: error,
      ));
    }
  }
}
