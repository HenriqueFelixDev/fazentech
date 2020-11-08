import 'package:fazentech/app/modules/order/components/product_order_list_tile.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/models/order/order_product.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  Order order;
  OrderDetailsScreen(this.order);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final titleTheme = textTheme.headline4.copyWith(color: Colors.grey);
    bool productsTileOpen = false;

    final order = widget.order;

    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Pedido #${order.id}'
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('Forma de Pagamento', textAlign: TextAlign.center, style: titleTheme),
                    SizedBox(height: 8.0),
                    Text('${order.paymentMethod}', textAlign: TextAlign.center, style: textTheme.bodyText1.copyWith(height: 1.0))
                  ]
                ),
              ),
              Expanded(
                child: Column(
                children: [
                  Text('Parcelas', style: titleTheme),
                  SizedBox(height: 8.0),
                  Text('${order.installmentCount}', style: textTheme.bodyText1.copyWith(height: 1.0))
                ]
                )
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle),
                    Text('${order.status}')
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 32.0),
          Text('Produtos', style: textTheme.headline6),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
            ),
            child: ExpansionTile(
              onExpansionChanged: (isExpanded) {
                setState(() => productsTileOpen = isExpanded);
              },
              title: Stack(
                children: [
                  Positioned(
                    child: Text('Total', style: textTheme.headline4),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left: productsTileOpen ? 0.0 : 60.0,
                    child: Text('R\$ ${order.total.toStringAsFixed(2)}', style: textTheme.headline3),
                  )
                ],
              ),
              children: List.generate(
                order.products.length,
                (index) {
                  final orderProduct = order.products[index];

                  return ProductOrderListTile(
                    productImage: orderProduct.product.images.elementAt(0),
                    productPrice: orderProduct.price,
                    productTitle: orderProduct.product.name,
                    productsCount: orderProduct.quantity,
                    totalPrice: orderProduct.price * orderProduct.quantity,
                  );
                }
              )
            ),
          )
        ],
      )
    );
  }
}