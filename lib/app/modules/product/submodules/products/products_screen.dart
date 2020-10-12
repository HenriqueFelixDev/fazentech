import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/product_card.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  Widget _searchField() {
    return TextFormField(
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              alignLabelWithHint: true,
              hintText: 'Pesquisar',
              hintStyle: TextStyle(color: Colors.grey[400]),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search, 
                  color: ColorsSet.accentColor
                ),
                onPressed: (){}
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))
            ),
          );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Container(
          height: 40.0,
          child: _searchField(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_rounded),
            onPressed: () => _showFilterAlert(context)
          )
        ]
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (_, index) {
          if(index == 0) {
            return Container(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                '0 produto(s) encontrado(s)', 
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[500], fontSize: 16.0)
              )
            );
          }
          return ProductCard(
            image: 'https://picsum.photos/id/$index/300/200', 
            title: 'Abacaxi Pérola Unidade', 
            price: 5.49, 
            onCartPressed: (){},
            onTap: (){},
            axis: Axis.horizontal,
          );
        },
      )
    );
  }

  Widget _priceFormField(String hintText) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        prefix: Container(
          margin: const EdgeInsets.only(right: 8.0),
          child: Text('R\$')
        ),
        border: OutlineInputBorder()
      ),
    );
  }

  _showFilterAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Modular.to.pop()
            ),
            FlatButton(
              child: Text('Aplicar'),
              onPressed: (){},
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Categorias'),
                Wrap(
                  spacing: 8.0,
                  children: [
                    FilterChip(
                      selected: true,
                      selectedColor: Theme.of(context).primaryColor.withAlpha(150),
                      label: Text('Verduras'),
                      onSelected: (selected){},
                    ),
                    FilterChip(
                      label: Text('Verduras'),
                      onSelected: (selected){},
                    ),
                    FilterChip(
                      label: Text('Verduras'),
                      onSelected: (selected){},
                    ),
                    FilterChip(
                      label: Text('Verduras'),
                      onSelected: (selected){},
                    ),
                    FilterChip(
                      label: Text('Verduras'),
                      onSelected: (selected){},
                    ),
                    FilterChip(
                      label: Text('Verduras'),
                      onSelected: (selected){},
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text('Preço'),
                Row(
                  children: [
                    Expanded(
                      child: _priceFormField('Mín')
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: _priceFormField('Max')
                    ),
                  ],
                )
              ],
            )
          )
        );
      }
    );
  }
}