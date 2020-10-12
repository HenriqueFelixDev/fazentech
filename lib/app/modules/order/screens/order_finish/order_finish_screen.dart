import 'package:fazentech/app/modules/order/components/product_order_list_tile.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/custom_card_widget.dart';
import 'package:fazentech/app/shared/components/result_details_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderFinishScreen extends StatefulWidget {
  @override
  _OrderFinishScreenState createState() => _OrderFinishScreenState();
}

class _OrderFinishScreenState extends State<OrderFinishScreen> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Finalizar Pedido'
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, color: Colors.white, size: 28.0),
        onPressed: () => Modular.to.pushNamed('/checkout/success')
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          ResultDetailsItem(label: 'Frete', value: 'R\$ 5,99 (PAC)'),
          ResultDetailsItem(label: 'Total', value: 'R\$ 21,99'),
          Container(
            margin: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text('Informações de cobrança')
          ),
          _billingDetails(context, {
            'Forma de Pagamento': 'Cartão de Crédito',
            'Número de Parcelas': '1 (R\$ 21,96)'
          }),

          Container(
            margin: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text('Produtos')
          ),
          CustomCardWidget(
            padding: EdgeInsets.zero,
            child: Column(
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
            )
          )
        ],
      )
    );
  }
}