import 'package:fazentech/app/modules/cart/cart_controller.dart';
import 'package:fazentech/app/shared/controllers/user_store.dart';
import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/repositories/order/order_repository_api.dart';
import 'package:flutter/material.dart';
import 'package:fazentech/app/modules/cart/components/cart_list_tile_widget.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/result_details_item.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = CartController(OrderRepositoryAPI());
  final userController = Modular.get<UserStore>();

  bool isLoggedIn = true;
  
  @override
  void initState() {
    super.initState();
    controller.searchCart();

    autorun((_) {
      setState(() => isLoggedIn = userController.user != null);
    });
  }

  Widget _shippingChooser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ResultDetailsItem(
                label: 'Frete',
                value: 'R\$ 5,99 (PAC)'
              )
            ),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              constraints: BoxConstraints(maxHeight: 35.0),
              onPressed: (){},
            )
          ],
        ),
        Container(
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              RadioListTile(
                title: Text('PAC (R\$ 5,99)'),
                value: null, 
                groupValue: null,
                dense: true,
                onChanged: (value){}
              ),
              RadioListTile(
                title: Text('Sedex (R\$ 13,99)'), 
                value: null, 
                groupValue: null, 
                dense: true,
                onChanged: (value){}
              ),
            ]
          )
        )
      ]
    );
  }

  Widget _unloggedScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Faça login para acessar seu carrinho de compras',
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
        Container(
          margin: const EdgeInsets.only(top: 32.0),
          height: 200.0,
          child: SvgPicture.asset('assets/img/account.svg')
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Carrinho'
      ),
      floatingActionButton: isLoggedIn
        ? FloatingActionButton(
            child: Icon(Icons.check, size: 28.0, color: Colors.white),
            onPressed: () => Modular.to.pushNamed('/checkout/methods'),
          )
        : null,
      body: !isLoggedIn
        ? _unloggedScreen()
        : StreamBuilder<Order>(
        stream: controller.cart,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if(!snapshot.hasData) {
            return Center(child: Text('Nenhum produto no carrinho'));
          }

          final cart = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              _shippingChooser(),
              ResultDetailsItem(
                label: 'Total',
                value: 'R\$ ${cart.total.toStringAsFixed(2)}'
              ),
              Container(
                margin: const EdgeInsets.only(top: 24.0),
                child: Text('Produtos')
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  cart.products.length,
                  (index) {
                    final product = cart.products[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Dismissible(
                        key: ValueKey(product.product.id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment(-0.8, 0), 
                          child: Icon(Icons.delete, size: 32.0, color: Colors.white54), 
                        ),
                        direction: DismissDirection.startToEnd,
                        confirmDismiss: (direction) {
                          return showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmar Remoção'),
                                content: Text('Deseja realmente remover "${product.product.name}" do carrinho?'),
                                actions: [
                                  FlatButton(
                                    child: Text('Sim'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    }
                                  ),
                                  FlatButton(
                                    child: Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    }
                                  ),
                                ]
                              );
                            }
                          );
                        },
                        onDismissed: (direction) {
                          controller.deleteCartProduct(product);
                        },
                        child: CartListTileWidget(
                          productImage: product.product.images[0],
                          productTitle: product.product.name,
                          productPrice: product.product.price,
                          productsCount: product.quantity,
                          onProductsCountChange: (value) {
                            int newQuantity = product.quantity + value;
                            if(newQuantity < 0) {
                              newQuantity = 0;
                            }
                            controller.updateCartProduct(product.copyWith(quantity: newQuantity));
                          },
                        ),
                      ),
                    );
                  }
                )
              )
            ],
          );
        },
      )
    );
  }
}