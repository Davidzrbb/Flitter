part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  error,
}

final class ProfileState {
  final ProfileStatus status;
  final Profile? profile;
  final Object? error;

  ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    Profile? profile,
    Object? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      error: error ?? this.error,
    );
  }
}
