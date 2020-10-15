import 'package:fazentech/app/modules/auth/submodules/signup/signup_controller.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/form/custom_text_form_field_widget.dart';
import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/models/user/address.dart';
import 'package:fazentech/app/shared/models/user/address_state.dart';
import 'package:fazentech/app/shared/models/user/phone.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpAddressScreen extends StatefulWidget {
  @override
  _SignUpAddressScreenState createState() => _SignUpAddressScreenState();
}

class _SignUpAddressScreenState extends State<SignUpAddressScreen> {
  final signupController = Modular.get<SignupController>();
  final userController = Modular.get<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(signupController.streetNode);
    });
  }

  Future<void> _signUp() async{
    showSignUpWaitingModal(context);
    await signupController.signUp();
    Modular.to.popUntil(ModalRoute.withName('/auth'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Endereço',
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _signUp,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextFormField(
            label: 'Rua',
            focusNode: signupController.streetNode,
            textInputAction: TextInputAction.next,
            controller: signupController.streetController
          ),

          CustomTextFormField(
            label: 'Número',
            textInputAction: TextInputAction.next,
            controller: signupController.numberController,
            keyboardType: TextInputType.number,
          ),

          CustomTextFormField(
            label: 'Bairro',
            textInputAction: TextInputAction.next,
            controller: signupController.districtController,
            obscureText: true
          ),

          CustomTextFormField(
            label: 'CEP',
            textInputAction: TextInputAction.next,
            controller: signupController.postalCodeController,
            keyboardType: TextInputType.streetAddress
          ),

          CustomTextFormField(
            label: 'Cidade',
            textInputAction: TextInputAction.next,
            controller: signupController.cityController
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text('Estado')
          ),
          DropdownButtonFormField<AddressState>(
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
            value: signupController.state,
            onChanged: (value) => signupController.state = value,
            items: signupController.states.map((state) =>
              DropdownMenuItem<AddressState>(
                child: Text(state.name.toUpperCase()),
                value: state
              )
            ).toList()
          ),

          SizedBox(height: 16.0),

          CustomTextFormField(
            label: 'Complemento',
            textInputAction: TextInputAction.done,
            onEditingComplete: _signUp,
            controller: signupController.complementController,
            keyboardType: TextInputType.phone
          )
        ]
      )
    );
  }

  void showSignUpWaitingModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Cadastrando usuário...'),
              SizedBox(height: 8.0),
              CircularProgressIndicator()
            ]
          )
        );
      }
    );
  }
}