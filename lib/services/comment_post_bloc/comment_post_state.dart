part of 'comment_post_bloc.dart';

enum CommentPostStatus {
  initial,
  loading,
  success,
  error,
}

final class CommentPostState {
  final CommentPostStatus? status;
  final Object? error;
  final int? postId;

  const CommentPostState({
    this.status = CommentPostStatus.initial,
    this.error,
    this.postId,
  });

  CommentPostState copyWith({
    CommentPostStatus? status,
    Object? error,
    int? postId,
  }) {
    return CommentPostState(
      status: status ?? this.status,
      error: error ?? this.error,
      postId: postId ?? this.postId,
    );
  }
}
