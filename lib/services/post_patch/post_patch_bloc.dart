import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../models/write_post.dart';

part 'post_patch_event.dart';

part 'post_patch_state.dart';

class PostPatchBloc extends Bloc<PostPatchEvent, PostPatchState> {
  final _storage = const FlutterSecureStorage();

  PostPatchBloc() : super(PostPatchState()) {
    on<PostPatch>(_onPostPatchEvent);
  }

  void _onPostPatchEvent(PostPatch event, Emitter<PostPatchState> emit) async {
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        emit(state.copyWith(status: PostPatchStatus.loading));
        await _doPatch(event.post, token, event.id);
        emit(state.copyWith(
          status: PostPatchStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: PostPatchStatus.error,
          error: 'Vous devez être connecté pour modifier un post',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: PostPatchStatus.error,
        error: error,
      ));
    }
  }

  Future<bool> _doPatch(WritePost writePost, String token, int id) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    FormData formData;

    if (writePost.imageBase64 != null) {
      String fileName = 'image.png';
      formData = FormData.fromMap({
        'base_64_image': await MultipartFile.fromFile(
          writePost.imageBase64!.path,
          filename: fileName,
        ),
        'content': writePost.content,
      });
    } else {
      formData = FormData.fromMap({
        'content': writePost.content,
      });
    }

    await dio
        .patch(
          '/post/$id',
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
              "Authorization": "Bearer $token",
            },
          ),
        )
        .catchError((error) => throw Exception(error));
    return true;
  }
}
