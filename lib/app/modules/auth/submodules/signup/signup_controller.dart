import 'package:fazentech/app/exceptions/invalid_parameters_exception.dart';
import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/controllers/user_store.dart';
import 'package:fazentech/app/shared/models/user/address.dart';
import 'package:fazentech/app/shared/models/user/address_state.dart';
import 'package:fazentech/app/shared/models/user/phone.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignupController {
  final _userController = Modular.get<UserStore>();

  String error;

  AddressState state = AddressState.ac;
  final List<AddressState> _states = AddressState.values.toList();
  List<AddressState> get states => _states;
  String stateError;
  
  final nameController = TextEditingController();
  String nameError;
  
  final emailController = TextEditingController();
  String emailError;
  
  final passwordController = TextEditingController();
  String passwordError;
  
  final cpfController = TextEditingController();
  String cpfError;
  
  final rgController = TextEditingController();
  String rgError;
  
  final birthdayController = TextEditingController();
  String birthdayError;
  
  final phoneDDDController = TextEditingController();
  String phoneDDDError;
  
  final phoneNumberController = TextEditingController();
  String phoneNumberError;
  
  final cellphoneDDDController = TextEditingController();
  String cellphoneDDDError;
  
  final cellphoneNumberController = TextEditingController();
  String cellphoneNumberError;
  
  final streetController = TextEditingController();
  String streetError;
  
  final numberController = TextEditingController();
  String numberError;
  
  final neighborhoodController = TextEditingController();
  String neighborhoodError;
  
  final cityController = TextEditingController();
  String cityError;
  
  final postalCodeController = TextEditingController();
  String postalCodeError;

  final complementController = TextEditingController();
  String complementError;

  final nameNode = FocusNode();
  final streetNode = FocusNode();

  String _getFieldMessage(InvalidParametersException error, String field) {
    return error?.getFieldError(field)?.msg;
  }

  Future<bool> signUp() async{
    try {
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
          neighborhood: neighborhoodController.text,
          complement: complementController.text,
        )
      );

      final userTest = UserModel(
        name: 'Henrique',
        email: 'henrique@mail.com',
        cpf: '13589941618',
        rg: '123456789',
        password: 'abcd1234',
        phone: Phone(
          areaCode: '31',
          number: '37531449' 
        ),
        cellphone: Phone(
          areaCode: '31',
          number: '983489321' 
        ),
        birthday: DateTime(1999, 04, 13),
        address: Address(
          street: 'Rua X',
          number: '40',
          city: 'Rio Espera',
          state: AddressState.mg,
          postalCode: '36460000',
          neighborhood: 'Centro',
          complement: '',
        )
      );

      await _userController.signUpWithEmailAndPassword(userTest);
    } on InvalidParametersException catch(e) {
      error = 'Alguns campos estão com valores inválidos';
      nameError = _getFieldMessage(e, 'name');
      emailError = _getFieldMessage(e, 'email');
      passwordError = _getFieldMessage(e, 'password');
      cpfError = _getFieldMessage(e, 'cpf');
      rgError = _getFieldMessage(e, 'rg');
      birthdayError = _getFieldMessage(e, 'birthday');
      phoneDDDError = _getFieldMessage(e, 'phone.area_code');
      phoneNumberError = _getFieldMessage(e, 'phone.number');
      cellphoneDDDError = _getFieldMessage(e, 'cellphone.area_code');
      cellphoneNumberError = _getFieldMessage(e, 'cellphone.number');
      streetError = _getFieldMessage(e, 'address.street');
      numberError = _getFieldMessage(e, 'address.number');
      neighborhoodError = _getFieldMessage(e, 'address.neighborhood');
      cityError = _getFieldMessage(e, 'address.city');
      postalCodeError = _getFieldMessage(e, 'address.postal_code');
      complementError = _getFieldMessage(e, 'address.complement');
      stateError = _getFieldMessage(e, 'address.state');
      return false;
    } catch(e) {
      error = 'Ocorreu um erro ao cadastrar o usuário';
      return false;
    }

    return true;
  }
}