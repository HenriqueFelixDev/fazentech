import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'order_product.dart';
import 'order_status.dart';

class Order {
  String id;
  DateTime createdIn;
  List<OrderProduct> products;
  OrderStatus status;
  double total;

  Order({
    this.id,
    this.products,
    this.createdIn,
    String status,
    this.total
  }) : this.status = OrderStatus.valueOf(status);

  Order copyWith({
    String id,
    DateTime createdIn,
    List<OrderProduct> products,
    String status,
    double total
  }) {
    return Order(
      id: id ?? this.id,
      createdIn: createdIn ?? this.createdIn,
      products: products ?? this.products,
      status: status ?? this.status.name,
      total: total ?? this.total
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_in': createdIn?.toString(),
      'products': products?.map((x) => x?.toMap())?.toList(),
      'status': status.name,
      'total': total
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Order(
      id: map['id'].toString(),
      createdIn: DateTime.tryParse(map['created_in']),
      products: List<OrderProduct>.from(map['products']?.map((x) => OrderProduct.fromMap(x)) ?? []),
      status: map['status'] ?? '',
      total: map['total'].toDouble()
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => 
    Order.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() => 'Order(id: $id, createdIn: $createdIn, products: $products, status: $status, total: $total)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Order &&
      o.id == id &&
      o.createdIn == createdIn &&
      listEquals(o.products, products) && 
      o.status == status &&
      o.total == total;
  }

  @override
  int get hashCode => id.hashCode ^ 
    createdIn.hashCode ^ 
    products.hashCode ^
    status.hashCode ^
    total.hashCode;
}
