part of 'profile_get_bloc.dart';

enum ProfileGetStatus {
  initial,
  loading,
  success,
  error,
}

final class ProfileGetState {
  final ProfileGetStatus status;
  final GetProfile? profile;
  final Object? error;

  ProfileGetState({
    this.status = ProfileGetStatus.initial,
    this.profile,
    this.error,
  });

  ProfileGetState copyWith({
    ProfileGetStatus? status,
    GetProfile? profile,
    Object? error,
  }) {
    return ProfileGetState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      error: error ?? this.error,
    );
  }
}
