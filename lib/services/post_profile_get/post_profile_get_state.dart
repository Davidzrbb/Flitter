part of 'post_profile_get_bloc.dart';

enum PostProfileGetStatus {
  initial,
  loading,
  success,
  error,
}

final class PostProfileGetState {
  final PostProfileGetStatus status;
  final GetPost? profilePosts;
  final Object? error;
  final List<Item>? items;
  final int? page;
  final int perPage;
  final bool? hasMore;
  final int itemsTotal;

  PostProfileGetState({
    this.status = PostProfileGetStatus.initial,
    this.profilePosts,
    this.error,
    this.items,
    this.page,
    this.perPage = 6,
    this.hasMore = false,
    this.itemsTotal = 0,
  });

  PostProfileGetState copyWith({
    PostProfileGetStatus? status,
    GetPost? profilePosts,
    Object? error,
    List<Item>? items,
    int? page,
    int? perPage,
    bool? hasMore,
    int? itemsTotal,
  }) {
    return PostProfileGetState(
      status: status ?? this.status,
      profilePosts: profilePosts ?? this.profilePosts,
      error: error ?? this.error,
      items: items ?? this.items,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      hasMore: hasMore ?? this.hasMore,
      itemsTotal: itemsTotal ?? this.itemsTotal,
    );
  }
}
