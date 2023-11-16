part of 'connexion_bloc.dart';

@immutable
abstract class ConnexionEvent {}

class ConnexionSubmitted extends ConnexionEvent {
  final ConnexionUser connexionUser;

  ConnexionSubmitted(this.connexionUser);
}

class IsConnected extends ConnexionEvent {
  final BuildContext context;
  IsConnected(this.context);
}

class Disconnected extends ConnexionEvent {
  Disconnected();
}
