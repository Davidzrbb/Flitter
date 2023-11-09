part of 'inscription_bloc.dart';

@immutable
abstract class InscriptionEvent {}

class InscriptionSubmitted extends InscriptionEvent {
  final InscriptionUser inscriptionUser;

  InscriptionSubmitted(this.inscriptionUser);
}
