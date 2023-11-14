part of 'comment_post_bloc.dart';

@immutable
abstract class CommentPostEvent {}

class CommentPostSubmitted extends CommentPostEvent {
  final String comment;
  final int postId;

  CommentPostSubmitted({
    required this.comment,
    required this.postId,
  });
}
