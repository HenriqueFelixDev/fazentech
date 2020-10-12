import 'package:fazentech/app/modules/auth/components/bottom_login_painter.dart';
import 'package:fazentech/app/shared/components/form/custom_text_form_field_widget.dart';
import 'package:fazentech/app/shared/theme/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller: TextEditingController(),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false
                          ),
                          CustomTextFormField(
                            label: 'Senha', 
                            controller: TextEditingController(),
                            obscureText: true
                          ),
                          Container(
                            height: 50.0,
                            child: MaterialButton(
                              color: Theme.of(context).accentColor,
                              colorBrightness: Brightness.dark,
                              child: Text('Entrar'),
                              onPressed: () => Modular.to.pushReplacementNamed('/'),
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
                                onTap: () => Navigator.of(context).pushNamed('/cadastro'),
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
}