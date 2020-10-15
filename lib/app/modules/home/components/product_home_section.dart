import 'package:fazentech/app/shared/components/product_card.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class ProductHomeSection extends StatelessWidget {
  final String title;
  final Function onSeeAllPressed;
  ProductHomeSection({
    Key key,
    this.title,
    this.onSeeAllPressed
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
              Text('Mais Comprados', style: textTheme.headline3,),
              FlatButton(
                padding: EdgeInsets.zero,
                child: Text('Ver Mais >>', style: textTheme.headline3.copyWith(color: ColorsSet.accentColor)),
                onPressed: (){},
              )
            ],
          ),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return ProductCard(
                  product: Product(
                    id: 'K265JSDFS58165S',
                    name: 'Abacaxi Pérola Unidade',
                    images: ['https://picsum.photos/id/$index/300/200'],
                    description: 'Descrição do produto',
                    price: 5.99
                  ),
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