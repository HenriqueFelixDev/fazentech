import '../product/product_repository_interface.dart';
import '../../models/order/order.dart';
import '../../models/order/order_filter.dart';
import '../../models/order/order_product.dart';
import '../../models/product/product.dart';

abstract class IOrderRepository {
  Future<void> saveOrder();
  Future<void> updateOrder(Order order);
  Future<List<Order>> getOrders(OrderFilter filter);
  Future<Order> getOrderById(String id);
  Future<Order> getCart();
  Future<void> updateCart(String paymentMethod, int installmentCount, String shipping);
  Future<void> confirmCartOrder();
  Future<void> insertProductOnCart(Product product, int quantity);
  Future<void> updateCartProduct(OrderProduct cartProduct);
  Future<void> deleteCartProduct(Product product);
}