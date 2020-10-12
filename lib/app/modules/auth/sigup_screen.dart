import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/form/custom_text_form_field_widget.dart';
import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Nova Conta',
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => Modular.to.pushNamed('/cadastro/endereco'),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextFormField(
            label: 'Nome',
            controller: TextEditingController()
          ),
          CustomTextFormField(
            label: 'E-mail',
            controller: TextEditingController(),
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextFormField(
            label: 'Senha',
            controller: TextEditingController(),
            obscureText: true
          ),
          CustomTextFormField(
            label: 'CPF',
            controller: TextEditingController(),
            keyboardType: TextInputType.number
          ),
          CustomTextFormField(
            label: 'RG',
            controller: TextEditingController(),
            keyboardType: TextInputType.number
          ),
          CustomTextFormField(
            label: 'Nascimento',
            controller: TextEditingController(),
            keyboardType: TextInputType.datetime
          ),
          CustomTextFormField(
            label: 'Telefone Fixo',
            controller: TextEditingController(),
            keyboardType: TextInputType.phone
          ),
          CustomTextFormField(
            label: 'Celular',
            controller: TextEditingController(),
            keyboardType: TextInputType.phone
          ),
        ]
      )
    );
  }
}