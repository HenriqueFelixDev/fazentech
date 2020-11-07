import '../../models/order/order_product.dart';
import '../../models/product/product.dart';
import '../../models/product/product_filter.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts(ProductFilter filter);
  Future<List<Product>> getTopProducts();
  Future<List<Product>> getRecentlyAddedProducts();
  Future<Product> getProductById(String id);
  Future<List<OrderProduct>> getOrderProducts(String orderId);
  Future<List<OrderProduct>> getCartProducts();
  Future<void> addProductOnCart(OrderProduct orderProduct);
  Future<void> updateCartProduct(OrderProduct orderProduct);
  Future<void> deleteCartProduct(String productId);
}