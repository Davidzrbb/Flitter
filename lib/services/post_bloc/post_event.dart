part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class PostSubmitted extends PostEvent {
  final WritePost writePost;
  PostSubmitted(this.writePost);
}

class PostImagePicked extends PostEvent {
  final File? image;
  PostImagePicked(this.image);
}
