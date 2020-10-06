import 'package:flutter/material.dart';
import 'package:fazentech/app/modules/cart/components/cart_list_tile_widget.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/radio_button_widget.dart';
import 'package:fazentech/app/shared/components/result_details_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

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
            alignment: WrapAlignment.spaceEvenly,
            children: [
              RadioButtonWidget(
                label: 'PAC (R\$ 5,99)', 
                value: null, 
                groupValue: null, 
                onChanged: (value){}
              ),
              RadioButtonWidget(
                label: 'Sedex (R\$ 13,99)', 
                value: null, 
                groupValue: null, 
                onChanged: (value){}
              ),
            ]
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: Text('Carrinho', style: TextStyle(color: Colors.black))
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 28.0, color: Colors.white),
        onPressed: (){},
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _shippingChooser(),
          ResultDetailsItem(
            label: 'Total',
            value: 'R\$ 21,96'
          ),
          Container(
            margin: const EdgeInsets.only(top: 24.0),
            child: Text('Produtos')
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.filled(
              5,
              CartListTileWidget(
                productImage: 'https://cdn.awsli.com.br/600x700/305/305913/produto/10189815/abacaxi-1441a8b7.jpg',
                productTitle: 'Abacaxi Pérola Unidade',
                productPrice: 5.49,
                productsCount: 1,
                onProductsCountChange: (value) {},
              )
            )
          )
        ],
      )
    );
  }
}