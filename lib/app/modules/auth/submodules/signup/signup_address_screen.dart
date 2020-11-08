import 'package:fazentech/app/shared/exceptions/invalid_parameters_exception.dart';
import 'package:fazentech/app/modules/auth/submodules/signup/signup_controller.dart';
import 'package:fazentech/app/shared/components/alerts/snackbar_alert_widget.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/form/custom_text_form_field_widget.dart';
import 'package:fazentech/app/shared/components/loading_dialog_widget.dart';
import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/controllers/user_store.dart';
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
  final userController = Modular.get<UserStore>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(signupController.streetNode);
    });
  }

  Future<void> _signUp() async{
      FocusScope.of(context).unfocus();
      showSignUpWaitingModal(context);
      bool result = await signupController.signUp();
      if(result) {
        Modular.to.popUntil(ModalRoute.withName('/auth'));
      } else {
        await Future.delayed(Duration(milliseconds: 500));
        Navigator.of(context).pop();
        _scaffoldKey.currentState.showSnackBar(
          SnackbarAlertWidget(message: signupController.error, type: AlertType.ERROR)
        );
        setState((){});
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            errorMessage: signupController.streetError,
            controller: signupController.streetController
          ),

          CustomTextFormField(
            label: 'Número',
            textInputAction: TextInputAction.next,
            errorMessage: signupController.numberError,
            controller: signupController.numberController,
            keyboardType: TextInputType.number,
          ),

          CustomTextFormField(
            label: 'Bairro',
            textInputAction: TextInputAction.next,
            errorMessage: signupController.neighborhoodError,
            controller: signupController.neighborhoodController,
            obscureText: true
          ),

          CustomTextFormField(
            label: 'CEP',
            textInputAction: TextInputAction.next,
            errorMessage: signupController.postalCodeError,
            controller: signupController.postalCodeController,
            keyboardType: TextInputType.streetAddress
          ),

          CustomTextFormField(
            label: 'Cidade',
            textInputAction: TextInputAction.next,
            errorMessage: signupController.cityError,
            controller: signupController.cityController
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text('Estado')
          ),
          DropdownButtonFormField<AddressState>(
            decoration: InputDecoration(
              errorText: signupController.stateError,
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
            errorMessage: signupController.complementError,
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
      builder: (_) => LoadingDialogWidget(message: 'Cadastrando usuário...')
    );
  }
}