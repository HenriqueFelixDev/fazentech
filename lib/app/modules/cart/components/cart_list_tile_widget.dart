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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: GradientCardWidget(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              child: Image.network(productImage, fit: BoxFit.cover)
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 4.0),
                      child: Text(productTitle)
                    ),
                    Text('R\$ ${productPrice.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headline3),
                  ],
                ),
              ),
            ),
            _productQuantityWidget(context)
          ]
        )
      ),
    );
  }

  Widget _productQuantityWidget(BuildContext context) {
    final iconButtonsColor = Theme.of(context).accentColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.add, color: iconButtonsColor),
          onPressed: () => onProductsCountChange(1),
        ),
        Container(
          width: 30.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[400])
          ),
          child: Center(
            child: Text('$productsCount')
          )
        ),
        IconButton(
          icon: Icon(Icons.remove, color: iconButtonsColor),
          onPressed: () => onProductsCountChange(-1),
        )
      ],
    );
  }
}