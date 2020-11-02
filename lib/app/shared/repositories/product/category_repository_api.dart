import 'package:fazentech/app/shared/services/http/http_client_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'category_repository_interface.dart';
import '../../models/product/category.dart';

class CategoryRepositoryAPI implements ICategoryRepository {
  final httpClient = Modular.get<IHttpClient>();
  
  Future<List<Category>> getAllCategories() async{
    final categoriesMap = await httpClient.get('/categories');

    if(categoriesMap != null) {
      return categoriesMap.map<Category>(
        (categoryMap) => Category(
          id: categoryMap['id'].toString(),
          name: categoryMap['name'],
          icon: categoryMap['icon'],
          description: categoryMap['description']
        )
      ).toList();
    }

    return [];
  }

  Future<Category> getCategoryById(String id) async {
    return null;
  }
}