import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onCartPressed;
  final Function onTap;
  final Axis axis;
  ProductCard({
    Key key,
    @required this.product,
    @required this.onCartPressed,
    @required this.onTap,
    this.axis = Axis.vertical
  }) : super(key: key);
  
  List<Widget> _getProductInfo(BuildContext context) {
    final theme = Theme.of(context);
    return [
      Text(
        'R\$ ${product.price.toStringAsFixed(2)}', 
        style: theme.textTheme.headline2.copyWith(
          color: theme.primaryColor, 
          fontWeight: FontWeight.bold
        )
      ),
      IconButton(
        icon: Icon(
          Icons.add_shopping_cart, 
          color: ColorsSet.accentColor,
          size: 26.0
        ),
        onPressed: onCartPressed,
      )
    ];
  }

  Widget _getProductTitle(BuildContext context) {
    return Text(product.name, style: Theme.of(context).textTheme.headline3);
  }

  Widget _verticalCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(product.images[0], fit: BoxFit.cover),
        _getProductTitle(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _getProductInfo(context),
        )
      ],
    );
  }
  
  Widget _horizontalCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(product.images[0], fit: BoxFit.cover),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getProductTitle(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _getProductInfo(context),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    final child = axis == Axis.vertical
      ? _verticalCard(context)
      : _horizontalCard(context);

    return Container(
      width: 200.0,
      height: 100.0,
      margin: const EdgeInsets.only(right: 4.0),
      child: InkWell(
        onTap: () => Modular.to.pushNamed('/products/${product.id}', arguments: product),
        child: Card(
          child: child
        ),
      ),
    );
  }
}