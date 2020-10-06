import 'package:fazentech/app/modules/order/components/product_order_list_tile.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final titleTheme = textTheme.headline6.copyWith(color: Colors.grey);
    bool productsTileOpen = false;

    return Scaffold(
      appBar: CustomAppBarWidget(
        title: Text('Pedido #16512', style: TextStyle(color: Colors.black))
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
                    Text('Cartão de Crédito')
                  ]
                ),
              ),
              Expanded(
                child: Column(
                children: [
                  Text('Parcelas', style: titleTheme),
                  SizedBox(height: 8.0),
                  Text('3')
                ]
                )
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle),
                    Text('Enviado')
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
                    child: Text('Total', style: textTheme.headline6.copyWith(color: Colors.grey)),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left: productsTileOpen ? 0.0 : 60.0,
                    child: Text('R\$ 21.99', style: textTheme.headline5.copyWith(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              children: List.filled(
                10,
                ProductOrderListTile(
                  productImage: 'https://cdn.awsli.com.br/600x700/305/305913/produto/10189815/abacaxi-1441a8b7.jpg',
                  productPrice: 5.99,
                  productTitle: 'Abacaxi Pérola Unidade',
                  productsCount: 1,
                  totalPrice: 5.99,
                )
              )
            ),
          )
        ],
      )
    );
  }
}