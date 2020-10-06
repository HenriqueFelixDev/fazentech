import 'package:flutter/material.dart';

class ProductOrderListTile extends StatelessWidget {
  final String productImage;
  final String productTitle;
  final double productPrice;
  final int productsCount;
  final double totalPrice;

  ProductOrderListTile({
    Key key,
    @required this.productImage,
    @required this.productPrice,
    @required this.productTitle,
    @required this.productsCount,
    @required this.totalPrice
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;

    return ListTile(
      leading: Image.network(productImage, fit: BoxFit.cover,),
      title: Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        child: Text(productTitle)
      ),
      subtitle: RichText(
        text: TextSpan(
          text: '${productsCount}x ',
          style: textTheme.headline6,
          children: [
            TextSpan(
              text: 'R\$ $totalPrice',
              style: textTheme.headline5.copyWith(fontWeight: FontWeight.bold, color: primaryColor)
            )
          ]
        )
      ),
      trailing: Text('R\$ $totalPrice', style: textTheme.bodyText1.copyWith(color: primaryColor)),
    );
  }
}