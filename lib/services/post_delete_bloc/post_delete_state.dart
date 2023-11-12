part of 'post_delete_bloc.dart';

enum PostDeleteStatus {
  initial,
  success,
  error,
}

final class PostDeleteState {
  final PostDeleteStatus status;
  final Object? error;

  PostDeleteState({
    this.status = PostDeleteStatus.initial,
    this.error,
  });

  PostDeleteState copyWith({
    PostDeleteStatus? status,
    int? itemReceived,
    Object? error,
  }) {
    return PostDeleteState(
      status: status ?? this.status,
      error: error,
    );
  }
}
