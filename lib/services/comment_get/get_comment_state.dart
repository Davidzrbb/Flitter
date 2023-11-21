part of 'get_comment_bloc.dart';

enum GetCommentStatus {
  initial,
  loading,
  success,
  error,
}

final class GetCommentState {
  final GetCommentStatus status;
  final Post? post;
  final Object? error;

  GetCommentState({
    this.status = GetCommentStatus.initial,
    this.post,
    this.error,
  });

  GetCommentState copyWith({
    GetCommentStatus? status,
    Post? post,
    Object? error,
  }) {
    return GetCommentState(
      status: status ?? this.status,
      post: post ?? this.post,
      error: error ?? this.error,
    );
  }
}
