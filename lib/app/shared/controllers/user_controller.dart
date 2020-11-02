import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import '../models/user/user_model.dart';
import '../repositories/auth/auth_repository_interface.dart';
import '../repositories/user/user_repository_interface.dart';

class UserController implements Disposable{
  IAuthRepository authRepository;
  IUserRepository userRepository;
  StreamController<UserModel> _userController = BehaviorSubject();
  StreamController<bool> _loadingController = StreamController();
  UserController(this.authRepository, this.userRepository) {
    _getSignedUser();
  }

  Stream<UserModel> get user => _userController.stream;
  Stream<bool> get loadingUser => _loadingController.stream;

  Future<void> _getSignedUser() async{
    _loadingController.sink.add(true);
    final user = await userRepository.getUserById('1');
    _userController.sink.add(user);
    _loadingController.sink.add(false);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async{
    await authRepository.signInWithEmailAndPassword(email, password);
    final user = await userRepository.getUserById('1');
    _userController.sink.add(user);
  }

  Future<void> signOut() async{
    await authRepository.signOut();
    _userController.sink.add(null);
  }

  Future<void> signUpWithEmailAndPassword(UserModel user) async {
    await userRepository.saveUser(user);
    final signedUser = await userRepository.getUserById('1');
    if(signedUser == null) return;

    _userController.sink.add(signedUser);
  }

  Future<void> updateUser(UserModel user) async{
    await userRepository.updateUser(user);
    _userController.sink.add(user);
  }

  @override
  void dispose() {
    _loadingController.close();
    _userController.close();
  }
}