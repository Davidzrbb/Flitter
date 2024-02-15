part of 'profile_get_bloc.dart';

@immutable
abstract class ProfileGetEvent {}

class GetProfileInfo extends ProfileGetEvent {
  final int userId;

  GetProfileInfo(this.userId);

}
