import 'package:fazentech/app/modules/cart/cart_controller.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  final _quantityController = TextEditingController(text: '1');
  
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
          FontAwesomeIcons.cartPlus, 
          color: ColorsSet.accentColor,
          size: 22.0
        ),
        onPressed: () async{
          final quantity = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Quantidade de Produtos'),
                content: Row(
                  children: [
                    Text('Quantidade'),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: _quantityController,
                      ),
                    )
                  ]
                ),
                actions: [
                  FlatButton(
                    child: Text('Confirmar'),
                    onPressed: () => Navigator.of(context).pop(int.tryParse(_quantityController.text))
                  ),
                  FlatButton(
                    child: Text('Cancelar'),
                    onPressed: () => Navigator.of(context).pop(null)
                  ),
                ]
              );
            }
          );
          if(quantity != null && quantity > 0) {
            Modular.get<CartController>().insertProductOnCart(product, quantity);
            onCartPressed?.call();
          }
        },
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getProductTitle(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _getProductInfo(context),
              )
            ]
          ),
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
        onTap: () => Modular.to.pushNamed('/produtos/${product.id}', arguments: product),
        child: Card(
          child: child
        ),
      ),
    );
  }
}