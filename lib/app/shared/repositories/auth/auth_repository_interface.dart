import '../../models/user/user_model.dart';

abstract class IAuthRepository {
  Future<String> getAuthenticationToken();
  // Retorna o token JWT e o RefreshToken
  Future<Map<String, String>> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(UserModel user);
  Future<void> signOut();
}