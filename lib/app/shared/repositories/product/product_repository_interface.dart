import 'package:fazentech/app/shared/models/order/order_product.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/models/product/product_filter.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_interface.dart';

abstract class IProductRepository {
  ICategoryRepository categoryRepository;
  Future<List<Product>> getProducts(ProductFilter filter);
  Future<Product> getProductById(String id);
  Future<List<OrderProduct>> getOrderProducts(String orderId);
  Future<List<OrderProduct>> getCartProducts();
  Future<void> addProductOnCart(OrderProduct orderProduct);
  Future<void> updateCartProduct(OrderProduct orderProduct);
  Future<void> deleteCartProduct(String productId);
}