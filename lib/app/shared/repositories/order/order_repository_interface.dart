import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/models/order/order_filter.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_interface.dart';

abstract class IOrderRepository {
  IProductRepository productRepository;
  
  Future<void> saveOrder();
  Future<void> updateOrder(Order order);
  Future<List<Order>> getOrders(OrderFilter filter);
  Future<Order> getOrderById(String id);
}