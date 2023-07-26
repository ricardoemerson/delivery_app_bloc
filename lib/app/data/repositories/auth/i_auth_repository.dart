import '../../models/auth_model.dart';

abstract class IAuthRepository {
  Future<AuthModel> login(String email, String password);
  Future<void> register(String name, String email, String password);
}
