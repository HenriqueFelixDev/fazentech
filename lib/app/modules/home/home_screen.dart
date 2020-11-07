import 'package:fazentech/app/modules/home/components/home_banner_widget.dart';
import 'package:fazentech/app/modules/home/components/product_home_section.dart';
import 'package:fazentech/app/modules/home/home_controller.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/controllers/user_store.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_api.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum MenuButtons {
  ACCOUNT, ORDERS, SIGNOUT
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userController = Modular.get<UserStore>();
  final controller = HomeController(ProductRepositoryAPI());

  @override
  void initState() {
    super.initState();
    controller.searchRecentlyAddedProducts();
    controller.searchTopProducts();
  }

  _onMenuItemPressed(MenuButtons buttonPressed, UserModel user) {
    switch(buttonPressed) {
      case MenuButtons.ACCOUNT:
        Modular.to.pushNamed('/account', arguments: user);
        break;
      case MenuButtons.ORDERS:
        Modular.to.pushNamed('/orders');
        break;
      case MenuButtons.SIGNOUT:
        _signOut();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if(userController.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: CustomAppBarWidget(
            titleText: 'FazenTech',
            actions: [
              if(userController.user != null) _avatarMenu(userController.user)
              else _signInButton()
            ]
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            children: [
              HomeBannerWidget(),
              SizedBox(height: 16.0),
              StreamBuilder(
                stream: controller.recentlyAddedProducts,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ProductHomeSection(
                    title: 'Adicionados Recentemente',
                    products: snapshot.data,
                    onSeeAllPressed: (){},
                  );
                }
              ),
              StreamBuilder(
                stream: controller.topProducts,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ProductHomeSection(
                    title: 'Mais Comprados',
                    products: snapshot.data,
                    onSeeAllPressed: (){},
                  );
                }
              ),
            ],
          )
        );

      }
    );
  }

  Widget _avatarMenu(UserModel user) {
    return PopupMenuButton<MenuButtons>(
      onSelected: (selectedItem) => _onMenuItemPressed(selectedItem, user),
      offset: Offset(0, 50.0),
      icon:CircleAvatar(
          backgroundImage: user.photo == null 
            ? AssetImage('assets/img/avatar.png')
            : NetworkImage(user.photo)
      ),
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

  Widget _signInButton() {
    return FlatButton(
      child: Text('Fazer Login', style: TextStyle(color: Theme.of(context).accentColor)),
      onPressed: _signOut
    );
  }

  Future<void> _signOut() async{
    await userController.signOut();
    Modular.to.pushReplacementNamed('/auth');
  }
}