import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final String image;
  final String title;
  final double price;
  final String description;

  ProductScreen({
    Key key,
    @required this.image,
    @required this.title,
    @required this.price,
    @required this.description
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart, color: Colors.white),
        onPressed: (){},
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          padding: const EdgeInsets.only(bottom: 8.0),
          children: [
            AspectRatio(
              aspectRatio: 1.3,
              child: Image.network(widget.image, fit: BoxFit.cover)
            ),
            SizedBox(height: 8.0),
            Text(widget.title, style: textTheme.headline5),
            Text('R\$ ${widget.price.toStringAsFixed(2)}', style: textTheme.headline4.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
            SizedBox(height: 16.0),
            Text('Descrição', style: TextStyle(color: Colors.grey[500], fontSize: 16.0)),
            Text(widget.description, style: TextStyle(fontSize: 18.0)),
          ],
        ),
      )
    );
  }
}