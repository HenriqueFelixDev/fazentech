import 'package:fazentech/app/shared/components/gradient_card_widget.dart';
import 'package:flutter/material.dart';

class CartListTileWidget extends StatelessWidget {
  final String productImage;
  final String productTitle;
  final double productPrice;
  final int productsCount;
  final Function(int value) onProductsCountChange;
  CartListTileWidget({
    Key key,
    @required this.productImage,
    @required this.productTitle,
    @required this.productPrice,
    @required this.productsCount,
    @required this.onProductsCountChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconButtonsColor = Theme.of(context).accentColor;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: GradientCardWidget(
        child: ListTile(
          leading: Image.network(productImage, fit: BoxFit.cover),
          title: Container(
            margin: const EdgeInsets.only(bottom: 4.0),
            child: Text(productTitle)
          ),
          subtitle: Text('R\$ ${productPrice.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.add, color: iconButtonsColor),
                onPressed: () => onProductsCountChange(1),
              ),
              Container(
                width: 30.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  initialValue: productsCount.toString(),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    filled:  true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.remove, color: iconButtonsColor),
                onPressed: () => onProductsCountChange(-1),
              )
            ],
          ),
        )
      ),
    );
  }
}