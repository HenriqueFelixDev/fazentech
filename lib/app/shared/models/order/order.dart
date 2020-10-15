import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'order_product.dart';
import 'order_status.dart';

class Order {
  String id;
  DateTime createdIn;
  List<OrderProduct> products;
  OrderStatus status;

  Order({
    this.id,
    this.products,
    this.createdIn,
    String status
  }) : this.status = OrderStatus.valueOf(status);

  Order copyWith({
    String id,
    DateTime createdIn,
    List<OrderProduct> products,
    String status
  }) {
    return Order(
      id: id ?? this.id,
      createdIn: createdIn ?? this.createdIn,
      products: products ?? this.products,
      status: status ?? this.status.name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdIn': createdIn?.toString(),
      'products': products?.map((x) => x?.toMap())?.toList(),
      'status': status.name
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Order(
      id: map['id'],
      createdIn: DateTime.tryParse(map['createdIn']),
      products: List<OrderProduct>.from(map['products']?.map((x) => OrderProduct.fromMap(x)) ?? []),
      status: map['status'] ?? ''
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
  String toString() => 'Order(id: $id, createdIn: $createdIn, products: $products, status: $status)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Order &&
      o.id == id &&
      o.createdIn == createdIn &&
      listEquals(o.products, products) && 
      o.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ 
    createdIn.hashCode ^ 
    products.hashCode ^
    status.hashCode;
}
