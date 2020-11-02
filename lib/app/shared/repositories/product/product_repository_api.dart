import 'package:http/http.dart' as http;
import 'dart:convert';

import 'category_repository_interface.dart';
import '../../models/product/category.dart';
import '../../models/order/order_product.dart';
import '../../models/product/product.dart';
import '../../models/product/product_filter.dart';

import 'product_repository_interface.dart';

class ProductRepositoryAPI implements IProductRepository {
  ICategoryRepository categoryRepository;
  ProductRepositoryAPI(this.categoryRepository);
  static const BASE_URL = 'http://10.0.0.106';

  String _buildProductsQuery(ProductFilter filter) {
    if(filter == null) {
      return '';
    }

    String uri = '';
    if(filter.search != null && filter.search.isNotEmpty) {
      uri += 'search=${filter.search}&';
    }

    if(filter.categories != null && filter.categories.isNotEmpty) {
      final categoriesIds = filter.categories.map(
        (category) => category.id
      );
      uri += 'categories=$categoriesIds&';
    }

    if(filter.minPrice != null && filter.minPrice > 0) {
      uri += 'minPrice=${filter.minPrice}&';
    }

    if(filter.maxPrice != null && filter.maxPrice > 0) {
      uri += 'maxPrice=${filter.maxPrice}&';
    }

    if(uri.isNotEmpty) {
      uri = '?$uri';
      uri = uri.substring(0, uri.length - 1);
    }

    return uri;
  }

  Future<List<Product>> getProducts(ProductFilter filter) async{
    final query = _buildProductsQuery(filter);
    final response = await http.get('$BASE_URL/products$query');

    if(response.statusCode >= 200 && response.statusCode < 300) {
      final productsMap = json.decode(response.body);

      return productsMap.map<Product>(
        (productMap) => Product(
          id: productMap['id'].toString(),
          name: productMap['name'],
          description: productMap['description'],
          category: Category(id: productMap['id'].toString()),
          price: double.tryParse(productMap['price'] ?? '0'),
          images: List.from(productMap['images'] ?? [])
        )
      ).toList();
    }
    return [];
  }

  
  Future<List<Product>> getTopProducts() async{
    final response = await http.get('$BASE_URL/products/top');

    if(response.statusCode >= 200 && response.statusCode < 300) {
      final productsMap = json.decode(response.body);

      return productsMap.map<Product>(
        (productMap) => Product(
          id: productMap['id'].toString(),
          name: productMap['name'],
          description: productMap['description'],
          category: Category(id: productMap['id'].toString()),
          price: double.tryParse(productMap['price'] ?? '0'),
          images: List.from(productMap['images'] ?? [])
        )
      ).toList();
    }
    return [];
  }

  Future<List<Product>> getRecentlyAddedProducts() async{
    final response = await http.get('$BASE_URL/products/recently-added');

    if(response.statusCode >= 200 && response.statusCode < 300) {
      final productsMap = json.decode(response.body);
      return productsMap.map<Product>(
        (productMap) => Product(
          id: productMap['id'].toString(),
          name: productMap['name'],
          description: productMap['description'],
          category: Category(id: productMap['id']?.toString()),
          price: double.tryParse(productMap['price'] ?? '0'),
          images: List.from(productMap['images'] ?? [])
        )
      ).toList();
    }
    return [];
  }
  
  Future<Product> getProductById(String id) {

  }
  
  Future<List<OrderProduct>> getOrderProducts(String orderId) {

  }
  
  Future<List<OrderProduct>> getCartProducts() {

  }
  
  Future<void> addProductOnCart(OrderProduct orderProduct) {

  }
  
  Future<void> updateCartProduct(OrderProduct orderProduct) {

  }
  
  Future<void> deleteCartProduct(String productId) {

  }
  
}