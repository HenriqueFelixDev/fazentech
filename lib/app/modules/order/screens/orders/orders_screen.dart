import 'package:fazentech/app/modules/order/screens/orders/components/order_card_widget.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/gradient_card_widget.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Pedidos',
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          OrderCardWidget( 
              orderId: '1', 
              orderDate: DateTime.now(), 
              orderPrice: 21.99, 
              orderStatus: 'Preparando para envio', 
              onDetailsPressed: () => Modular.to.pushNamed('/orders/1')
          )
        ],
      )
    );
  }
}