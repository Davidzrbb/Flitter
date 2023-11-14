part of 'comment_delete_bloc.dart';

@immutable
abstract class CommentDeleteEvent {}

class CommentDelete extends CommentDeleteEvent {
  CommentDelete(this.id);

  final int id;
}
