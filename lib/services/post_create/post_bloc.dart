import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flitter/models/write_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _storage = const FlutterSecureStorage();

  PostBloc() : super(PostState()) {
    on<PostSubmitted>(_onPostSubmitted);
    on<PostImagePicked>(_onPostImagePicked);
  }

  void _onPostImagePicked(PostImagePicked event, Emitter<PostState> emit) {
    emit(state.copyWith(imageBase64: event.image, status: PostStatus.loading));
  }

  void _onPostSubmitted(PostSubmitted event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));

    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        await _doPost(
            WritePost(
                content: event.writePost.content,
                imageBase64: event.writePost.imageBase64),
            token);
        emit(state.copyWith(
          status: PostStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: PostStatus.error,
          error: 'Vous devez être connecté pour poster',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
        error: error,
      ));
    }
  }

  Future<bool> _doPost(WritePost writePost, String token) async {
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
        .post(
          '/post',
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
