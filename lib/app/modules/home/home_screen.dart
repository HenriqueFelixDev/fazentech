import 'package:fazentech/app/modules/home/components/home_banner_widget.dart';
import 'package:fazentech/app/modules/home/components/product_home_section.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum MenuButtons {
  ACCOUNT, ORDERS, SIGNOUT
}

_onMenuItemPressed(MenuButtons buttonPressed) {
  switch(buttonPressed) {
    case MenuButtons.ACCOUNT:
      Modular.to.pushNamed('/account');
      break;
    case MenuButtons.ORDERS:
      Modular.to.pushNamed('/orders');
      break;
    case MenuButtons.SIGNOUT:
      Modular.to.pushReplacementNamed('/login');
      break;
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'FazenTech',
        actions: [
          _avatarMenu()
        ]
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          children: [
            HomeBannerWidget(),
            SizedBox(height: 16.0),
            ProductHomeSection(),
            ProductHomeSection(),
            ProductHomeSection(),
          ],
        )
      )
    );
  }

  Widget _avatarMenu() {
    return PopupMenuButton<MenuButtons>(
      onSelected: _onMenuItemPressed,
      offset: Offset(0, 50.0),
      icon: Image.network('https://cdn1.iconfinder.com/data/icons/avatar-97/32/avatar-02-512.png', fit: BoxFit.cover),
      itemBuilder: (context) {
        return <PopupMenuEntry<MenuButtons>>[
          PopupMenuItem(
            child: Row(
              children: [
                Icon(Icons.person),
                Text('Minha Conta')
              ],
            ),
            value: MenuButtons.ACCOUNT
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Icon(Icons.shopping_bag_rounded),
                Text('Pedidos')
              ],
            ),
            value: MenuButtons.ORDERS,
          ),
          PopupMenuDivider(),
          PopupMenuItem(
            child: Row(
              children: [
                Icon(Icons.power_settings_new_outlined),
                Text('Sair')
              ],
            ),
            value: MenuButtons.SIGNOUT
          )
        ];
      },
    );
  }
}