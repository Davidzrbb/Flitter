part of 'inscription_bloc.dart';

enum InscriptionStatus {
  initial,
  loading,
  success,
  error,
}

final class InscriptionState {
  final InscriptionStatus status;
  final InscriptionUser inscription;
  final Object? error;

  InscriptionState({
    this.status = InscriptionStatus.initial,
    this.inscription = const InscriptionUser(),
    this.error,
  });

  InscriptionState copyWith({
    InscriptionStatus? status,
    InscriptionUser? inscription,
    Object? error,
  }) {
    return InscriptionState(
      status: status ?? this.status,
      inscription: inscription ?? this.inscription,
      error: error ?? this.error,
    );
  }
}
