import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flitter/models/write_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repository/posts/posts_repository.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _storage = const FlutterSecureStorage();
  final PostsRepository postsRepository;

  PostBloc({required this.postsRepository}) : super(PostState()) {
    on<PostSubmitted>(_onPostSubmitted);
    on<PostImagePicked>(_onPostImagePicked);
  }

  void _onPostImagePicked(PostImagePicked event, Emitter<PostState> emit) {
    emit(state.copyWith(
        imageBase64: event.image, status: PostStatus.loadingImage));
  }

  void _onPostSubmitted(PostSubmitted event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));

    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        await postsRepository.createPost(
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
}
