import 'package:fazentech/app/modules/product/product_controller.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/product_card.dart';
import 'package:fazentech/app/shared/models/product/category.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final productController = Modular.get<ProductController>();

  List categories = List<Category>();
  List selectedCategories = List<Category>();

  @override
  void initState() {
    super.initState();
    productController.searchProducts();
    productController.categories.listen((categories) {
      setState(() => this.categories = categories);
    });
  }

  Widget _searchField() {
    return TextFormField(
      controller: productController.searchController,
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
      body: StreamBuilder<List<Product>>(
        stream: productController.products,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting
          ) {
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
              return ProductCard(
                product: products[index - 1],
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
      controller: controller,
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

  Widget _categoryShip(BuildContext context, Category category, Function(bool) onSelect) {
    return FilterChip(
      selected: productController.selectedCategories.contains(category),
      selectedColor: Theme.of(context).primaryColor.withAlpha(150),
      label: Text(category.name),
      onSelected: onSelect,
    );
  }

  _showFilterAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              actions: [
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () => Modular.to.pop()
                ),
                FlatButton(
                  child: Text('Aplicar'),
                  onPressed: () {
                    productController.searchProducts();
                    Modular.to.pop();
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
                      children: categories.map(
                        (category) => _categoryShip(context, category,
                        (selected){
                          if(selected) {
                            productController.addSelectedCategory(category);
                            setState((){});
                            return;
                          }
                          setState(() => productController.removeSelectedCategory(category));
                        })
                      ).toList()
                    ),
                    SizedBox(height: 16.0),
                    Text('Preço'),
                    Row(
                      children: [
                        Expanded(
                          child: _priceFormField('Mín', productController.minPriceController)
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: _priceFormField('Max', productController.maxPriceController)
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
    );
  }
}