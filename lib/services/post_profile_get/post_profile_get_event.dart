part of 'post_profile_get_bloc.dart';

@immutable
abstract class PostProfileGetEvent {}

class GetProfileAllPosts extends PostProfileGetEvent {
  final bool refresh;
  final int userId;

  GetProfileAllPosts(this.userId, this.refresh);

}
