part of 'post_get_bloc.dart';
enum PostGetStatus {
  initial,
  loading,
  success,
  error,
}

final class PostGetState {
  final PostGetStatus status;
  final GetPost? posts;
  final Object? error;

  PostGetState({
    this.status = PostGetStatus.initial,
    this.posts,
    this.error,
  });

  PostGetState copyWith({
    PostGetStatus? status,
    GetPost? posts,
    Object? error,
  }) {
    return PostGetState(
      status: status ?? this.status,
      posts: posts,
      error: error,
    );
  }
}


