part of 'post_get_bloc.dart';

enum PostGetStatus {
  initial,
  success,
  error,
}

final class PostGetState {
  final PostGetStatus status;
  final GetPost? posts;
  final Object? error;
  final int? itemReceived;

  PostGetState({
    this.status = PostGetStatus.initial,
    this.posts,
    this.error,
    this.itemReceived,
  });

  PostGetState copyWith({
    PostGetStatus? status,
    GetPost? posts,
    int? itemReceived,
    Object? error,
  }) {
    return PostGetState(
      status: status ?? this.status,
      posts: posts,
      error: error,
      itemReceived: itemReceived ?? this.itemReceived,
    );
  }
}
