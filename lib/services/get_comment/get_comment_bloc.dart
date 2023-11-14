import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import '../../models/post.dart';

part 'get_comment_event.dart';

part 'get_comment_state.dart';

class GetCommentBloc extends Bloc<GetCommentEvent, GetCommentState> {
  final _storage = const FlutterSecureStorage();

  GetCommentBloc() : super(GetCommentState()) {
    on<GetComment>(_getAllComment);
  }

  _getAllComment(GetComment event, Emitter<GetCommentState> emit) async {
    emit(state.copyWith(status: GetCommentStatus.loading));
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        Post post = await _doGetAll(event.postId, token);
        emit(state.copyWith(
          status: GetCommentStatus.success,
          post: post,
        ));
      } else {
        emit(state.copyWith(
          status: GetCommentStatus.error,
          error: 'Vous devez être connecté pour voir les posts',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: GetCommentStatus.error,
        error: error,
      ));
    }
  }

  Future<Post> _doGetAll(int postId, String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );
    final response = await dio.get(
      '/post/$postId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return Post.fromJson(response.data as Map<String, dynamic>);
  }
}
