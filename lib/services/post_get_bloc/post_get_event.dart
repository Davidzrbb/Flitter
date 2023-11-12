part of 'post_get_bloc.dart';

@immutable
abstract class PostGetEvent {}

class PostGetAll extends PostGetEvent {
  final bool refresh;
  PostGetAll(this.refresh);
}
