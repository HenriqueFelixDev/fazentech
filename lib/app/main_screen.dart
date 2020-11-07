import 'package:fazentech/app/shared/models/product/product_filter.dart';
import 'package:flutter/material.dart';

import 'modules/cart/cart_screen.dart';
import 'modules/home/home_screen.dart';
import 'modules/product/submodules/categories/categories_screen.dart';
import 'modules/product/submodules/products/products_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();

  int _page = 0;
  ProductFilter productFilter = ProductFilter();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
        setState((){
          _page = _pageController.page.round();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreen(),
          ProductsScreen(productFilter: productFilter),
          CategoriesScreen(
            onCategoryChoosed: (categoryId) {
              productFilter.categories = [categoryId];
              _moveToPage(1);
            },
          ),
          CartScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: _moveToPage,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Categorias'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho'
          )
        ]
      )
    );
  }

  _moveToPage(int page) {
    _pageController?.animateToPage(
      page, 
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut
    );
  }
}