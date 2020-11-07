import 'package:fazentech/app/modules/order/order_controller.dart';
import 'package:fazentech/app/modules/order/screens/orders/components/order_card_widget.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/repositories/order/order_repository_api.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final controller = OrderController(OrderRepositoryAPI());

  @override
  void initState() {
    super.initState();
    controller.searchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Pedidos',
      ),
      body: StreamBuilder<List<Order>>(
        stream: controller.orders,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data;

          return ListView.builder(
            padding: const EdgeInsets.all(24.0),
            itemCount: orders.length,
            itemBuilder: (context, index) {

              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: OrderCardWidget(
                  order: orders[index],
                  onDetailsPressed: () {
                    Navigator.of(context)
                      .pushNamed(
                        '/orders/${orders[index].id}', 
                        arguments: orders[index]
                      );
                  }
                )
              );
            }
          );
        }
      )
    );
  }
}