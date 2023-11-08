part of 'connexion_bloc.dart';

enum ConnexionStatus {
  initial,
  loading,
  success,
  error,
}

final class ConnexionState {
  final ConnexionStatus status;
  final ConnexionUser connexion;
  final Object? error;

  ConnexionState({
    this.status = ConnexionStatus.initial,
    this.connexion = const ConnexionUser(),
    this.error,
  });

  ConnexionState copyWith({
    ConnexionStatus? status,
    ConnexionUser? connexion,
    Object? error,
  }) {
    return ConnexionState(
      status: status ?? this.status,
      connexion: connexion ?? this.connexion,
      error: error ?? this.error,
    );
  }
}
