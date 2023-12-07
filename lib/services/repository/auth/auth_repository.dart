import '../../../models/connexion_user.dart';
import 'auth_data_source.dart';

class AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  Future<String> doConnexion(ConnexionUser connexionUser) async {
    return authDataSource.doConnexion(connexionUser);
  }
}
