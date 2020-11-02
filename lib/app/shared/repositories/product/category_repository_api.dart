import 'package:http/http.dart' as http;
import 'dart:convert';

import 'category_repository_interface.dart';
import '../../models/product/category.dart';

class CategoryRepositoryAPI implements ICategoryRepository {
  static const BASE_URL = 'http://10.0.0.106';
  Future<List<Category>> getAllCategories() async{
    final response = await http.get('$BASE_URL/categories');

    if(response.statusCode >= 200 && response.statusCode < 300) {
      final categoriesMap = json.decode(response.body);
      
      return categoriesMap.map<Category>(
        (categoryMap) => Category(
          id: categoryMap['id'].toString(),
          name: categoryMap['name'],
          icon: categoryMap['icon'],
          description: categoryMap['description']
        )
      ).toList();
    }
    return null;
  }

  Future<Category> getCategoryById(String id) async {
    return null;
  }
}