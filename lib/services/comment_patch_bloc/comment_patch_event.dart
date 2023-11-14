part of 'comment_patch_bloc.dart';

@immutable
abstract class CommentPatchEvent {}

class CommentPatch extends CommentPatchEvent {
  final CommentPatchModel commentPatchModel;

  CommentPatch(this.commentPatchModel);
}
