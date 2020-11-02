import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'order_repository_interface.dart';
import '../product/product_repository_interface.dart';
import '../auth/auth_repository_interface.dart';
import '../../models/product/product.dart';
import '../../models/order/order_product.dart';
import '../../models/order/order_filter.dart';
import '../../models/order/order.dart';

class OrderRepositoryAPI implements IOrderRepository {
  final _authRepository = Modular.get<IAuthRepository>(); 
  static const BASE_URL = 'http://10.0.0.106';
  
  @override
  IProductRepository productRepository;
  OrderRepositoryAPI(this.productRepository);

  @override
  Future<Order> getOrderById(String id) {
    // TODO: implement getOrderById
    throw UnimplementedError();
  }
  
  Future<Order> getCart() async{
    final token = await _authRepository.getAuthenticationToken();
    final response = await http.get('$BASE_URL/cart', headers: {'Authorization': 'Bearer $token'});
    if(response.statusCode >= 200 && response.statusCode < 300) {
      final cartMap = json.decode(response.body);
      return Order.fromMap(cartMap);
    }
    return null;
  }

  @override
  Future<List<Order>> getOrders(OrderFilter filter) async{
    final token = await _authRepository.getAuthenticationToken();
    final response = await http.get('$BASE_URL/orders', headers: {'Authorization': 'Bearer $token'});
    if(response.statusCode >= 200 && response.statusCode < 300) {
      final ordersMap = json.decode(response.body);
      return ordersMap?.map<Order>(
        (orderMap) => Order.fromMap(orderMap)
      )?.toList();
    }
    return null;
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
    final response = await http.post(
      '$BASE_URL/cart/products', 
      headers: {'Authorization': 'Bearer $token'}, 
      body: {'productId': product.id, 'quantity': quantity.toString()}
    );

    if(response.statusCode >= 300) {
      throw new Exception('Falha ao adicionar o produto');
    }
  }

  @override
  Future<void> deleteCartProduct(Product product) async{
    final token = await _authRepository.getAuthenticationToken();
    final response = await http.delete(
      '$BASE_URL/cart/products/${product.id}', 
      headers: {'Authorization': 'Bearer $token'}
    );

    if(response.statusCode >= 300) {
      throw new Exception('Falha ao remover o produto');
    }
  }

  @override
  Future<void> updateCartProduct(OrderProduct cartProduct) async{
    final token = await _authRepository.getAuthenticationToken();
    final response = await http.put(
      '$BASE_URL/cart/products', 
      headers: {'Authorization': 'Bearer $token'}, 
      body: {'productId': cartProduct.product.id, 'quantity': cartProduct.quantity.toString()}
    );

    if(response.statusCode >= 300) {
      throw new Exception('Falha ao atualizar o produto');
    }
  }

}