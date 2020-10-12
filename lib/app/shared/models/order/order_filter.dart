import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'order_status.dart';

class OrderFilter {
  List<OrderStatus> status;
  double minPrice;
  double maxPrice;
  DateTime minDate;
  DateTime maxDate;

  OrderFilter({
    this.status,
    this.minPrice,
    this.maxPrice,
    this.minDate,
    this.maxDate,
  });

  OrderFilter copyWith({
    List<OrderStatus> status,
    double minPrice,
    double maxPrice,
    DateTime minDate,
    DateTime maxDate,
  }) {
    return OrderFilter(
      status: status ?? this.status,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minDate: minDate ?? this.minDate,
      maxDate: maxDate ?? this.maxDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status?.map((x) => x?.name)?.toList(),
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'minDate': minDate?.toString(),
      'maxDate': maxDate?.toString(),
    };
  }

  factory OrderFilter.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return OrderFilter(
      status: List<OrderStatus>.from(map['status']?.map((x) => OrderStatus.valueOf(x)) ?? []),
      minPrice: map['minPrice'],
      maxPrice: map['maxPrice'],
      minDate: DateTime.tryParse(map['minDate'] ?? ''),
      maxDate: DateTime.tryParse(map['maxDate'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderFilter.fromJson(String source) => 
    OrderFilter.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() {
    return 'OrderFilter(status: $status, minPrice: $minPrice, maxPrice: $maxPrice, minDate: $minDate, maxDate: $maxDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is OrderFilter &&
      listEquals(o.status, status) &&
      o.minPrice == minPrice &&
      o.maxPrice == maxPrice &&
      o.minDate == minDate &&
      o.maxDate == maxDate;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      minPrice.hashCode ^
      maxPrice.hashCode ^
      minDate.hashCode ^
      maxDate.hashCode;
  }
}
