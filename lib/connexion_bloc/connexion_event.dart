part of 'connexion_bloc.dart';

@immutable
abstract class ConnexionEvent {}

class ConnexionSubmitted extends ConnexionEvent {
  final ConnexionUser connexionUser;

  ConnexionSubmitted(this.connexionUser);
}
