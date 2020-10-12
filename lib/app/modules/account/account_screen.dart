import 'package:fazentech/app/modules/account/components/account_header_widget.dart';
import 'package:fazentech/app/modules/account/components/card_account_details.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AccountHeaderWidget(
            name: 'João da Silva', 
            email: 'joaosilva@mail.com', 
            profileImage: NetworkImage('https://cdn1.iconfinder.com/data/icons/avatar-97/32/avatar-02-512.png')
          ),
          CardAccountDetails(
            onEditPressed: (){},
            title: 'Dados Pessoais',
            accountData: {
              'Nome': 'João da Silva',
              'E-mail': 'joaosilva@mail.com',
              'CPF': '1**.***.***-*8',
              'RG': '4*.***.***-1'
            }
          ),
          CardAccountDetails(
            onEditPressed: (){},
            title: 'Endereço',
            accountData: {
              'Rua': 'Rua Floriano Peixoto',
              'Número': '92',
              'Bairro': 'Centro',
              'Cidade': 'Rio Verde',
              'Estado': 'GO',
              'Complemento': 'Nenhum',
              'CEP': '00.000-000',
            }
          )
        ]
      )
    );
  }
}