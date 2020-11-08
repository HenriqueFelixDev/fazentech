import 'package:fazentech/app/shared/services/http/http_client_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'order_repository_interface.dart';
import '../auth/auth_repository_interface.dart';
import '../../models/product/product.dart';
import '../../models/order/order_product.dart';
import '../../models/order/order_filter.dart';
import '../../models/order/order.dart';

class OrderRepositoryAPI implements IOrderRepository {
  final _authRepository = Modular.get<IAuthRepository>();
  final httpClient = Modular.get<IHttpClient>();

  @override
  Future<Order> getOrderById(String id) {
    // TODO: implement getOrderById
    throw UnimplementedError();
  }
  
  Future<Order> getCart() async{
    final token = await _authRepository.getAuthenticationToken();
    final cartMap = await httpClient.get('/cart', headers: {'Authorization': 'Bearer $token'});
    if(cartMap != null) {
      return Order.fromMap(cartMap);
    }
    return null;
  }

  @override
  Future<List<Order>> getOrders(OrderFilter filter) async{
    final token = await _authRepository.getAuthenticationToken();
    final ordersMap = await httpClient.get('/orders', headers: {'Authorization': 'Bearer $token'});
    if(ordersMap != null) {
      return ordersMap?.map<Order>(
        (orderMap) => Order.fromMap(orderMap)
      )?.toList();
    }
    return [];
  }

  @override
  Future<void> saveOrder() {
    // TODO: implement saveOrder
    throw UnimplementedError();
  }

  @override
  Future<void> updateOrder(Order order) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }

  @override
  Future<void> insertProductOnCart(Product product, [int quantity = 1]) async{
    final token = await _authRepository.getAuthenticationToken();
    await httpClient.post(
      '/cart/products', 
      headers: {'Authorization': 'Bearer $token'}, 
      body: {'productId': product.id, 'quantity': quantity.toString()}
    );
  }

  @override
  Future<void> deleteCartProduct(Product product) async{
    final token = await _authRepository.getAuthenticationToken();
    await httpClient.delete(
      '/cart/products/${product.id}', 
      headers: {'Authorization': 'Bearer $token'}
    );
  }

  @override
  Future<void> updateCartProduct(OrderProduct cartProduct) async{
    final token = await _authRepository.getAuthenticationToken();
    await httpClient.put(
      '/cart/products', 
      headers: {'Authorization': 'Bearer $token'}, 
      body: {'productId': cartProduct.product.id, 'quantity': cartProduct.quantity.toString()}
    );
  }
  
  Future<void> updateCart(String paymentMethod, int installmentCount, String shipping) async{
    final token = await _authRepository.getAuthenticationToken();
    final map = {'paymentMethod': paymentMethod, 'installmentCount': installmentCount, 'shipping': shipping};
    await httpClient.put(
      '/cart', 
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode(map)
    );
  }

  Future<void> confirmCartOrder() async{
    final token = await _authRepository.getAuthenticationToken();
    print('PASSOU 1');
    await httpClient.post(
      '/cart/confirm', 
      headers: {'Authorization': 'Bearer $token'},
      onError: (code, body) => print(body)
    );
    print('PASSOU 2');
  }

}