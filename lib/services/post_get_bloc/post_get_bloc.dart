import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flitter/models/get_post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'post_get_event.dart';

part 'post_get_state.dart';

class PostGetBloc extends Bloc<PostGetEvent, PostGetState> {
  final _storage = const FlutterSecureStorage();

  PostGetBloc() : super(PostGetState()) {
    on<PostGetAll>(_onPostGetAll);
  }

  void _onPostGetAll(PostGetAll event, Emitter<PostGetState> emit) async {
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        GetPost posts;
        List<Item> allItem = [];
        int page = 1;
        bool hasMore = true;
        if (event.refresh) {
          emit(state.copyWith(status: PostGetStatus.loading));
          page = 1;
          posts = await _doGetAll(token, page, state.perPage);
          allItem = posts.items;
        } else {
          if (state.page != null) {
            page = state.page! + 1;
          }
          posts = await _doGetAll(token, page, state.perPage);
          allItem = state.items ?? [];
          for (var item in posts.items) {
            if (!allItem.any((element) => element.id == item.id)) {
              allItem.add(item);
            }
          }
        }
        if (posts.nextPage == null) {
          hasMore = false;
        }
        emit(state.copyWith(
          status: PostGetStatus.success,
          posts: posts,
          items: allItem,
          page: page,
          perPage: state.perPage,
          hasMore: hasMore,
        ));
      } else {
        emit(state.copyWith(
          status: PostGetStatus.error,
          error: 'Vous devez être connecté pour voir les posts',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: PostGetStatus.error,
        error: error,
      ));
    }
  }

  Future<GetPost> _doGetAll(String token, int? page, int? perPage) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );
    final response = await dio.get(
      '/post',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return GetPost.fromJson(response.data as Map<String, dynamic>);
  }
}
