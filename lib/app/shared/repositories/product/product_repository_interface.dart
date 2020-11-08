import '../../models/product/product.dart';
import '../../models/product/product_filter.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts(ProductFilter filter);
  Future<List<Product>> getTopProducts();
  Future<List<Product>> getRecentlyAddedProducts();
  Future<Product> getProductById(String id);
}