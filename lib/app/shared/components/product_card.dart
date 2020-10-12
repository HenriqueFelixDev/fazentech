import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final Function onCartPressed;
  final Function onTap;
  final Axis axis;
  ProductCard({
    Key key,
    @required this.image,
    @required this.title,
    @required this.price,
    @required this.onCartPressed,
    @required this.onTap,
    this.axis = Axis.vertical
  }) : super(key: key);
  
  List<Widget> _getProductInfo(BuildContext context) {
    final theme = Theme.of(context);
    return [
      Text(
        'R\$ ${price.toStringAsFixed(2)}', 
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
    return Text(title, style: Theme.of(context).textTheme.headline3);
  }

  Widget _verticalCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(image, fit: BoxFit.cover),
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
            child: Image.network(image, fit: BoxFit.cover),
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
        onTap: () => Modular.to.pushNamed('/produtos/1'),
        child: Card(
          child: child
        ),
      ),
    );
  }
}