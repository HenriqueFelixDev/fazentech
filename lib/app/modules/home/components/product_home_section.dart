import 'package:fazentech/app/shared/components/product_card.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class ProductHomeSection extends StatelessWidget {
  final String title;
  final List<Product> products;
  final Function onSeeAllPressed;
  ProductHomeSection({
    Key key,
    @required this.title,
    @required this.products,
    @required this.onSeeAllPressed
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textTheme.headline3,)
            ],
          ),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];

                return ProductCard(
                  product: product,
                  onCartPressed: (){},
                  onTap: (){},
                );
              },
            )
          )
        ],
      ),
    );
  }
}