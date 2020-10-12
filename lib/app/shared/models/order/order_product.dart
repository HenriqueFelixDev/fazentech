import 'dart:convert';

import '../product/product.dart';

class OrderProduct {
  Product product;
  int quantity;
  DateTime createdIn;
  double price;
  OrderProduct({
    this.product,
    this.quantity,
    this.createdIn,
    this.price,
  });

  OrderProduct copyWith({
    Product product,
    int quantity,
    DateTime createdIn,
    double price,
  }) {
    return OrderProduct(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      createdIn: createdIn ?? this.createdIn,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product?.toMap(),
      'quantity': quantity,
      'createdIn': createdIn?.toString(),
      'price': price,
    };
  }

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return OrderProduct(
      product: Product.fromMap(map['product'] ?? {}),
      quantity: map['quantity'],
      createdIn: DateTime.tryParse(map['createdIn'] ?? ''),
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProduct.fromJson(String source) => 
    OrderProduct.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() {
    return 'OrderProduct(product: $product, quantity: $quantity, createdIn: $createdIn, price: $price)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is OrderProduct &&
      o.product == product &&
      o.quantity == quantity &&
      o.createdIn == createdIn &&
      o.price == price;
  }

  @override
  int get hashCode {
    return product.hashCode ^
      quantity.hashCode ^
      createdIn.hashCode ^
      price.hashCode;
  }
}
