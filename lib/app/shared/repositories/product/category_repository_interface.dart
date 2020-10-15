import 'package:fazentech/app/shared/models/product/category.dart';

abstract class ICategoryRepository {
  Future<List<Category>> getAllCategories();
  Future<Category> getCategoryById(String id);
}