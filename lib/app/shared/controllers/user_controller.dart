import 'dart:async';

import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

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
    UserModel user = await authRepository.getSignedUser();
    _userController.sink.add(user);
    _loadingController.sink.add(false);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async{
    UserModel user = await authRepository.signInWithEmailAndPassword(email, password);
    _userController.sink.add(user);
  }

  Future<void> signOut() async{
    await authRepository.signOut();
    _userController.sink.add(null);
  }

  Future<void> signUpWithEmailAndPassword(UserModel user) async{
    UserModel signedUser = await authRepository.signUpWithEmailAndPassword(user);
    if(signedUser == null) return;

    _userController.sink.add(signedUser);
  }

  Future<void> updateUser(UserModel user) async{
    await authRepository.updateAccount(user);

    _userController.sink.add(user);
  }

  @override
  void dispose() {
    _loadingController.close();
    _userController.close();
  }
}