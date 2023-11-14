part of 'comment_delete_bloc.dart';

enum CommentDeleteStatus {
  initial,
  loading,
  success,
  error,
}
final class CommentDeleteState {
  final CommentDeleteStatus? status;
  final Object? error;

  const CommentDeleteState({
    this.status = CommentDeleteStatus.initial,
    this.error,
  });

  CommentDeleteState copyWith({
    CommentDeleteStatus? status,
    Object? error,
    int? postId,
  }) {
    return CommentDeleteState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}


