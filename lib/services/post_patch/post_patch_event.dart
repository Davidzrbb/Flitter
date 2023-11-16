part of 'post_patch_bloc.dart';

@immutable
abstract class PostPatchEvent {}

class PostPatch extends PostPatchEvent {
  final WritePost post;
  final int id;

  PostPatch(this.post, this.id);
}
