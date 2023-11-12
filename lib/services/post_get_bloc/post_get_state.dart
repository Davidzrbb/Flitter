part of 'post_get_bloc.dart';

enum PostGetStatus {
  initial,
  success,
  error,
  loading,
}

final class PostGetState {
  final PostGetStatus status;
  final GetPost? posts;
  final Object? error;
  final List<Item>? items;
  final int? page;
  final int perPage;
  final bool? hasMore;

  PostGetState({
    this.status = PostGetStatus.initial,
    this.posts,
    this.error,
    this.items,
    this.page,
    this.perPage = 12,
    this.hasMore = true,
  });

  PostGetState copyWith({
    PostGetStatus? status,
    GetPost? posts,
    Object? error,
    List<Item>? items,
    int? page,
    int? perPage,
    bool? hasMore,
  }) {
    return PostGetState(
      status: status ?? this.status,
      posts: posts,
      error: error,
      items: items,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
