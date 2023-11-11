part of 'post_get_bloc.dart';

@immutable
abstract class PostGetEvent {}

class PostGetAll extends PostGetEvent {
  final int? page;
  final int? perPage;

  PostGetAll(this.page, this.perPage);
}
