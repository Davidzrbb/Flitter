part of 'post_patch_bloc.dart';

enum PostPatchStatus {
  initial,
  loading,
  success,
  error,
}

final class PostPatchState {
  final PostPatchStatus status;
  final WritePost? post;
  final Object? error;

  PostPatchState({
    this.status = PostPatchStatus.initial,
    this.post,
    this.error,
  });

  PostPatchState copyWith({
    PostPatchStatus? status,
    WritePost? post,
    Object? error,
  }) {
    return PostPatchState(
      status: status ?? this.status,
      post: post,
      error: error,
    );
  }
}
