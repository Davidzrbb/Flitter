part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  loadingImage,
  success,
  error,
}

final class PostState {
  final PostStatus status;
  final WritePost? post;
  final Object? error;
  final File? imageBase64;

  PostState({
    this.status = PostStatus.initial,
    this.post,
    this.error,
    this.imageBase64,
  });

  PostState copyWith({
    PostStatus? status,
    WritePost? post,
    Object? error,
    File? imageBase64,
  }) {
    return PostState(
      status: status ?? this.status,
      post: post,
      error: error,
      imageBase64: imageBase64,
    );
  }
}
