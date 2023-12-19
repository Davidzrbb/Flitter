part of 'profile_get_bloc.dart';

@immutable
abstract class ProfileGetEvent {}

class GetProfileInfo extends ProfileGetEvent {
  final int userId;

  GetProfileInfo(this.userId);

}

class GetProfileAllPosts extends ProfileGetEvent {
  final bool refresh;
  final int userId;

  GetProfileAllPosts(this.userId, {this.refresh = false});

}
