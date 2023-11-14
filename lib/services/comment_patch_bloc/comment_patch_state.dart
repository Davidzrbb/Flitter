part of 'comment_patch_bloc.dart';

enum CommentPatchStatus {
  initial,
  loading,
  success,
  error,
}

final class CommentPatchState {
  final CommentPatchStatus? status;
  final Object? error;
  final int? postId;

  const CommentPatchState({
    this.status = CommentPatchStatus.initial,
    this.error,
    this.postId,
  });

  CommentPatchState copyWith({
    CommentPatchStatus? status,
    Object? error,
    int? postId,
  }) {
    return CommentPatchState(
      status: status ?? this.status,
      error: error ?? this.error,
      postId: postId ?? this.postId,
    );
  }
}
