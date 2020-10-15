import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_interface.dart';

abstract class IAuthRepository {
  IUserRepository userRepository;

  Future<UserModel> getSignedUser();
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<UserModel> signUpWithEmailAndPassword(UserModel user);
  Future<void> updateAccount(UserModel user);
}