import 'dart:convert';
import 'package:flutter/foundation.dart' show listEquals;

import 'category.dart';

class Product {
  String id;
  String name;
  String description;
  double price;
  List<String> images;
  Category category;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.images = const [],
    this.category,
  });

  Product copyWith({
    String id,
    String name,
    String description,
    double price,
    List<String> images,
    Category category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'category': category?.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      images: List<String>.from(map['images'] ?? []),
      category: Category.fromMap(map['category'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => 
    Product.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, images: $images, category: $category)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Product &&
      o.id == id &&
      o.name == name &&
      o.description == description &&
      o.price == price &&
      listEquals(o.images, images) &&
      o.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      images.hashCode ^
      category.hashCode;
  }
}
