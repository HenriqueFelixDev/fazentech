import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../models/user/user_model.dart';
import '../repositories/auth/auth_repository_interface.dart';
import '../repositories/user/user_repository_interface.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store{
  IAuthRepository authRepository;
  IUserRepository userRepository;
  _UserStoreBase(this.authRepository, this.userRepository) {
    _getSignedUser();
  }

  @observable
  UserModel user;

  @observable
  bool isLoading = false;

  @action
  Future<void> _getSignedUser() async{
    isLoading = true;
    final user = await userRepository.getUserById('1');
    this.user = user;
    isLoading = false;
  }

  @action
  Future<void> signInWithEmailAndPassword(String email, String password) async{
    await authRepository.signInWithEmailAndPassword(email, password);
    final user = await userRepository.getUserById('1');
    this.user = user;
  }

  @action
  Future<void> signOut() async{
    await authRepository.signOut();
    this.user = null;
  }

  @action
  Future<void> signUpWithEmailAndPassword(UserModel user) async {
    await userRepository.saveUser(user);
    final signedUser = await userRepository.getUserById('1');
    if(signedUser == null) return;

    this.user = signedUser;
  }

  @action
  Future<void> updateUser(UserModel user) async{
    await userRepository.updateUser(user);
    this.user = user;
  }
}