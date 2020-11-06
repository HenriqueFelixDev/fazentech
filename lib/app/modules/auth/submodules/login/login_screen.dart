import 'dart:async';

import 'package:fazentech/app/modules/auth/components/bottom_login_painter.dart';
import 'package:fazentech/app/modules/auth/submodules/login/login_controller.dart';
import 'package:fazentech/app/shared/components/form/custom_text_form_field_widget.dart';
import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/controllers/user_store.dart';
import 'package:fazentech/app/shared/theme/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = Modular.get<UserStore>();
  final loginController = LoginController();

  ReactionDisposer userDisposer;

  @override
  void initState() {
    super.initState();
    userDisposer = autorun((_) {
      if(userController.user != null) {
        Modular.to.pushReplacementNamed('/main');
      }
    });
  }

  @override
  void dispose() {
    userDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomPaint(
          painter: BottomLoginPainter(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.58, 0.99],
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withAlpha(100),
              ]
            )
          ),
          child: Container(
            child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.66
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 120.0,
                            margin: const EdgeInsets.symmetric(vertical: 32.0),
                            child: Image.asset(AssetsSet.appLogo)
                          ),
                          CustomTextFormField(
                            label: 'E-mail', 
                            controller: loginController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false
                          ),
                          CustomTextFormField(
                            label: 'Senha', 
                            controller: loginController.passwordController,
                            obscureText: true
                          ),
                          Container(
                            height: 50.0,
                            child: MaterialButton(
                              color: Theme.of(context).accentColor,
                              colorBrightness: Brightness.dark,
                              child: Text('Entrar'),
                              onPressed: _login,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50.0),
                      alignment: Alignment.bottomCenter,
                      child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Não possui cadastro?', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                              GestureDetector(
                                onTap: () => Modular.to.pushNamed('/auth/signup'),
                                child: Text('Criar nova conta', style: TextStyle(fontSize: 20.0, color: Theme.of(context).accentColor))
                              )

                            ],
                          ),
                    )
                  ]
                ),
          ),
        )
      )
    );
  }

  Future<void> _login() async{
    await loginController.loginWithEmailAndPassword();
  }
}