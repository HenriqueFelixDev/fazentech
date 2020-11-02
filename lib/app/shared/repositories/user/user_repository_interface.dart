import '../../models/user/user_model.dart';

abstract class IUserRepository {
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<UserModel> getUserById(String id);
}