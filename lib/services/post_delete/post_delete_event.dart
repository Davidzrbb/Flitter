part of 'post_delete_bloc.dart';

abstract class PostDeleteEvent {}

class PostDelete extends PostDeleteEvent {
  final int id;

  PostDelete(this.id);
}
