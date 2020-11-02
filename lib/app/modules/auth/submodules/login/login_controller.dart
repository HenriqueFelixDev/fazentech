import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginController {
  final userController = Modular.get<UserController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginWithEmailAndPassword() async{
    await userController.signInWithEmailAndPassword(
      emailController.text,
      passwordController.text
    );
  }
}