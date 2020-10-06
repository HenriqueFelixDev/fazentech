import 'package:fazentech/app/modules/account/components/account_header_widget.dart';
import 'package:fazentech/app/modules/account/components/card_account_details.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

Widget _cardAccountDetails(BuildContext context, String title, Map<String, String> accountData) {
  
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
            profileImage: NetworkImage('https://static.thenounproject.com/png/2684601-200.png')
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