import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/repositories/order/order_repository_interface.dart';
import 'package:rxdart/rxdart.dart';

class OrderController {
  final IOrderRepository _orderRepository;
  OrderController(this._orderRepository);

  List<Order> _orders = [];
  final _ordersSubject = BehaviorSubject<List<Order>>.seeded([]);
  Stream<List<Order>> get orders => _ordersSubject.stream;

  Future<void> searchOrders() async {
    final orders = await _orderRepository.getOrders(null);
    _updateOrders(orders);
  }

  void _updateOrders(List<Order> orders) {
    _orders = orders;
    _ordersSubject.sink.add(_orders);
  }
}