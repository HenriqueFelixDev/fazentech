import 'dart:convert';
import 'package:flutter/foundation.dart' show listEquals;

import 'category.dart';

class ProductFilter {
  List<int> categories;
  String search;
  double minPrice;
  double maxPrice;

  ProductFilter({
    this.categories = const [],
    this.search,
    this.minPrice,
    this.maxPrice,
  });

  ProductFilter copyWith({
    List<int> categories,
    String search,
    double minPrice,
    double maxPrice,
  }) {
    return ProductFilter(
      categories: categories ?? this.categories,
      search: search ?? this.search,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories,
      'search': search,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
    };
  }

  factory ProductFilter.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProductFilter(
      categories: List<int>.from(map['categories'] ?? []),
      search: map['search'],
      minPrice: map['minPrice'],
      maxPrice: map['maxPrice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductFilter.fromJson(String source) => 
    ProductFilter.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() {
    return 'ProductFilter(categories: $categories, search: $search, minPrice: $minPrice, maxPrice: $maxPrice)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProductFilter &&
      listEquals(o.categories, categories) &&
      o.search == search &&
      o.minPrice == minPrice &&
      o.maxPrice == maxPrice;
  }

  @override
  int get hashCode {
    return categories.hashCode ^
      search.hashCode ^
      minPrice.hashCode ^
      maxPrice.hashCode;
  }
}
