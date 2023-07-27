import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../data/repositories/auth/i_auth_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final IAuthRepository _authRepository;

  RegisterCubit({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));

      await _authRepository.register(name, email, password);

      emit(state.copyWith(status: RegisterStatus.success));
    } on Exception catch (err, s) {
      log('Erro ao cadastrar usuário', error: err, stackTrace: s);

      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
