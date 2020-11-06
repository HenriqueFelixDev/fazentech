import 'package:fazentech/app/modules/cart/cart_controller.dart';
import 'package:fazentech/app/shared/components/image_loading_placeholder_widget.dart';
import 'package:fazentech/app/shared/controllers/user_store.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:octo_image/octo_image.dart';

class ProductCard extends StatelessWidget {
  final userController = Modular.get<UserStore>();

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
      Observer(
        builder: (context) {
          final isLoggedIn = userController.user != null;

          return IconButton(
            icon: Icon(
              FontAwesomeIcons.cartPlus, 
              color: ColorsSet.accentColor,
              size: 22.0
            ),
            onPressed: () => onAddCartPressed(context, isLoggedIn: isLoggedIn)
          );
        }
      )
    ];
  }

  Widget getCartQuantityAlert(BuildContext context) {
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

  Widget getUserUnloggedAlert(BuildContext context) {
    return AlertDialog(
      title: Text('Você não está logado'),
      content: Text('Você deve estar logado para adicionar um produto ao carrinho'),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop()
        )
      ]
    );
  }

  void onAddCartPressed(BuildContext context, {bool isLoggedIn = true}) async{
    final quantity = await showDialog(
      context: context,
      builder: (context) {
        return isLoggedIn
          ? getCartQuantityAlert(context)
          : getUserUnloggedAlert(context);
      }
    );

    if(!isLoggedIn) return;

    if(quantity != null && quantity > 0) {
      Modular.get<CartController>().insertProductOnCart(product, quantity);
      onCartPressed?.call();
    }
  }

  Widget _getProductTitle(BuildContext context) {
    return Text(
      product.name, 
      maxLines: 2, 
      overflow: TextOverflow.ellipsis, 
      style: Theme.of(context).textTheme.headline3
    );
  }

  List<Widget> _cardContent(BuildContext context, {bool isHorizontal = false}) {
    final productInfoMargin = isHorizontal
      ? EdgeInsets.zero
      : EdgeInsets.only(top: 16.0);
    
    final productInfoPadding = isHorizontal
      ? EdgeInsets.only(left: 16.0)
      : EdgeInsets.symmetric(horizontal: 16.0);

    final imageAspectRatio = isHorizontal
      ? 1.0
      : 16/9;

    return [
      AspectRatio(
          aspectRatio: imageAspectRatio,
          child: OctoImage(
            image: NetworkImage(product.images[0]), 
            fit: BoxFit.cover,
            placeholderBuilder: (_) => ImageLoadingPlaceholderWidget()
          ),
      ),
      Expanded(
        child: Container(
          margin: productInfoMargin,
          padding: productInfoPadding,
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
        ),
      )
    ];
  }

  Widget _verticalCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _cardContent(context),
    );
  }
  
  Widget _horizontalCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _cardContent(context, isHorizontal: true)
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
      height: 110.0,
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