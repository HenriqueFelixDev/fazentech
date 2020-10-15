import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/models/user/address.dart';
import 'package:fazentech/app/shared/models/user/address_state.dart';
import 'package:fazentech/app/shared/models/user/phone.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignupController {
  final _userController = Modular.get<UserController>();
  AddressState state = AddressState.ac;
  final List<AddressState> _states = AddressState.values.toList();
  List<AddressState> get states => _states;
  
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpfController = TextEditingController();
  final rgController = TextEditingController();
  final birthdayController = TextEditingController();
  final phoneDDDController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cellphoneDDDController = TextEditingController();
  final cellphoneNumberController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final complementController = TextEditingController();

  final nameNode = FocusNode();
  final streetNode = FocusNode();

  Future<void> signUp() async{
    final user = UserModel(
      name: nameController.text,
      email: emailController.text,
      cpf: cpfController.text,
      rg: rgController.text,
      password: passwordController.text,
      phone: Phone(
        areaCode: phoneDDDController.text,
        number: phoneNumberController.text 
      ),
      cellphone: Phone(
        areaCode: cellphoneDDDController.text,
        number: cellphoneNumberController.text 
      ),
      birthday: DateTime.tryParse(birthdayController.text),
      address: Address(
        street: streetController.text,
        number: numberController.text,
        city: cityController.text,
        state: state,
        postalCode: postalCodeController.text,
        district: districtController.text,
        complement: complementController.text,
      )
    );

    await _userController.signUpWithEmailAndPassword(user);
  }
}