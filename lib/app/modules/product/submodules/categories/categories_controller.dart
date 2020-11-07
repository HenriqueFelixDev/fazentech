import 'dart:async';

import 'package:fazentech/app/shared/models/product/category.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_api.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_interface.dart';

class CategoriesController {
  ICategoryRepository _categoryRepository;
  StreamController<List<Category>> _categoriesController;

  CategoriesController(){
    _categoryRepository = CategoryRepositoryAPI();
    _categoriesController = StreamController();
  }

  Stream get categories => _categoriesController.stream;

  Future<void> searchCategories() async{
    try {
      final categories = await _categoryRepository.getAllCategories();
      _categoriesController.sink.add(categories);
    } catch(e) {
      print('ERROR: $e');
    }
  }
}