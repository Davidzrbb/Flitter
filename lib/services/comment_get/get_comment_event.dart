part of 'get_comment_bloc.dart';

@immutable
abstract class GetCommentEvent {}

class GetComment extends GetCommentEvent {
  final int postId;

  GetComment(this.postId);
}
