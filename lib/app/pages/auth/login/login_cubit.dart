import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/exceptions/unauthorized_exception.dart';
import '../../../data/repositories/auth/i_auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final IAuthRepository _authRepository;

  LoginCubit({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));

      await Future.delayed(const Duration(seconds: 2));

      final auth = await _authRepository.login(email, password);

      final storage = await SharedPreferences.getInstance();
      storage.setString('accessToken', auth.accessToken);
      storage.setString('refreshToken', auth.refreshToken);

      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (err, s) {
      const message = 'e-Mail ou senha inválidos';

      log(message, error: err, stackTrace: s);

      emit(state.copyWith(status: LoginStatus.loginError, errorMessage: message));
    } on RepositoryException catch (err, s) {
      const message = 'Erro ao realizar o login do usuário';

      log(err.message ?? message, error: err, stackTrace: s);

      emit(state.copyWith(status: LoginStatus.error, errorMessage: err.message ?? message));
    }
  }
}
