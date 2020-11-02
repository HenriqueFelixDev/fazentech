import 'package:fazentech/app/shared/components/carousel/carousel_widget.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen({
    Key key,
    @required this.product
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final product = widget.product;

    return Scaffold(
      appBar: CustomAppBarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.cartPlus, color: Colors.white),
        onPressed: (){},
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 8.0),
          children: [
            CarouselWidget(images: product.images),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(product.name, style: textTheme.headline2),
                  Text('R\$ ${product.price.toStringAsFixed(2)}', style: textTheme.headline1.copyWith(color: Theme.of(context).primaryColor)),
                  SizedBox(height: 16.0),
                  Text('Descrição', style: textTheme.headline4),
                  Text(product.description, style: textTheme.bodyText1)
                ]
              ),
            )
          ],
        ),
      )
    );
  }
}