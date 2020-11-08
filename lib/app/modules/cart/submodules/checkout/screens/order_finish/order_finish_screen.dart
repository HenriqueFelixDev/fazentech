import 'package:fazentech/app/modules/cart/cart_controller.dart';
import 'package:fazentech/app/modules/order/components/product_order_list_tile.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/custom_card_widget.dart';
import 'package:fazentech/app/shared/components/result_details_item.dart';
import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderFinishScreen extends StatefulWidget {
  @override
  _OrderFinishScreenState createState() => _OrderFinishScreenState();
}

class _OrderFinishScreenState extends State<OrderFinishScreen> {
  final controller = Modular.get<CartController>();

  Widget _billingDetails(BuildContext context, Map<String, String> billingInfoItems) {
    return CustomCardWidget(
      child: Column(
        children: billingInfoItems.keys.map(
          (billingInfoLabel) =>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(billingInfoLabel)
                ),
                Text(billingInfoItems[billingInfoLabel], style: Theme.of(context).textTheme.headline4)
              ],
            )
        ).toList()
      )
    );
  }

  _confirmOrder() async{
    await controller.confirmCartOrder();
    Modular.to.pushNamed('/cart/checkout/success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Finalizar Pedido'
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, color: Colors.white, size: 28.0),
        onPressed: _confirmOrder
      ),
      body: StreamBuilder<Order>(
        stream: controller.cart,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.none ||snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final cart = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              ResultDetailsItem(label: 'Frete', value: '${cart.shipping}'),
              ResultDetailsItem(label: 'Total', value: 'R\$ ${cart.total}'),
              Container(
                margin: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text('Informações de cobrança')
              ),
              _billingDetails(context, {
                'Forma de Pagamento': '${cart.paymentMethod}',
                'Número de Parcelas': '${cart.installmentCount} (R\$ ${(cart.total / cart.installmentCount).toStringAsFixed(2)})'
              }),

              Container(
                margin: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text('Produtos')
              ),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: List.generate(
                    cart.products.length,
                    (index) {
                      final product = cart.products[index];

                      return ProductOrderListTile(
                        productImage: product.product.images[0],
                        productPrice: product.price,
                        productTitle: product.product.name,
                        productsCount: product.quantity,
                        totalPrice: product.price * product.quantity,
                      );
                    }
                  )
                )
              )
            ],
          );
        }
      )
    );
  }
}