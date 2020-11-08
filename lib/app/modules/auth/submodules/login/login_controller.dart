import 'package:fazentech/app/shared/exceptions/authentication_exception.dart';
import 'package:fazentech/app/shared/controllers/user_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginController {
  final userController = Modular.get<UserStore>();

  void Function(String) onError;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginWithEmailAndPassword() async{
    try {
      await userController.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text
      );
    } on AuthenticationException catch(e) {
      onError?.call(e.message);
    } catch(e) {
      onError?.call('Ocorreu um erro ao realizar o login');
    }
  }
}