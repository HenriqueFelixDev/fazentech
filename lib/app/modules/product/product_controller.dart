import 'dart:async';

import 'package:fazentech/app/shared/models/product/category.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/models/product/product_filter.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class ProductController implements Disposable{
  final ProductFilter filter = ProductFilter();
  IProductRepository productRepository;
  ICategoryRepository categoryRepository;
  ProductController(this.productRepository, this.categoryRepository) {
    searchCategories();
  }

  final selectedCategories = List<Category>();
  final searchController = TextEditingController();
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  final StreamController<List<Product>> _productsController = BehaviorSubject();
  final StreamController<List<Category>> _categoriesController = BehaviorSubject();

  Stream<List<Product>> get products => _productsController.stream;
  Stream<List<Category>> get categories => _categoriesController.stream;

  void addSelectedCategory(Category category) {
    selectedCategories.add(category);
    print(selectedCategories.length);
  }

  void removeSelectedCategory(Category category) {
    selectedCategories.remove(category);
  }

  Future<void> searchProducts() async{
    filter.search = searchController.text.trim();
    filter.categories = selectedCategories;
    final minPriceText = minPriceController.text.replaceAll(',', '.').trim();
    String maxPriceText = maxPriceController.text.replaceAll(',', '.').trim();
    maxPriceText = maxPriceText.isEmpty
      ? null
      : maxPriceText;

    filter.minPrice = double.tryParse(minPriceText ?? '');
    filter.maxPrice = double.tryParse(maxPriceText ?? '');

    final products = await productRepository.getProducts(filter);
    _productsController.sink.add(products);
  }

  Future<void> searchCategories() async{
    final categories = await categoryRepository.getAllCategories();
    _categoriesController.sink.add(categories);
  }

  @override
  void dispose() {
    _productsController.close();
    _categoriesController.close();
  }
}