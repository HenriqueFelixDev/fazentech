import 'package:fazentech/app/modules/product/submodules/categories/components/category_tile_widget.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Categorias'
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0
        ),
        children: List.generate(10, 
            (index) => 
              CategoryTileWidget(
                category: 'Frutas',
                icon: Icons.home,
                onPressed: (){},
              )
        )
      )
    );
  }
}