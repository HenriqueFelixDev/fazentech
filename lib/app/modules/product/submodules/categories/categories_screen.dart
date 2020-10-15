import 'package:fazentech/app/modules/product/submodules/categories/categories_controller.dart';
import 'package:fazentech/app/modules/product/submodules/categories/components/category_tile_widget.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/models/product/category.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_firebase.dart';
import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final controller = CategoriesController();

  @override
  void initState() {
    super.initState();
    controller.searchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Categorias'
      ),
      body: StreamBuilder<List<Category>>(
        stream: controller.categories,
        initialData: [],
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.none || 
            snapshot.connectionState == ConnectionState.waiting
          ) {
              return Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if(!snapshot.hasData) {
            return Center(child: Text('Nenhuma categoria foi encontrada!'));
          }

          final categories = snapshot.data;

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0
            ),
            itemCount: categories.length,
            itemBuilder: (_, index) {
              final category = categories[index];
              return CategoryTileWidget(
                category: category.name,
                icon: category.icon,
                onPressed: (){},
              );
            }
          );
        },
      )
    );
  }
}