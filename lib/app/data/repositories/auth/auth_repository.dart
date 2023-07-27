import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/exceptions/unauthorized_exception.dart';
import '../../../core/rest_client/rest_client.dart';
import '../../models/auth_model.dart';
import 'i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final RestClient _restClient;

  AuthRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final auth = await _restClient.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return AuthModel.fromMap(auth.data);
    } on DioException catch (err, s) {
      const message = 'Erro ao realizar login.';

      log(message, error: err, stackTrace: s);

      if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
        throw UnauthorizedException('e-Mail ou senha inválidos.');
      }

      throw RepositoryException(message);
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await _restClient.publicRequest().post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } on DioException catch (err, s) {
      const message = 'Erro ao registrar um novo usuário.';

      log(message, error: err, stackTrace: s);

      throw RepositoryException(message);
    }
  }
}
