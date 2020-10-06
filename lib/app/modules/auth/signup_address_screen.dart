import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/form/custom_text_form_field_widget.dart';
import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpAddressScreen extends StatefulWidget {
  @override
  _SignUpAddressScreenState createState() => _SignUpAddressScreenState();
}

class _SignUpAddressScreenState extends State<SignUpAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: Text('Endereço', style: TextStylesSet.appBarTitleStyle),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => Modular.to.popUntil(ModalRoute.withName('/login')),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextFormField(
            label: 'Rua',
            controller: TextEditingController()
          ),
          CustomTextFormField(
            label: 'Número',
            controller: TextEditingController(),
            keyboardType: TextInputType.number,
          ),
          CustomTextFormField(
            label: 'Bairro',
            controller: TextEditingController(),
            obscureText: true
          ),
          CustomTextFormField(
            label: 'CEP',
            controller: TextEditingController(),
            keyboardType: TextInputType.streetAddress
          ),
          CustomTextFormField(
            label: 'Cidade',
            controller: TextEditingController()
          ),
          CustomTextFormField(
            label: 'Estado',
            controller: TextEditingController(),
            keyboardType: TextInputType.datetime
          ),
          CustomTextFormField(
            label: 'Complemento',
            controller: TextEditingController(),
            keyboardType: TextInputType.phone
          )
        ]
      )
    );
  }
}