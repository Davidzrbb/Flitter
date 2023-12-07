part of 'post_get_bloc.dart';

abstract class PostGetEvent {}

class PostGetAll extends PostGetEvent {
  final bool refresh;

  PostGetAll({this.refresh = false});
}
