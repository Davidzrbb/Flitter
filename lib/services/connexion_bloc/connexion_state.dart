part of 'connexion_bloc.dart';

enum ConnexionStatus {
  initial,
  loading,
  success,
  error,
}

final class ConnexionState {
  final ConnexionStatus status;
  final ConnexionUser? connexion;
  final Object? error;
  final User? user;

  ConnexionState({
    this.status = ConnexionStatus.initial,
    this.connexion,
    this.error,
    this.user,
  });

  ConnexionState copyWith({
    ConnexionStatus? status,
    ConnexionUser? connexion,
    Object? error,
    User? user,
  }) {
    return ConnexionState(
      status: status ?? this.status,
      connexion: connexion ?? this.connexion,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
