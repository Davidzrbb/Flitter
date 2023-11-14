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

  const CommentPatchState({
    this.status = CommentPatchStatus.initial,
    this.error,
  });

  factory CommentPatchState.initial() => const CommentPatchState(
        status: CommentPatchStatus.initial,
        error: '',
      );

  CommentPatchState copyWith({
    CommentPatchStatus? status,
    Object? error,
  }) {
    return CommentPatchState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
