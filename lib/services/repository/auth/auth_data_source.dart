import '../../../models/connexion_user.dart';
import '../../../models/user.dart';

abstract class AuthDataSource {
  Future<String> doConnexion(ConnexionUser connexionUser);

  Future<User> doIsConnected(String token);
}
