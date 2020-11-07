import 'package:fazentech/app/modules/auth/submodules/signup/signup_controller.dart';
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
  final signupController = Modular.get<SignupController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(signupController.nameNode);
    });
  }

  void _goToAddressSignupScreen() async{
    await Modular.link.pushNamed('/address');
    setState((){});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Nova Conta',
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _goToAddressSignupScreen
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextFormField(
            label: 'Nome',
            focusNode: signupController.nameNode,
            textInputAction: TextInputAction.next,
            errorMessage: signupController.nameError,
            controller: signupController.nameController
          ),
          CustomTextFormField(
            label: 'E-mail',
            textInputAction: TextInputAction.next,
            controller: signupController.emailController,
            errorMessage: signupController.emailError,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextFormField(
            label: 'Senha',
            textInputAction: TextInputAction.next,
            errorMessage: signupController.passwordError,
            controller: signupController.passwordController,
            obscureText: true
          ),
          CustomTextFormField(
            label: 'CPF',
            textInputAction: TextInputAction.next,
            errorMessage: signupController.cpfError,
            controller: signupController.cpfController,
            keyboardType: TextInputType.number
          ),
          CustomTextFormField(
            label: 'RG',
            textInputAction: TextInputAction.next,
            errorMessage: signupController.rgError,
            controller: signupController.rgController,
            keyboardType: TextInputType.number
          ),
          CustomTextFormField(
            label: 'Nascimento',
            textInputAction: TextInputAction.next,
            errorMessage: signupController.birthdayError,
            controller: signupController.birthdayController,
            keyboardType: TextInputType.datetime
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text('Telefone Fixo')
          ),
          Row(
            children: [
              Container(
                width: 100.0,
                margin: const EdgeInsets.only(right: 16.0),
                child: CustomTextFormField(
                  label: 'DDD',
                  textInputAction: TextInputAction.next,
                  errorMessage: signupController.phoneDDDError,
                  controller: signupController.phoneDDDController,
                  keyboardType: TextInputType.phone
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  label: 'Número',
                  textInputAction: TextInputAction.next,
                  errorMessage: signupController.phoneNumberError,
                  controller: signupController.phoneNumberController,
                  keyboardType: TextInputType.phone
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text('Celular')
          ),
          Row(
            children: [
              Container(
                width: 100.0,
                margin: const EdgeInsets.only(right: 16.0),
                child: CustomTextFormField(
                  label: 'DDD',
                  textInputAction: TextInputAction.next,
                  errorMessage: signupController.cellphoneDDDError,
                  controller: signupController.cellphoneDDDController,
                  keyboardType: TextInputType.phone
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  label: 'Número',
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _goToAddressSignupScreen,
                  errorMessage: signupController.cellphoneNumberError,
                  controller: signupController.cellphoneNumberController,
                  keyboardType: TextInputType.phone
                ),
              ),
            ]
          )
        ]
      )
    );
  }
}