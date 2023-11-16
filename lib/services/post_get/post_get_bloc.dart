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
      int page = 1;
      GetPost posts;
      List<Item> allItem = [];

      if (event.refresh) {
        emit(state.copyWith(status: PostGetStatus.loading));
        posts = await _doGetAll(page, state.perPage);
        allItem = posts.items;
      } else {
        page = state.page != null ? state.page! + 1 : page;
        posts = await _doGetAll(page, state.perPage);
        allItem = state.items ?? [];
        allItem.addAll(posts.items
            .where((item) => !allItem.any((element) => element.id == item.id)));
      }

      bool hasMore = posts.nextPage != null;

      emit(state.copyWith(
        status: PostGetStatus.success,
        posts: posts,
        items: allItem,
        page: page,
        perPage: state.perPage,
        hasMore: hasMore,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostGetStatus.error,
        error: error,
      ));
    }
  }

  Future<GetPost> _doGetAll(int? page, int? perPage) async {
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
    );
    return GetPost.fromJson(response.data as Map<String, dynamic>);
  }
}
