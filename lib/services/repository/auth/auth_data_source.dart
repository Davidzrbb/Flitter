import '../../../models/connexion_user.dart';

abstract class AuthDataSource {
  Future<String> doConnexion(ConnexionUser connexionUser);
}
