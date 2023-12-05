import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../post_get/post_get_bloc.dart';

part 'post_delete_event.dart';

part 'post_delete_state.dart';

class PostDeleteBloc extends Bloc<PostDeleteEvent, PostDeleteState> {
  final _storage = const FlutterSecureStorage();
  final PostGetBloc postGetBloc;

  PostDeleteBloc(this.postGetBloc) : super(PostDeleteState()) {
    on<PostDelete>(_onPostDelete);
  }

  void _onPostDelete(PostDelete event, Emitter<PostDeleteState> emit) async {
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        await _doDelete(token, event.id);
        emit(state.copyWith(
          status: PostDeleteStatus.success,
        ));
        postGetBloc.add(PostGetAll(refresh: true));
      } else {
        emit(state.copyWith(
          status: PostDeleteStatus.error,
          error: 'Vous devez être connecté pour supprimer un post',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: PostDeleteStatus.error,
        error: error,
      ));
    }
  }

  Future<void> _doDelete(String token, int id) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );
    await dio.delete(
      '/post/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
