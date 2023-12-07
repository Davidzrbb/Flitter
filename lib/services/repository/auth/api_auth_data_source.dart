import 'package:dio/dio.dart';
import 'package:flitter/models/connexion_user.dart';
import 'package:flitter/models/inscription_user.dart';
import 'package:flitter/models/user.dart';

import 'auth_data_source.dart';

class ApiAuthDataSource extends AuthDataSource {
  @override
  Future<String> doConnexion(ConnexionUser connexionUser) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'email': connexionUser.email,
      'password': connexionUser.password,
    };
    Response<dynamic> response = await dio
        .post('/auth/login', data: data)
        .catchError((error) => throw error.response.data['message']);
    return response.data['authToken'];
  }

  @override
  Future<User> doIsConnected(String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Response<dynamic> response = await dio
        .get('/auth/me',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            }))
        .catchError((error) => throw error.response.data['message']);
    return User.fromJson(response.data);
  }

  @override
  Future<String> doInscription(InscriptionUser inscriptionUser) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'name': inscriptionUser.name,
      'email': inscriptionUser.email,
      'password': inscriptionUser.password,
    };
    Response<dynamic> response = await dio
        .post('/auth/signup', data: data)
        .catchError((error) => throw error.response.data['message']);
    return response.data['authToken'];
  }
}
