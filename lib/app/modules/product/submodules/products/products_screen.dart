import 'package:fazentech/app/modules/product/submodules/products/products_controller.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/product_card.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/models/product/product_filter.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_api.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_api.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final controller = ProductsController(ProductRepositoryAPI(CategoryRepositoryAPI()));
  ProductFilter filter = ProductFilter();

  final searchController = TextEditingController();
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  Widget _searchField() {
    return TextFormField(
      controller: searchController,
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
          onPressed: () {
            filter.search = searchController.text;
            controller.filter.add(filter);
            FocusScope.of(context).unfocus();
          }
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
      body: StreamBuilder<List<Product>>(
        stream: controller.products,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: products.length + 1,
            itemBuilder: (_, index) {
              if(index == 0) {
                return Container(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    '${products.length} produto(s) encontrado(s)', 
                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[500], fontSize: 16.0)
                  )
                );
              }

              final product = products[index - 1];

              return ProductCard(
                product: product, 
                onCartPressed: (){},
                onTap: (){},
                axis: Axis.horizontal,
              );
            },
          );
        }
      )
    );
  }

  Widget _priceFormField(String hintText, TextEditingController controller) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
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
              onPressed: () {
                filter.minPrice = double.tryParse(minPriceController.text);
                filter.maxPrice = double.tryParse(maxPriceController.text);
                controller.filter.add(filter);
                Navigator.of(context).pop();
              },
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
                      child: _priceFormField('Mín', minPriceController)
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: _priceFormField('Max', maxPriceController)
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