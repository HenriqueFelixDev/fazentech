import 'package:fazentech/app/modules/account/account_controller.dart';
import 'package:fazentech/app/modules/account/components/account_header_widget.dart';
import 'package:fazentech/app/modules/account/components/card_account_details.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AccountScreen extends StatefulWidget {
  final UserModel user;
  AccountScreen(this.user,
  {
    Key key
  }) : super(key: key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _accountController = Modular.get<AccountController>();
  double progress;

  @override
  void didUpdateWidget(AccountScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _onUploadPhotoSuccess(String url) {
    if(url == null) return;

    setState(() {
      widget.user.photo = url;
      _accountController.updateAccount(widget.user);
    });
    
  }

  bool _onUploadPhotoProgress(double progress) {
    setState(() => this.progress = progress);
    return true;
  }

  void _onUploadPhotoError(dynamic error) {
    print('ERROR: $error');
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final address = widget.user.address;

    return Scaffold(
      body: ListView(
        children: [
          if(progress != null) LinearProgressIndicator(value: progress),

          AccountHeaderWidget(
            name: user.name, 
            email: user.email, 
            profileImage: user.photo,
            onChangeProfilePhotoPressed: (source) {
              _accountController.pickImage(source, _onUploadPhotoProgress, _onUploadPhotoSuccess, _onUploadPhotoError);
            },
          ),
          CardAccountDetails(
            onEditPressed: (){},
            title: 'Dados Pessoais',
            accountData: {
              'Nome': user.name,
              'E-mail': user.email,
              'CPF': user.cpf,
              'RG': user.rg
            }
          ),
          CardAccountDetails(
            onEditPressed: (){},
            title: 'Endereço',
            accountData: {
              'Rua': address.street,
              'Número': address.number,
              'Bairro': address.district,
              'Cidade': address.city,
              'Estado': address.state.name.toUpperCase(),
              'Complemento': address.complement == null || address.complement.isEmpty
                  ? 'Nenhum'
                  : address.complement,
              'CEP': address.postalCode,
            }
          )
        ]
      )
    );
  }
}