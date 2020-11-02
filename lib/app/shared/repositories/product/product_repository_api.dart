import 'package:fazentech/app/shared/services/http/http_client_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'category_repository_interface.dart';
import '../../models/product/category.dart';
import '../../models/order/order_product.dart';
import '../../models/product/product.dart';
import '../../models/product/product_filter.dart';

import 'product_repository_interface.dart';

class ProductRepositoryAPI implements IProductRepository {
  ICategoryRepository categoryRepository;
  final httpClient = Modular.get<IHttpClient>();
  ProductRepositoryAPI(this.categoryRepository);

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
    final productsMap = await httpClient.get('/products$query');

    if(productsMap != null) {
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
    final topProductsMap = await httpClient.get('/products/top');
    
    if(topProductsMap != null) {
      return topProductsMap.map<Product>(
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
    final productsMap = await httpClient.get('/products/recently-added');

    if(productsMap != null) {
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